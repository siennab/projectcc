import 'package:flutter/material.dart';
import 'package:project_cc/components/full_size_dialog.dart';
import 'package:project_cc/model/question.dart';
import 'package:project_cc/screens/survey/components/survey_ranker.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SurveySwiper extends StatelessWidget {
  const SurveySwiper({required this.questions, Key? key}) : super(key: key);

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                          .map((e) => SwipeItem(
                                content: Text(e.copy),
                                likeAction: () async {
                                  await _showGeneralDialog(e, true, context);
                                },
                                nopeAction: () async {
                                  await _showGeneralDialog(e, false, context);
                                },
                              ))
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
                    upSwipeAllowed: true,
                    fillSpace: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showGeneralDialog(
      Question question, bool agree, BuildContext context) {
    return showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 280),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return CCFullSizeDialog(
          child: SurveyRanker(
            question: question,
            agree: agree,
          ),
        );
      },
    );
  }
}
