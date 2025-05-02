class LeardeboardModel {
  final List<Leardeboard> globalLeaderboard;
  final List<Leardeboard> monthlyLeaderboard;
  final List<Leardeboard> todayLeaderboard;

  LeardeboardModel(
      {required this.globalLeaderboard,
      required this.monthlyLeaderboard,
      required this.todayLeaderboard});

  factory LeardeboardModel.fromJson(Map<String, dynamic> json) {
    return LeardeboardModel(
        globalLeaderboard: List<Leardeboard>.from(
            json['globalLeaderboard'].map((e) => Leardeboard.fromJson(e))),
        monthlyLeaderboard: List<Leardeboard>.from(
            json['monthlyLeaderboard'].map((e) => Leardeboard.fromJson(e))),
        todayLeaderboard: List<Leardeboard>.from(
            json['todayLeaderboard'].map((e) => Leardeboard.fromJson(e))));
  }
}

class Leardeboard {
  final String email;
  final String name;
  String? image;
  final int totalCorrect;

  Leardeboard(
      {required this.email,
      this.image,
      required this.name,
      required this.totalCorrect});

  factory Leardeboard.fromJson(Map<String, dynamic> json) {
    return Leardeboard(
        email: json['email'],
        name: json['name'],
        totalCorrect: json['total_correct'],
        image: json['image']);
  }
}
