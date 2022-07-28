import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/question.dart';

class QuestionService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Iterable<Question>> getQuestions() async {
    final questions = firestore.collection('/questions');

    final snapshot = await questions.get()
      ..docs;

    final data = snapshot.docs.map((element) {
      return Question.fromSnapshot(element, element.id);
    });

    return data;
  }
}
