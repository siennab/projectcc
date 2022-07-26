import 'package:flutter/material.dart';
import 'package:project_cc/screens/login/login_screen.dart';
import 'package:project_cc/screens/results/results_screen.dart';
import 'package:project_cc/screens/survey/survey_screen.dart';


void main() {

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project CC',
      routes: {
           '/': (context) => const LoginPage(),
    '/survey': (context) => const SurveyPage(),
      '/results': (context) => const ResultsPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}