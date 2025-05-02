class OptionModel {
  final String option;
  final bool isCorrect;

  OptionModel({required this.option, required this.isCorrect});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
        option: json['option'], isCorrect: json['option'] == 1 ? true : false);
  }
}
