import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/user_ranking.dart';

class UserRankingService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> rankQuestion(UserRanking ranking) async {
    final userRankings = firestore.collection('/user_ranking');

    final existingRanking = userRankings
        .where('user_id', isEqualTo: ranking.userId)
        .where('question_id', isEqualTo: ranking.questionId);

    final snapshot = await existingRanking.get()
      ..docs;

    if (snapshot.docs.isEmpty) {
      await firestore.collection('/user_ranking').add(ranking.toJson());
      return;
    }

    userRankings.doc(snapshot.docs.first.id).update(ranking.toJson());
  }
}
