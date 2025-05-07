import 'package:flutter/cupertino.dart';

class UserModel {
  final String name;
  final String email;
  String? image;
  final int? type;
  final int? status;

  UserModel(
      {
        required this.email,
      this.image,
      required this.name,
        this.status,
      this.type});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        image: json['image'],
        name: json['name'],
        status: json['status'],
        type: json['type']);
  }


}
