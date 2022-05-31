import 'dart:convert';

import 'package:freelance/models/categoryModel.dart';

class SubcategoryModel {
  int id;
  String designation;
  CategoryModel category;

  SubcategoryModel({
    required this.id,
    required this.designation,
    required this.category,
  });
  factory SubcategoryModel.fromJSON(Map<String, dynamic> parsedJson) {
    return SubcategoryModel(
      id: parsedJson['id'],
      designation: parsedJson['designation'],
      category: CategoryModel.fromJSON(parsedJson['category']),
    );
  }
  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      SubcategoryModel(
          designation: json["designation"],
          category: json["category"],
          id: json["id"]);

  Map<String, dynamic> toJson() => {
        "designation": designation,
        "category": category,
        'id': id,
      };

  static List<SubcategoryModel> payloadFromJson(String str) =>
      List<SubcategoryModel>.from(
          json.decode(str).map((x) => SubcategoryModel.fromJson(x)));

  String payloadToJson(List<SubcategoryModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  /**String get aboutMe => aboutMe;

  double get price => price;
  int get rate => rate;
  Subcategory get subcategory => subcategory;
  int get id => id;**/
}
