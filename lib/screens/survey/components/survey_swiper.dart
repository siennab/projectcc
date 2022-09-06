import 'package:flutter/material.dart';
import 'package:project_cc/components/card.dart';
import 'package:project_cc/components/full_size_dialog.dart';
import 'package:project_cc/model/question.dart';
import 'package:project_cc/screens/survey/components/survey_ranker.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SurveySwiper extends StatelessWidget {
  const SurveySwiper({required this.questions, Key? key}) : super(key: key);

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    var matchEngine = MatchEngine(
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
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 250,
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: SwipeCards(
                    matchEngine: matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return PCard(
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
                      Navigator.of(context).pushNamed('/elections');
                    },
                    upSwipeAllowed: true,
                    fillSpace: true,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: ElevatedButton(
                    onPressed: () {
                      matchEngine.currentItem?.nope();
                    },
                    child: const Icon(Icons.thumb_down)),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 80,
                child: ElevatedButton(
                    onPressed: () {
                      matchEngine.currentItem?.like();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Icon(Icons.thumb_up)),
              ),
            ],
          )
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
