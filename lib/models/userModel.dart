import 'dart:convert';

import 'metaData.dart';

UserModel userModelJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  Metadata? metaData;

  int? id;
  String? username;
  String? fAdress;
  String? email;
  String? password;
  int? phone;
  String? image;
  String? roles;

  UserModel({
    this.metaData,
    this.id,
    this.username,
    this.fAdress,
    this.email,
    this.phone,
    this.password,
    this.image,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      metaData: json["metaData"],
      username: json["username"],
      fAdress: json["fAdress"],
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
      image: json["image"],
      roles: json["roles"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "metaData": metaData,
        "username": username,
        "fAdress": fAdress,
        "email": email,
        "password": password,
        "phone": phone,
        "image": image,
        "roles": roles,
        'id': id,
      };

  /**String get aboutMe => aboutMe;

  double get price => price;
  int get rate => rate;
  Subcategory get subcategory => subcategory;
  int get id => id;**/
}
