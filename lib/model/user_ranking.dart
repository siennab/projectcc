class UserRanking {
  UserRanking(
      {required this.id,
      required this.userId,
      required this.questionId,
      required this.agree,
      required this.weight});
  final int id;
  final int userId;
  final int questionId;
  final bool agree;
  final num weight;
}
