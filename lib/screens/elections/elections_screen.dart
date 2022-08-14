import 'package:flutter/material.dart';
import 'package:project_cc/components/loader.dart';
import 'package:project_cc/components/switch.dart';
import 'package:project_cc/model/election.dart';
import 'package:project_cc/model/user_ranking.dart';
import 'package:project_cc/services/elections_service.dart';
import 'package:project_cc/services/user_ranking_service.dart';

class ElectionsPage extends StatefulWidget {
  const ElectionsPage({Key? key}) : super(key: key);

  @override
  State<ElectionsPage> createState() => _ElectionsPageState();
}

class _ElectionsPageState extends State<ElectionsPage> {
  late List<Election> elections;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ElectionsService().getQuestions().then((res) {
      setState(() {
        elections = res.toList();
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
                  : elections
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(e.name), const Divider()],
                          ))
                      .toList()),
        ),
      ),
    );
  }
}
