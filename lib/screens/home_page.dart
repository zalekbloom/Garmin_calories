import 'package:flutter/material.dart';
import '../services/health_service.dart';
import '../models/activity_summary.dart';

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
    _service.cleanDuplicates(data);

    final result = ActivitySummary();

    for (var item in data) {
      final type = item.typeString.toLowerCase();
      final calories = (item.value ?? 0).toDouble();

      if (type.contains("hiking")) {
        result.hikingCount++;
        result.hikingCalories += calories;
      }

      if (type.contains("swimming")) {
        result.swimmingCount++;
        result.swimmingCalories += calories;
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
          crossAxisAlignment: CrossAxisAlignment.start,
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

            if (summary != null) ...[
              Text("Hiking: ${summary!.hikingCount} activities"),
              Text("Hiking calories: ${summary!.hikingCalories}"),
              const SizedBox(height: 10),
              Text("Swimming: ${summary!.swimmingCount} activities"),
              Text("Swimming calories: ${summary!.swimmingCalories}"),
              const SizedBox(height: 10),
              Text("Total: ${summary!.totalCalories}"),
            ],
          ],
        ),
      ),
    );
  }
}
