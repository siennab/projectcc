import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_cc/screens/login/login_screen.dart';
import 'package:project_cc/screens/results/results_screen.dart';
import 'package:project_cc/screens/survey/survey_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Color(0xff333333),
            fontFamily: 'Montserrat',
          ),
          bodyText2: TextStyle(
            color: Color(0xff333333),
            fontFamily: 'Montserrat',
          ),
        ),
        primaryColor: const Color(0xffAD5A6F),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xffAD5A6F),
            secondary: Color(0Xff3E5266),
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
