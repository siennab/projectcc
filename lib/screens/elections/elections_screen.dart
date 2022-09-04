import 'package:flutter/material.dart';
import 'package:project_cc/components/loader.dart';
import 'package:project_cc/model/election.dart';
import 'package:project_cc/screens/election/election_screen.dart';
import 'package:project_cc/services/elections_service.dart';

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
    ElectionsService().getElections().then((res) {
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
                  : [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Choose an Election',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      ...elections
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      child: Text(e.name),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ElectionPage(election: e),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ))
                          .toList()
                    ]),
        ),
      ),
    );
  }
}
