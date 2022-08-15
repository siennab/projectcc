import 'package:project_cc/screens/elections/elections_screen.dart';
import 'package:project_cc/screens/login/login_screen.dart';
import 'package:project_cc/screens/results/results_screen.dart';

import '../screens/survey/survey_screen.dart';

final routes = {
  '/': (context) => const LoginPage(),
  '/survey': (context) => const SurveyPage(),
  '/elections': (context) => const ElectionsPage(),
  '/results': (context) => const ResultsPage(),
};
