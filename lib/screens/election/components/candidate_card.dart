import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_cc/components/card.dart';
import 'package:project_cc/model/candidate.dart';
import 'package:project_cc/screens/candidate/candidate_screen.dart';

class CandidateCard extends StatelessWidget {
  CandidateCard({required this.candidate, Key? key}) : super(key: key);
  final Candidate candidate;
  final _percentFormat = NumberFormat("##%", "en_US");

  @override
  Widget build(BuildContext context) {
    return PCard(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CandidatePage(candidate: candidate),
              ),
            ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (candidate.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 48,
                      backgroundImage: NetworkImage(candidate.imageUrl!)),
                ),
              Text(
                candidate.name,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Score: ${_percentFormat.format(candidate.score)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LinearProgressIndicator(
                  minHeight: 5,
                  value: candidate.score.toDouble(),
                  backgroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ));
  }
}
