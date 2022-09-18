import 'package:flutter/material.dart';
import 'package:project_cc/components/card.dart';
import 'package:project_cc/components/full_size_dialog.dart';
import 'package:project_cc/model/question.dart';
import 'package:project_cc/screens/survey/components/survey_ranker.dart';
import 'package:project_cc/services/user_ranking_service.dart';
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
                UserRankingService()
                    .rank(agree: true, question: e, weight: 0.5);

                /// await _showGeneralDialog(e, true, context);
              },
              nopeAction: () async {
                UserRankingService()
                    .rank(agree: false, question: e, weight: 0.5);

                // await _showGeneralDialog(e, false, context);
              },
              superlikeAction: () {
                UserRankingService()
                    .rank(agree: null, question: e, weight: 0.5);
              }))
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.speed,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  width: 40,
                  child: TextButton(
                      onPressed: () {
                        matchEngine.currentItem?.nope();
                      },
                      child: const Icon(Icons.thumb_down_outlined)),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 40,
                  child: TextButton(
                      onPressed: () {
                        matchEngine.currentItem?.superLike();
                      },
                      child: const Icon(Icons.psychology_outlined)),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 40,
                  child: TextButton(
                      onPressed: () {
                        matchEngine.currentItem?.like();
                      },
                      child: const Icon(Icons.thumb_up_outlined)),
                ),
              ],
            ),
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
