import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_cc/components/app_bar.dart';
import 'package:project_cc/components/bottom_bar.dart';
import 'package:project_cc/components/card.dart';
import 'package:project_cc/components/loader.dart';
import 'package:project_cc/model/candidate.dart';
import 'package:project_cc/model/question.dart';
import 'package:project_cc/model/user_ranking.dart';
import 'package:project_cc/services/questions_service.dart';
import 'package:project_cc/services/user_ranking_service.dart';
import 'package:collection/collection.dart';

class CandidatePage extends StatefulWidget {
  const CandidatePage({required this.candidate, Key? key}) : super(key: key);

  final Candidate candidate;

  @override
  State<CandidatePage> createState() => _CandidatePageState();
}

class _CandidatePageState extends State<CandidatePage> {
  bool isLoading = true;
  var percentFormat = NumberFormat("##%", "en_US");
  late List<Question> questions;
  late List<UserRanking> userRankings;

  @override
  void initState() {
    QuestionService().getQuestions().then((value) async {
      userRankings = await UserRankingService().getUserRankings();
      setState(() {
        questions = value.toList();
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CCAppBar(),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CCLoader())
            : (Center(
                child: Column(children: [
                if (widget.candidate.imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(widget.candidate.imageUrl!),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.candidate.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                ...questions.map((e) {
                  final question = widget.candidate.positions?.firstWhereOrNull(
                    (element) => element.quesitonId == e.id,
                  );

                  final userRanking = userRankings.firstWhereOrNull(
                    (element) => element.questionId == e.id,
                  );

                  final agree = question?.agree;
                  final disagree = question?.disagree;
                  final agreeCopy = agree == true
                      ? 'Agree'
                      : (disagree == true ? 'Disagree' : 'N/A');

                  final userAgreeCopy = userRanking?.agree == true
                      ? 'Agree'
                      : (userRanking?.disagree == true ? 'Disagree' : 'N/A');

                  return PCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.copy,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('${widget.candidate.name}: $agreeCopy'),
                        const SizedBox(height: 8),
                        Text('You: $userAgreeCopy')
                      ],
                    ),
                  );
                }),
              ]))),
      ),
      bottomNavigationBar: const PBottomBar(selectedIndex: 1),
    );
  }
}
