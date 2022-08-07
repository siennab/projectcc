import 'package:flutter/material.dart';

class SurveyRanker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              child: CCSlider(
                onChanged: (num value) {
                  // to do: save result
                },
              ),
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
    );
  }
}
