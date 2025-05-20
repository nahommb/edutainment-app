import 'package:flutter/cupertino.dart';

class UserModel {
  final int? id;
  final String name;
  final String email;
  String? image;
  final int? type;
  final int? status;

  UserModel(
      {
         required this.id,
        required this.email,
      this.image,
      required this.name,
        this.status,
     this.type});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: int.parse(json['id'].toString()),
        email: json['email'],
        image: json['image'],
        name: json['name'],
        status: int.parse(json['status'].toString()),
        type: int.parse(json['type'].toString()));
  }


}
