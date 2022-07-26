import 'package:flutter/material.dart';
import 'package:project_cc/screens/login/login_screen.dart';
import 'package:project_cc/screens/results/results_screen.dart';
import 'package:project_cc/screens/survey/survey_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        primaryColor: const Color.fromARGB(255, 148, 68, 68),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromARGB(255, 148, 68, 68),
            secondary: Color.fromARGB(255, 68, 104, 148),
            onPrimary: Colors.white,
            error: Colors.black,
            onError: Colors.white,
            onSurface: Colors.white,
            onBackground: Colors.white10,
            background: Colors.white,
            surface: Colors.white10,
            onSecondary: Colors.white12),
      ),
    );
  }
}
