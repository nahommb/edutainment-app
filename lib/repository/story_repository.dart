import 'package:dartz/dartz.dart';
import 'package:edutainment_app/core/dio_config.dart';
import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/models/story_model.dart';

class StoryRepository {
  final DioClient _dioClient = DioClient();

  Future<Either<String, List<StoryModel>>> getStory() async {
    try {
      var res = await _dioClient.get('${apiEndPoint}getStory');
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['story'];
        List<StoryModel> storys =
            data.map((e) => StoryModel.fromJson(e)).toList();
        // print(storys);
        return Right(storys);
      }
      return const Left('Failed to load data');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
