import 'package:dartz/dartz.dart';
import 'package:edutainment_app/core/dio_config.dart';
import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/models/leaderboard_model.dart';

class LeaderboardRepository {
  final DioClient _dioClient = DioClient();

  Future<Either<String, LeaderboardModel>> getLaderbaord() async {
    try {
      var res = await _dioClient.get('${apiEndPoint}getLaderbaord');
      if (res.statusCode == 200) {
        var data = res.data['data'];
        LeaderboardModel model = LeaderboardModel.fromJson(data);
        return Right(model);
      }
      return const Left('Failed to load data');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> setLeaderboard({
    required int correctAnswer,
    required int wrongAnswer,
    required int quizId,
  }) async {
    try {
      Map<String, dynamic> data = {
        'wrongAnswer': wrongAnswer,
        'correctAnswer': correctAnswer,
        'quizId': quizId
      };
      var res =
          await _dioClient.post('${apiEndPoint}setLeaderboard', data: data);
      if (res.statusCode == 200) {
        return Right(true);
      }
      return const Left('Someting went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
