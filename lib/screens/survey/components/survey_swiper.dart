import 'package:flutter/material.dart';
import 'package:project_cc/components/card.dart';
import 'package:project_cc/components/full_size_dialog.dart';
import 'package:project_cc/model/question.dart';
import 'package:project_cc/screens/survey/components/survey_progress.dart';
import 'package:project_cc/screens/survey/components/survey_ranker.dart';
import 'package:project_cc/screens/survey/controllers/progress_controller.dart';
import 'package:project_cc/services/user_ranking_service.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SurveySwiper extends StatefulWidget {
  const SurveySwiper({required this.questions, Key? key}) : super(key: key);

  final List<Question> questions;

  @override
  State<SurveySwiper> createState() => _SurveySwiperState();
}

class _SurveySwiperState extends State<SurveySwiper> {
  late SurveyProgressController _surveyProgressController;
  @override
  void initState() {
    super.initState();
    _surveyProgressController =
        SurveyProgressController(totalQuestions: widget.questions.length);
  }

  @override
  Widget build(BuildContext context) {
    var matchEngine = MatchEngine(
      swipeItems: widget.questions
          .map((e) => SwipeItem(
              content: Text(e.copy),
              likeAction: () async {
                UserRankingService()
                    .rank(agree: true, question: e, weight: 0.5);

                _surveyProgressController.incrementStep();
                //  _incrementStep();

                /// await _showGeneralDialog(e, true, context);
              },
              nopeAction: () async {
                UserRankingService()
                    .rank(agree: false, question: e, weight: 0.5);
                _surveyProgressController.incrementStep();

                //  _incrementStep();
                // await _showGeneralDialog(e, false, context);
              },
              superlikeAction: () {
                UserRankingService()
                    .rank(agree: null, question: e, weight: 0.5);
                _surveyProgressController.incrementStep();

                // _incrementStep();
              }))
          .toList(),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16),
          SurveyProgress(controller: _surveyProgressController),
          Expanded(child: Container()),
          Container(
            height: 230,
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Stack(
              children: [
                SizedBox(
                  //    height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: SwipeCards(
                    matchEngine: matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return PCard(
                        bottomWidget: Container(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Icon(
                                  Icons.speed,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                                    child:
                                        const Icon(Icons.thumb_down_outlined)),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 40,
                                child: TextButton(
                                    onPressed: () {
                                      matchEngine.currentItem?.superLike();
                                    },
                                    child:
                                        const Icon(Icons.psychology_outlined)),
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
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.questions[index].copy,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ],
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
          Expanded(child: Container()),
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
