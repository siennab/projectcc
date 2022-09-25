import 'package:flutter/material.dart';
import 'package:project_cc/screens/survey/controllers/progress_controller.dart';

class SurveyProgress extends StatefulWidget {
  const SurveyProgress({required this.controller, Key? key}) : super(key: key);

  final SurveyProgressController controller;

  @override
  State<SurveyProgress> createState() => _SurveyProgressState();
}

class _SurveyProgressState extends State<SurveyProgress> {
  var _stepPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _stepPercentage = widget.controller.stepPercentage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0,
            end: _stepPercentage,
          ),
          builder: (context, value, _) => LinearProgressIndicator(
            minHeight: 15,
            value: _stepPercentage,
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ));
  }
}
