class OptionModel {
  final String option;
  final bool isCorrect;

  OptionModel({required this.option, required this.isCorrect});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      option: json['option'],
      isCorrect: int.parse(json['isCorrect']) == 1 ? true : false,
    );
  }
}
