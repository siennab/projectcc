import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_cc/components/slider.dart';
import 'package:project_cc/model/question.dart';
import 'package:project_cc/model/user_ranking.dart';
import 'package:project_cc/services/user_ranking_service.dart';

class SurveyRanker extends StatelessWidget {
  const SurveyRanker({required this.question, required this.agree, Key? key})
      : super(key: key);
  final Question question;
  final bool? agree;
  @override
  Widget build(BuildContext context) {
    num rankingValue = 0.5;
    return Center(
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
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                '"${question.copy}"',
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
              child: CCSlider(
                onChanged: (num value) {
                  rankingValue = value;
                },
              ),
            ),
          ),
          TextButton(
              onPressed: () async {
                UserRankingService()
                    .rank(
                        agree: agree, question: question, weight: rankingValue)
                    .then((value) => Navigator.of(context).pop());
              },
              child: const Text('DONE'))
        ],
      ),
    );
  }
}
