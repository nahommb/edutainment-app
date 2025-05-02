import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edutainment_app/core/dio_config.dart';
import 'package:edutainment_app/core/endpoint.dart';
import 'package:edutainment_app/models/user_model.dart';

class AuthRepository {
  final DioClient _dioClient = DioClient();

  Future<Either<String, UserModel>> login(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };
      var res = await _dioClient.post('${apiEndPoint}auth/login', data: data);
      if (res.statusCode == 200) {
        var data = res.data['data']['user'];
        String token = res.data['data']['token'];
        _dioClient.setAuthToken(token);
        UserModel user = UserModel.fromJson(data);
        return Right(user);
      }
      return const Left('Someting went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> signup(
      {required String name,
      required String email,
      required String password,
      File? image}) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'image': image
      };
      var res = await _dioClient.post('${apiEndPoint}auth/signup', data: data);
      if (res.statusCode == 200) {
        var data = res.data['data']['user'];
        String token = res.data['data']['token'];
        await _dioClient.setAuthToken(token);
        UserModel user = UserModel.fromJson(data);

        return Right(user);
      }
      return Left('Someting went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      Map<String, dynamic> data = {
        'newPassword': newPassword,
        'oldPassword': oldPassword,
      };
      var res = await _dioClient.post('${apiEndPoint}auth/changePassword',
          data: data);
      if (res.statusCode == 200) {
        return Right(true);
      }
      return const Left('Someting went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> updateProfile(
      {required String email,
      required String name,
      required File? image}) async {
    try {
      Map<String, dynamic> data = {
        'email': email,
        'name': name,
        'image': image
      };
      var res =
          await _dioClient.post('${apiEndPoint}auth/updateProfile', data: data);
      if (res.statusCode == 200) {
        var data = res.data['data']['user'];
        UserModel user = UserModel.fromJson(data);
        return Right(user);
      }
      return const Left('Someting went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
