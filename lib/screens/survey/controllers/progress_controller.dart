import 'package:flutter/material.dart';

class SurveyProgressController extends ChangeNotifier {
  var step = 0.0;
  var stepPercentage = 0.0;
  final int totalQuestions;

  SurveyProgressController({required this.totalQuestions});

  void incrementStep() {
    step++;
    stepPercentage = step / totalQuestions;
    notifyListeners();
  }

  void decrementStep() {
    step--;
    stepPercentage = step / totalQuestions;
    notifyListeners();
  }
}
