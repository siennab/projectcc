import 'package:flutter/material.dart';
import 'package:project_cc/components/loader.dart';
import 'package:project_cc/model/user_ranking.dart';
import 'package:project_cc/services/user_ranking_service.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late List<UserRanking> rankings;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    UserRankingService().getUserRankings().then((res) {
      setState(() {
        rankings = res;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: isLoading
                  ? [const CCLoader()]
                  : rankings
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(e.question.copy),
                                      SizedBox(height: 4),
                                      Text(
                                        e.agree ? 'Agree' : 'Disagree',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              const Divider()
                            ],
                          ))
                      .toList()),
        ),
      ),
    );
  }
}
