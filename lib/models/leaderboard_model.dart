class LeaderboardModel {
  final List<Leaderboard> globalLeaderboard;
  final List<Leaderboard> monthlyLeaderboard;
  final List<Leaderboard> todayLeaderboard;

  LeaderboardModel(
      {required this.globalLeaderboard,
      required this.monthlyLeaderboard,
      required this.todayLeaderboard});

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
        globalLeaderboard: List<Leaderboard>.from(
            json['globalLeaderboard'].map((e) => Leaderboard.fromJson(e))),
        monthlyLeaderboard: List<Leaderboard>.from(
            json['monthlyLeaderboard'].map((e) => Leaderboard.fromJson(e))),
        todayLeaderboard: List<Leaderboard>.from(
            json['todayLeaderboard'].map((e) => Leaderboard.fromJson(e))));
  }
}

class Leaderboard {
  final String email;
  final String name;
  String? image;
  final String totalCorrect;

  Leaderboard(
      {required this.email,
      this.image,
      required this.name,
      required this.totalCorrect});

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
        email: json['email'],
        name: json['name'],
        totalCorrect: json['total_correct'],
        image: json['image']);
  }
}
