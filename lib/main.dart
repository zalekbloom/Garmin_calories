import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const GarminActivityApp());
}

class GarminActivityApp extends StatelessWidget {
  const GarminActivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garmin Activity Reports',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomePage(),
    );
  }
}
