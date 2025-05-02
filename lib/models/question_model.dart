import 'package:edutainment_app/models/option_model.dart';

class QuestionModel {
  final String question;
  String? image;
  final List<OptionModel> options;

  QuestionModel(
      {required this.question, required this.image, required this.options});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        question: json['question'],
        image: json['image'],
        options: List<OptionModel>.from(
            json['options'].map((option) => OptionModel.fromJson(option))));
  }
}
