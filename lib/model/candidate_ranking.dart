import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/question.dart';

class CandidateRanking {
  CandidateRanking({required this.agree, required this.quesitonId});
  final num agree;
  final String quesitonId;
  Question? question;

  factory CandidateRanking.fromJson(Map<String, dynamic> json) {
    return CandidateRanking(
        quesitonId: json['questionId'], agree: json['agree']);
  }
}
