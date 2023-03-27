import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:workout_generator_ai/workout_response.dart';

class WorkoutGenerator extends StatefulWidget {
  const WorkoutGenerator({super.key});

  @override
  State<WorkoutGenerator> createState() => _WorkoutGeneratorState();
}

class _WorkoutGeneratorState extends State<WorkoutGenerator> {
  int workoutDuration = 60;
  String fitnessGoal = 'Get stronger and lift more weight';
  String targetArea = 'Full Body';
  String fitnessLevel = 'Beginner';
  bool isLoading = false;
  bool isSubmitted = false;
  WorkoutResponse? workoutPlan;

  // Define a function to handle the form submission
  Future<void> submitForm() async {
    // Show a loading indicator
    setState(() {
      isLoading = true;
      isSubmitted = false;
    });

    try {
      // Send the user's preferences to a backend server or API
      // You can use a package like http or dio to make API calls
      // Replace the URL with your backend endpoint

      final response = await http.post(
        Uri.parse(
            'https://c1-europe.altogic.com/e:641d8eda61e9500f8bf56ff7/customWorkout'),
        body: {
          'fitnessGoal': fitnessGoal,
          'fitnessLevel': fitnessLevel,
          'targetArea': targetArea,
          'workoutDuration': workoutDuration.toString(),
        },
      );

      // Parse the response and create a WorkoutPlan object
      final workoutPlan = WorkoutResponse.fromJson(response.body);

      // Show the workout plan on the screen
      setState(() {
        isLoading = false;
        isSubmitted = true;
        this.workoutPlan = workoutPlan;
      });
    } catch (e) {
      // Handle errors
      print('Error: $e');
      setState(() {
        isLoading = false;
        isSubmitted = false;
        workoutPlan = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Create Your Workout',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Subtitle(text: 'Duration'),
              SliderTheme(
                data: const SliderThemeData(
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Slider(
                  value: workoutDuration.toDouble(),
                  min: 30,
                  max: 120,
                  onChanged: (value) {
                    setState(() {
                      workoutDuration = value.toInt();
                    });
                  },
                  label: '$workoutDuration minutes',
                  divisions: 6,
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                ),
              ),
              const Subtitle(text: 'Fitness Goal'),
              CupertinoSlidingSegmentedControl(
                groupValue: fitnessGoal,
                // ignore: prefer_const_literals_to_create_immutables
                children: {
                  'Get stronger and lift more weight': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Strength', style: TextStyle(fontSize: 12.0)),
                  ),
                  'Increase muscle mass and size': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:
                        Text('Bodybuilding', style: TextStyle(fontSize: 12.0)),
                  ),
                  'Practice powerlifting': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:
                        Text('Powerlifting', style: TextStyle(fontSize: 12.0)),
                  ),
                  'Tone muscle and lose weight': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:
                        Text('Muscle Tone', style: TextStyle(fontSize: 12.0)),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    fitnessGoal = value as String;
                  });
                },
              ),
              const Subtitle(text: 'Target Area'),
              CupertinoSlidingSegmentedControl(
                groupValue: targetArea,
                // ignore: prefer_const_literals_to_create_immutables
                children: {
                  'Full Body': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Full Body', style: TextStyle(fontSize: 12.0)),
                  ),
                  'Lower Body': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Lower Body', style: TextStyle(fontSize: 12.0)),
                  ),
                  'Upper Body': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Upper Body', style: TextStyle(fontSize: 12.0)),
                  ),
                  'Core': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Core', style: TextStyle(fontSize: 12.0)),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    targetArea = value as String;
                  });
                },
              ),
              const Subtitle(text: 'Fitness Experience'),
              CupertinoSlidingSegmentedControl(
                groupValue: fitnessLevel,
                // ignore: prefer_const_literals_to_create_immutables
                children: {
                  'Beginner': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Beginner', style: TextStyle(fontSize: 12.0)),
                  ),
                  'Intermediate': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:
                        Text('Intermediate', style: TextStyle(fontSize: 12.0)),
                  ),
                  'Advanced': const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Advanced', style: TextStyle(fontSize: 12.0)),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    fitnessLevel = value as String;
                  });
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: isLoading ? null : submitForm,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 46.0,
                    vertical: 24.0,
                  ),
                ),
                child: const Text('Submit'),
              ),
              const SizedBox(height: 16.0),
              if (isLoading)
                Column(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "This may take a few seconds to generate your workout plan. Please don't close the app.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              if (isSubmitted)
                Text(
                  'Workout Plan',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              if (isSubmitted)
                Center(
                  child: Html(
                      data: workoutPlan!.choices![0].message!.content!,
                      style: {
                        "body": Style(
                          textAlign: TextAlign.center,
                          fontSize: const FontSize(16.0),
                          color: Colors.black,
                        ),
                        "h1": Style(
                          textAlign: TextAlign.center,
                          fontSize: const FontSize(24.0),
                          color: Colors.black,
                        ),
                        "h2": Style(
                          textAlign: TextAlign.center,
                          fontSize: const FontSize(20.0),
                          color: Colors.black,
                        ),
                        "h3": Style(
                          textAlign: TextAlign.center,
                          fontSize: const FontSize(18.0),
                          color: Colors.black,
                        ),
                        "h4": Style(
                          textAlign: TextAlign.center,
                          fontSize: const FontSize(16.0),
                          color: Colors.black,
                        ),
                        "h5": Style(
                          textAlign: TextAlign.center,
                          fontSize: const FontSize(14.0),
                          color: Colors.black,
                        ),
                        "h6": Style(
                          textAlign: TextAlign.center,
                          fontSize: const FontSize(12.0),
                          color: Colors.black,
                        ),
                        "p": Style(
                          textAlign: TextAlign.center,
                          fontSize: const FontSize(16.0),
                          color: Colors.black,
                        ),
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  final String text;
  const Subtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
