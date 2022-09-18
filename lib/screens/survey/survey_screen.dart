import 'package:flutter/material.dart';
import 'package:project_cc/components/app_bar.dart';
import 'package:project_cc/components/bottom_bar.dart';
import 'package:project_cc/components/loader.dart';
import 'package:project_cc/model/question.dart';
import 'package:project_cc/screens/survey/components/survey_swiper.dart';
import 'package:project_cc/services/questions_service.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late List<Question> questions;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    QuestionService().getQuestions().then((value) {
      setState(() {
        questions = value.toList();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CCAppBar(
        automaticallyImplyLeading: false,
      ),
      body: isLoading ? const CCLoader() : SurveySwiper(questions: questions),
      bottomNavigationBar: const PBottomBar(selectedIndex: 0),
    );
  }
}
