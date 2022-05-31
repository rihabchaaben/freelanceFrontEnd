// ignore_for_file: prefer_collection_literals, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freelance/models/subcategoryModel.dart';
import 'package:freelance/utils/logging.dart';

class DioCategory {
  List funcionariosList = <SubcategoryModel>[];

  // ignore: deprecated_member_use
  late Response response;
  Dio dio = new Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/api/auth',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  List subcategoriesList = <SubcategoryModel>[];
  String url = 'http://localhost:8080/api/auth/subcategories';

  List<SubcategoryModel> parseSubcategories(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<SubcategoryModel>((json) => SubcategoryModel.fromJson(json))
        .toList();
  }

  Future<List<SubcategoryModel>> fetchsubcategories() async {
    final response = await dio.get(url);

    // Use the compute function to run parsePhotos in a separate isolate.
    return parseSubcategories(response.data);
  }
}
