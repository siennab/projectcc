import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  Question({required this.id, required this.copy});
  final String id;
  final String copy;

  factory Question.fromSnapshot(DocumentSnapshot snapshot, String id) {
    final question =
        Question.fromJson(snapshot.data() as Map<String, dynamic>, id);

    return question;
  }

  factory Question.fromJson(Map<String, dynamic> json, String id) {
    return Question(id: id, copy: json['copy']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'copy': copy,
      'id': id,
    };
  }
}
