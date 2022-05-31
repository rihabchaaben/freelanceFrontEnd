import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freelance/models/subcategoryModel.dart';

import 'metaData.dart';

FreelancerModel freelancerModelJson(String str) =>
    FreelancerModel.fromJson(json.decode(str));

String freelancerModelToJson(FreelancerModel data) =>
    json.encode(data.toJson());

class FreelancerModel {
  int? id;
  String? aboutMe;
  double? hourPrice;
  double? sessionPrice;
  int? rate;
  SubcategoryModel? subcategory;
  String? email;
  String? username;
  String? fAdress;
  String? password;
  int? phoneNum;
  String? roles;

  String? image;
  FreelancerModel({
    this.aboutMe,
    this.sessionPrice,
    this.hourPrice,
    this.id,
    this.rate,
    this.subcategory,
    this.email,
    this.fAdress,
    this.image,
    this.password,
    this.phoneNum,
    this.roles,
    this.username,
  });
  factory FreelancerModel.fromJSON(Map<String, dynamic> parsedJson) {
    return FreelancerModel(
      id: parsedJson['id'],
      username: parsedJson['username'],
      password: parsedJson['password'],
      email: parsedJson['email'],
      phoneNum: parsedJson['phoneNum'],
      image: parsedJson['image'],
      roles: parsedJson['roles'],
      fAdress: parsedJson['fAdress'],
      rate: parsedJson['rate'],
      aboutMe: parsedJson['aboutMe'],
      sessionPrice: parsedJson['sessionPrice'],
      hourPrice: parsedJson['hourPrice'],
      subcategory: SubcategoryModel.fromJSON(parsedJson['subcategory']),
    );
  }
  factory FreelancerModel.fromJson(Map<String, dynamic> json) =>
      FreelancerModel(
          username: json["username"],
          password: json["password"],
          phoneNum: json["phoneNum"],
          image: json["image"],
          roles: json["roles"],
          aboutMe: json["aboutMe"],
          sessionPrice: json["sessionPrice"],
          hourPrice: json["hourPrice"],
          rate: json["rate"],
          subcategory: json["subcategory"],
          id: json["id"],
          fAdress: json["fAdress"],
          email: json["email"]);

  Map<String, dynamic> toJson() => {
        "aboutMe": aboutMe,
        "sessionPrice": sessionPrice,
        "hourPrice": hourPrice,
        "rate": rate,
        "subcategory": subcategory,
        "email": email,
        "fAdress": fAdress,
        "roles": roles,
        "image": image,
        "phoneNum": phoneNum,
        "password": password,
        "username": username,

        // 'id': id,
      };

  /**String get aboutMe => aboutMe;

  double get price => price;
  int get rate => rate;
  Subcategory get subcategory => subcategory;
  int get id => id;**/
}
