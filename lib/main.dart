import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const GarminReportsApp());
}

class GarminReportsApp extends StatelessWidget {
  const GarminReportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Garmin Reports",

      debugShowCheckedModeBanner: false,

      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),

      home: const HomePage(),
    );
  }
}
