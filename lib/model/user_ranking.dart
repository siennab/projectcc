import 'package:cloud_firestore/cloud_firestore.dart';

class UserRanking {
  UserRanking(
      {this.id,
      required this.userId,
      required this.questionId,
      required this.agree,
      required this.weight});
  final String? id;
  final String userId;
  final String questionId;
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
        userId: json['email'],
        questionId: json['questionId'],
        agree: json['agree'],
        weight: json['weight']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'questionId': questionId,
      'agree': agree,
      'weight': weight,
    };
  }
}
