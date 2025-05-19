class SpellingPuzzleModel {
  final String answer;
  final String option;
  final String image;
  SpellingPuzzleModel({
    required this.answer,
    required this.option,
    required this.image,
  });

  factory SpellingPuzzleModel.fromJson(Map<String, dynamic> json) {
    return SpellingPuzzleModel(
      answer: json['answer'],
      option: json['option'],
      image: json['image'],
    );
  }
}

class SpellingOptionModel {
  String option;
  bool isVisable;
  int? selectedOption;
  SpellingOptionModel({
    required this.isVisable,
    required this.option,
    this.selectedOption,
  });
}
