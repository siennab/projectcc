import 'package:flutter/material.dart';
import 'package:project_cc/components/loader.dart';
import 'package:project_cc/model/election.dart';
import 'package:project_cc/services/user_election_service.dart';

class ElectionPage extends StatefulWidget {
  const ElectionPage({required this.election, Key? key}) : super(key: key);

  final Election election;

  @override
  State<ElectionPage> createState() => _ElectionPageState();
}

class _ElectionPageState extends State<ElectionPage> {
  bool isLoading = true;
  late Election rankedElection;

  @override
  void initState() {
    super.initState();

    UserElectionService().rankUserElection(widget.election).then((value) {
      setState(() {
        rankedElection = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(child: CCLoader())
            : (Center(
                child: Column(
                    children: (rankedElection.candidates ?? [])
                        .map((e) => Column(
                              children: [
                                Text(
                                  e.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Score: ${e.score}'),
                                Divider()
                              ],
                            ))
                        .toList()),
              )),
      ),
    );
  }
}
