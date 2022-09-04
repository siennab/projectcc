import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/candidate_ranking.dart';

class Candidate {
  Candidate(
      {required this.name, required this.imageUrl, required this.positions});
  final String name;
  List<CandidateRanking>? positions;
  num score = 0;
  String? imageUrl;

  factory Candidate.fromSnapshot(DocumentSnapshot snapshot) {
    final election =
        Candidate.fromJson(snapshot.data() as Map<String, dynamic>);

    return election;
  }

  factory Candidate.fromJson(Map<String, dynamic> json) {
    final positions = json['positions'] as List<dynamic>?;
    return Candidate(
      name: json['name'],
      imageUrl: json['imageUrl'],
      positions: positions != null
          ? positions
              .map((e) => CandidateRanking.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}
