import 'package:dartz/dartz.dart';
import 'package:edutainment_app/core/dio_config.dart';
import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/models/question_model.dart';
import 'package:edutainment_app/models/quiz_model.dart';
import 'package:edutainment_app/models/word_puzzle_model.dart';

class QuizRepository {
  final DioClient _dioClient = DioClient();

  Future<Either<String, List<QuizModel>>> getQuiz() async {
    try {
      var res = await _dioClient.get('${apiEndPoint}getQuiz');
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['quiz'];
        List<QuizModel> quizs = data.map((e) => QuizModel.fromJson(e)).toList();
        return Right(quizs);
      }
      return const Left('Failed to load data');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<QuestionModel>>> getQuizQuestions({
    required String slug,
  }) async {
    try {
      var res = await _dioClient.get('${apiEndPoint}getQuizQuestions/$slug');
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['questions'];
        print(res.data);
        List<QuestionModel> questions =
            data.map((e) => QuestionModel.fromJson(e)).toList();
        return Right(questions);
      }
      return const Left('Failed to load data');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<WordPuzzleModel>>> getWordPuzzle() async {
    try {
      var res = await _dioClient.get('${apiEndPoint}getWordPuzzle');
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['puzzles'];
        List<WordPuzzleModel> puzzles =
            data.map((e) => WordPuzzleModel.fromJson(e)).toList();
        return Right(puzzles);
      }
      return Left('Someting went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
