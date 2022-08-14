import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/election.dart';

class ElectionsService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Iterable<Election>> getQuestions() async {
    final elections = firestore.collection('/elections');

    final snapshot = await elections.get()
      ..docs;

    final data = snapshot.docs.map((element) {
      return Election.fromSnapshot(element, element.id);
    });

    return data;
  }
}
