import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edutainment_app/core/dio_config.dart';
import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/models/user_model.dart';
import 'package:provider/provider.dart';

class AuthRepository {
  final DioClient _dioClient = DioClient();

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {'email': email, 'password': password};

      print('📤 Logging in with: $data');

      var res = await _dioClient.post('${apiEndPoint}auth/login', data: data);

      if (res.statusCode == 200) {
        var userData = res.data['data']['user'];
        String token = res.data['data']['token'];

        _dioClient.setAuthToken(token);
        UserModel user = UserModel.fromJson(userData);

        print(user.name);
        return Right(user);
      }

      return const Left('Something went wrong');
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      print('❌ Status code: ${e.response?.statusCode}');
      print('❌ Response data: ${e.response?.data}');

      if (e.response != null) {
        final errorData = e.response!.data;

        // Laravel-style error messages
        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('message')) {
            return Left(errorData['message']);
          } else if (errorData.containsKey('errors')) {
            final errors = errorData['errors'] as Map<String, dynamic>;
            final firstField = errors.keys.first;
            final firstError = (errors[firstField] as List).first;
            return Left('$firstField: $firstError');
          }
        }
      }

      return Left('Login failed: ${e.message}');
    } catch (e) {
      print('❗ Other error: $e');
      return Left('$e');
    }
  }

  Future<Either<String, UserModel>> signup({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'image': image,
      };
      var res = await _dioClient.post('${apiEndPoint}auth/signup', data: data);
      if (res.statusCode == 200) {
        var data = res.data['data']['user'];
        String token = res.data['data']['token'];
        // await _dioClient.setAuthToken(token); // do not save token when sign up
        UserModel user = UserModel.fromJson(data);

        return Right(user);
      }
      return Left('Something went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      Map<String, dynamic> data = {
        'newPassword': newPassword,
        'oldPassword': oldPassword,
      };
      var res = await _dioClient.post(
        '${apiEndPoint}auth/changePassword',
        data: data,
      );
      if (res.statusCode == 200) {
        return Right(true);
      }
      return const Left('Someting went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> updateProfile({
    required String email,
    required String name,
    required File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'name': name,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      final res = await _dioClient.post(
        '${apiEndPoint}auth/updateProfile',
        data: formData,
        //  options: Options(contentType: 'multipart/form-data'),
      );

      if (res.statusCode == 200) {
        var data = res.data['data']['user'];
        UserModel user = UserModel.fromJson(data);
        return Right(user);
      }

      return const Left('Something went wrong');
    } catch (e) {
      print('Dio Error: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> addStudents({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'image': image,
      };
      var res = await _dioClient.post(
        '${apiEndPoint}auth/addStudent',
        data: data,
      );
      if (res.statusCode == 200) {
        var data = res.data['data']['student'];
        UserModel user = UserModel.fromJson(data);
        return Right(user);
      }
      return Left('Something went wrong');
    } catch (e) {
      print(e.toString);
      return Left(e.toString());
    }
  }

  Future<Either<String, List<UserModel>>> getStudent() async {
    try {
      var res = await _dioClient.get('${apiEndPoint}auth/getStudent');
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['student'];
        List<UserModel> students =
            data.map((e) => UserModel.fromJson(e)).toList();
        return Right(students);
      }
      return Left('SOmeting went wrong');
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  // pass student id to delete
  Future<Either<String, bool>> removeStudent({required int id}) async {
    try {
      var res = await _dioClient.get('${apiEndPoint}auth/removeStudent/$id');
      if (res.statusCode == 200) {
        return Right(true);
      }
      return Left('Someting went wrong');
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }
}
