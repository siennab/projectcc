import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_cc/model/user_ranking.dart';

class UserRankingService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> rankQuestion(UserRanking ranking) async {
    final userRankings = firestore.collection('/user_ranking');

    final existingRanking = userRankings
        .where('userId', isEqualTo: ranking.userId)
        .where('questionId', isEqualTo: ranking.questionId);

    final snapshot = await existingRanking.get()
      ..docs;

    if (snapshot.docs.isEmpty) {
      await userRankings.add(ranking.toJson());
      return;
    }

    userRankings.doc(snapshot.docs.first.id).update(ranking.toJson());
  }

  Future<List<UserRanking>> getUserRankings() async {
    final userId = await const FlutterSecureStorage().read(key: 'user_id');

    final userRankings = firestore
        .collection('/user_ranking')
        .where('userId', isEqualTo: userId);

    final rankings = await userRankings.get();
    return rankings.docs.map((e) => UserRanking.fromSnapshot(e, e.id)).toList();
  }
}
