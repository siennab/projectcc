import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_cc/router/router.dart';
import 'package:project_cc/theme/theme.dart';

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
      routes: routes,
      theme: themeData,
    );
  }
}
