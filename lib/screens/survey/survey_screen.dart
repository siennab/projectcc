import 'package:flutter/material.dart';
import 'package:project_cc/components/slider.dart';
import 'package:project_cc/model/question.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    questions = [
      Question(
          id: 'q_1',
          copy: 'I think that people should only be allowed to eat bananas'),
      Question(
          id: 'q_2',
          copy: 'I think that people should only be allowed to eat oranges'),
      Question(
          id: 'q_3',
          copy: 'I think that people should only be allowed to eat apples'),
      Question(
          id: 'q_4',
          copy: 'I think that people should only be allowed to eat carrots'),
      Question(
          id: 'q_5',
          copy:
              'I think that people should only be allowed to eat chicken wings'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              margin: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: SwipeCards(
                      matchEngine: MatchEngine(
                        swipeItems: questions
                            .map((e) => SwipeItem(content: Text(e.copy)))
                            .toList(),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            questions[index].copy,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                      onStackFinished: () {
                        /// navigate to profile
                        Navigator.of(context).pushNamed('/results');
                      },
                      itemChanged: (SwipeItem item, int index) async {
                        await _showGeneralDialog(questions[index - 1].copy);
                      },
                      upSwipeAllowed: true,
                      fillSpace: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showGeneralDialog(String questionText) {
    return showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 280),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'How important is this issue to you?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        '"$questionText"',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Material(
                      color: Theme.of(context).colorScheme.background,
                      child: const CCSlider(),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "DONE",
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
