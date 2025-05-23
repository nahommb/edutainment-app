class WordPuzzleModel {
  final String question;
  final String answer;
  final int startIndex;
  final int endIndex;
  final int id;

  WordPuzzleModel({
    required this.answer,
    required this.endIndex,
    required this.question,
    required this.startIndex,
    required this.id,
  });

  factory WordPuzzleModel.fromJson(Map<String, dynamic> json) {
    return WordPuzzleModel(
      id: json['id'],
      answer: json['answer'],
      endIndex: json['endIndex'],
      question: json['question'],
      startIndex: json['startIndex'],
    );
  }
}
