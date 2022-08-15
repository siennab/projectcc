import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/candidate.dart';

class Election {
  Election({required this.id, required this.name, required this.candidates});
  final String? id;
  final String name;
  List<Candidate>? candidates;

  factory Election.fromSnapshot(DocumentSnapshot snapshot, String id) {
    final election =
        Election.fromJson(snapshot.data() as Map<String, dynamic>, id);

    return election;
  }

  factory Election.fromJson(Map<String, dynamic> json, String? id) {
    final candidates = json['candidates'] as List<dynamic>?;
    return Election(
        id: id,
        name: json['name'],
        candidates: (candidates ?? [])
            .map((e) => Candidate.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
