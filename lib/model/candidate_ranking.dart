class CandidateRanking {
  CandidateRanking(
      {required this.id,
      required this.candidateId,
      required this.questionId,
      required this.agree,
      required this.weight});
  final int id;
  final int candidateId;
  final int questionId;
  final bool agree;
  final num weight;
}
