import 'package:edutainment_app/models/question_model.dart';
import 'package:edutainment_app/models/quiz_model.dart';
import 'package:edutainment_app/models/word_puzzle_model.dart';
import 'package:edutainment_app/repository/quiz_repository.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  final QuizRepository _repository = QuizRepository();
  List<QuizModel> quizList = [];
  List<QuizModel> get getQuiz => quizList;
  List<QuestionModel> questionList = [];
  List<QuestionModel> get getQuestion => questionList;
  bool isLoading = true;
  List<WordPuzzleModel> _wordPuzzleList = [];
  List<WordPuzzleModel> get wordPuzzleList =>_wordPuzzleList;

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
      isLoading = true;
      var res = await _repository.getQuiz();
      res.fold(
        (l) {
          print(l);
          isLoading = false;
        },
        (r) {
          setQuizList = r;

          isLoading = false;
        },
      );
    } catch (e) {
      print('leee errrorrrr ${e.toString()}');
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

          print(getQuestion);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future fetchWordPuzzle() async{
    final result = await _repository.getWordPuzzle();
    result.fold((l){
      print(l);
    }, (r){
       print(r[0].id);
      _wordPuzzleList = r;
      print(_wordPuzzleList[0].id);
    });
    notifyListeners();
  }
}
