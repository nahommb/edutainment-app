class WordPuzzleModel {
  final String question;
  final String answer;
  final int startIndex;
  final endIndex;

  WordPuzzleModel({
    required this.answer,
    required this.endIndex,
    required this.question,
    required this.startIndex,
  });

  factory WordPuzzleModel.fromJson(Map<String, dynamic> json) {
    return WordPuzzleModel(
      answer: json['answer'],
      endIndex: json['endIndex'],
      question: json['question'],
      startIndex: json['startIndex'],
    );
  }
}
