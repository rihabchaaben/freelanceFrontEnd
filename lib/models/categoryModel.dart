import 'dart:convert';

CategoryModel categoryModelJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String userModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int id;
  String designation;
  CategoryModel({
    required this.id,
    required this.designation,
  });
  factory CategoryModel.fromJSON(Map<String, dynamic> parsedJson) {
    return CategoryModel(
      id: parsedJson['id'],
      designation: parsedJson['designation'],
    );
  }
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(designation: json["designation"], id: json["id"]);

  Map<String, dynamic> toJson() => {
        "designation": designation,
        'id': id,
      };

  /**String get aboutMe => aboutMe;

  double get price => price;
  int get rate => rate;
  Subcategory get subcategory => subcategory;
  int get id => id;**/
}
