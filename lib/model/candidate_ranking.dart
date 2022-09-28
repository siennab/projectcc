import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/question.dart';

class CandidateRanking {
  CandidateRanking(
      {required this.agree,
      required this.disagree,
      required this.ranking,
      required this.quesitonId});
  final bool agree;
  final bool disagree;
  final String quesitonId;
  final int ranking;
  Question? question;

  factory CandidateRanking.fromSnapshot(DocumentSnapshot snapshot) {
    final election =
        CandidateRanking.fromJson(snapshot.data() as Map<String, dynamic>);

    return election;
  }

  factory CandidateRanking.fromJson(Map<String, dynamic> json) {
    return CandidateRanking(
        quesitonId: json['questionId'].toString(),
        ranking: int.parse(json['questionAnswer'].toString()),
        agree: json['questionAnswer'].toString() == '1',
        disagree: json['questionAnswer'].toString() == '0');
  }
}
