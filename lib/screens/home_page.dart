import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Garmin Activity Reports")),

      body: const Center(
        child: Text("Coming in Part 2...", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
