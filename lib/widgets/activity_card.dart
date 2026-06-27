import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int count;
  final double calories;

  const ActivityCard({
    super.key,
    required this.title,
    required this.icon,
    required this.count,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("Activities: $count"),
            Text("Calories: ${calories.toStringAsFixed(0)} kcal"),
          ],
        ),
      ),
    );
  }
}
