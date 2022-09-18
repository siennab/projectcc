import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/user_ranking.dart';

class User {
  User(
      {this.id,
      required this.email,
      required this.thirdPartyIdentifier,
      this.userRanking});
  final String? id;
  final String? email;
  final String thirdPartyIdentifier;

  UserRanking? userRanking;

  factory User.fromSnapshot(DocumentSnapshot snapshot, String id) {
    final question = User.fromJson(snapshot.data() as Map<String, dynamic>, id);

    return question;
  }

  factory User.fromJson(Map<String, dynamic> json, String id) {
    return User(
        id: id,
        email: json['email'],
        thirdPartyIdentifier: json['thirdPartyIdentifier']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'thirdPartyIdentifier': thirdPartyIdentifier,
      'id': id,
    };
  }
}
