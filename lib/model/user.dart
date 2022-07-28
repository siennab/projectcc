import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/user_ranking.dart';

class User {
  User({required this.id, required this.email, this.userRanking});
  final String id;
  final String email;

  UserRanking? userRanking;

  factory User.fromSnapshot(DocumentSnapshot snapshot, String id) {
    final question = User.fromJson(snapshot.data() as Map<String, dynamic>, id);

    return question;
  }

  factory User.fromJson(Map<String, dynamic> json, String id) {
    return User(id: id, email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'id': id,
    };
  }
}
