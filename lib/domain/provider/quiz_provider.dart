import 'package:edutainment_app/models/question_model.dart';
import 'package:edutainment_app/models/quiz_model.dart';
import 'package:edutainment_app/repository/quiz_repository.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  final QuizRepository _repository = QuizRepository();
  List<QuizModel> quizList = [];
  List<QuizModel> get getQuiz => quizList;
  List<QuestionModel> questionList = [];
  List<QuestionModel> get getQuestion => questionList;

  set setQuizList(List<QuizModel> value) {
    quizList = value;
    notifyListeners();
  }

  set setQuestion(List<QuestionModel> value) {
    questionList = value;
    notifyListeners();
  }

  Future fatchQuiz() async {
    try {
      var res = await _repository.getQuiz();
      res.fold(
        (l) {
          print(l);
        },
        (r) {
          setQuizList = r;
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future fatchQuestion(String slug) async {
    try {
      var res = await _repository.getQuizQuestions(slug: slug);
      res.fold(
        (l) {
          print(l);
        },
        (r) {
          setQuestion = r;
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
