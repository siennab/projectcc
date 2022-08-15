import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/election.dart';
import 'package:project_cc/services/user_ranking_service.dart';

class UserElectionService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Election> rankUserElection(Election election) async {
    final rankings = await UserRankingService().getUserRankings();
    election.candidates?.forEach((candidate) {
      candidate.score = 0;
      candidate.positions?.forEach((candidatePosition) {
        for (var userRanking in rankings) {
          if (candidatePosition.quesitonId == userRanking.questionId) {
            if (userRanking.agree == candidatePosition.agree) {
              candidate.score += 1;
            }
          }
        }
      });
    });

    election.candidates?.sort((a, b) => b.score.compareTo(a.score));

    return election;
  }
}
