import 'package:flutter/material.dart';
import 'package:workout_generator_ai/workout_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WorkoutGenerator(),
    );
  }
}
