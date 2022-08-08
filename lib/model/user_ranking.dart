import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/question.dart';

class UserRanking {
  UserRanking(
      {this.id,
      required this.userId,
      required this.question,
      required this.questionId,
      required this.agree,
      required this.weight});
  final String? id;
  final String userId;
  final String questionId;
  final Question question;
  final bool agree;
  final num weight;

  factory UserRanking.fromSnapshot(DocumentSnapshot snapshot, String id) {
    final question =
        UserRanking.fromJson(snapshot.data() as Map<String, dynamic>, id);

    return question;
  }

  factory UserRanking.fromJson(Map<String, dynamic> json, String id) {
    return UserRanking(
        id: id,
        userId: json['userId'],
        questionId: json['questionId'],
        question: Question.fromJson(json['question'], null),
        agree: json['agree'],
        weight: json['weight']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'questionId': questionId,
      'question': question.toJson(),
      'agree': agree,
      'weight': weight,
    };
  }
}
