import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_cc/model/candidate.dart';
import 'package:project_cc/model/candidate_ranking.dart';
import 'package:project_cc/model/election.dart';

class ElectionsService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Iterable<Election>> getElections() async {
    final elections = firestore.collection('/elections');

    final snapshot = await elections.get()
      ..docs;

    final data = snapshot.docs.map((element) {
      final election = Election.fromSnapshot(element, element.id);
      getCandidates(element.id).then((value) {
        election.candidates = value;
      });
      return election;
    });

    return data;
  }

  Future<List<Candidate>> getCandidates(String electionId) async {
    final candidates =
        firestore.collection('/elections/$electionId/candidates');

    final snapshot = await candidates.get()
      ..docs;

    final data = snapshot.docs.map((element) {
      final candidate = Candidate.fromSnapshot(element);
      getCandidatePositions(electionId, element.id)
          .then((value) => candidate.positions = value);
      return candidate;
    });

    return data.toList();
  }

  Future<List<CandidateRanking>> getCandidatePositions(
      String electionId, String candidateId) async {
    final positions = firestore
        .collection('/elections/$electionId/candidates/$candidateId/positions');

    final snapshot = await positions.get()
      ..docs;

    final data = snapshot.docs.map((element) {
      final position = CandidateRanking.fromSnapshot(element);
      return position;
    });

    return data.toList();
  }
}
