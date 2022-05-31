import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:freelance/models/customer.dart';
import 'package:freelance/models/freelancerModel.dart';
import 'package:freelance/models/login_model.dart';
import 'package:freelance/models/userModel.dart';
import 'package:freelance/utils/logging.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'http://172.22.224.1:8080/api/auth',
      baseUrl: 'http://localhost:8080/api/auth',
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000,
      receiveDataWhenStatusError: true, // 60 seconds
    ),
  )..interceptors.add(Logging());

  Future<UserModel?> createUser({required UserModel userInfo}) async {
    UserModel? retrievedUser;

    try {
      Response response = await _dio.post(
        '/signup',
        data: userInfo.toJson(),
      );

      print('Account successfuly created: ${response.data}');

      retrievedUser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }

  Future<FreelancerModel?> createFreelancer(
      {required FreelancerModel freelancerInfo}) async {
    FreelancerModel? retrievedUser;

    try {
      Response response = await _dio.post(
        '/signup',
        data: freelancerInfo.toJson(),
      );

      print('Account successfuly created: ${response.data}');

      retrievedUser = FreelancerModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }

  Future<UserModel?> loginUser({required UserModel userInfo}) async {
    UserModel? retrievedUser;
    String aToken = '';

    try {
      Response response = await _dio.post(
        '/signin',
        data: userInfo.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('User logged: ${response.data}');
      //  final cookies = response.headers.map['set-cookie'];
      // if (cookies!.isNotEmpty && cookies.length == 2) {}
      /**final authToken = cookies[1]
            .split(';')[0]; //it depends on how your server sending cookie
        //save this authToken in local storage, and pass in further api calls.

        aToken =
            authToken; //saving this to global variable to refresh current api calls to add cookie.
        print(aToken);
        // String rawCookie = response.headers['Set-Cookie'] as String;
        //print('token' + rawCookie);
        //print(cookies);*/

      retrievedUser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }

  Future<String?> logoutUser() async {
    try {
      Response response = await _dio.post(
        '/signout',
      );

      print('${response.data}');
    } catch (e) {
      print('Error in logout : ');
    }
  }

  Future<UserModel> getUser({required String id}) async {
    // Perform GET request to the endpoint "/users/<id>"
    Response userData = await _dio.get('/users/$id');

    // Prints the raw data returned by the server
    print('User Info: ${userData.data}');

    // Parsing the raw JSON data to the User class
    UserModel user = UserModel.fromJson(userData.data);

    return user;
  }

  Future<Customer?> customerRegister({required Customer customer}) async {
    Customer? retrievedUser;

    try {
      Response response = await _dio.post(
        '/signup',
        options: Options(headers: {"Accept": 'application/json'}),
        data: customer.toJson(),
      );

      print('User created: ${response.data}');

      retrievedUser = Customer.fromJson(response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(e.message);
    }

    return retrievedUser;
  }
}
