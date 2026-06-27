import 'package:flutter/material.dart';
import '../services/health_service.dart';
import '../services/activity_classifier.dart';
import '../models/activity_summary.dart';
import '../widgets/activity_card.dart';
import 'package:health/health.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HealthService _service = HealthService();

  DateTime selectedDate = DateTime.now();
  bool loading = false;

  ActivitySummary? summary;

  Future<void> generateReport() async {
    setState(() {
      loading = true;
      summary = null;
    });

    final start = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    final end = start.add(const Duration(days: 1));

    final granted = await _service.requestPermissions();
    if (!granted) {
      setState(() => loading = false);
      return;
    }

    final data = await _service.fetchWorkouts(start, end);

    final result = ActivitySummary();

    for (var item in data) {
      if (item is! HealthWorkoutDataPoint) continue;

      final activity = ActivityClassifier.classify(item.workoutActivityType);
      final calories = (item.totalEnergyBurned ?? 0).toDouble();

      switch (activity) {
        case ActivityKind.hiking:
          result.hikingCount++;
          result.hikingCalories += calories;
          break;

        case ActivityKind.swimming:
          result.swimmingCount++;
          result.swimmingCalories += calories;
          break;

        case ActivityKind.other:
          break;
      }
    }

    setState(() {
      summary = result;
      loading = false;
    });
  }

  void pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Garmin Activity Reports")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text("${selectedDate.toLocal()}".split(' ')[0]),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: pickDate,
                  child: const Text("Pick Date"),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : generateReport,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Generate Report"),
              ),
            ),

            const SizedBox(height: 20),

            if (summary != null)
              Expanded(
                child: ListView(
                  children: [
                    ActivityCard(
                      title: "Hiking",
                      icon: Icons.terrain,
                      count: summary!.hikingCount,
                      calories: summary!.hikingCalories,
                    ),
                    ActivityCard(
                      title: "Swimming",
                      icon: Icons.pool,
                      count: summary!.swimmingCount,
                      calories: summary!.swimmingCalories,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
