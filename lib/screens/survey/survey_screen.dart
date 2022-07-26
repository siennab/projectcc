import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const Text(
              'Vote on issues',
            ),
             ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed('/results');
            }, child: const Text('See your results'))
          ],
        ),
      ),
    );
    }
  }