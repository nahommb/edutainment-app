class QuizModel {
  final int id;
  final String title;
  final String image;
  final String slug;
  final int status;
  final DateTime createdAt;

  QuizModel(
      {required this.title,
      required this.image,
      required this.slug,
      required this.createdAt,
      required this.id,
      required this.status});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
        title: json['title'],
        image: json['image'],
        slug: json['slug'],
        createdAt: DateTime.parse(json['created_at']),
        id: json['id'],
        status: json['status']);
  }
}
