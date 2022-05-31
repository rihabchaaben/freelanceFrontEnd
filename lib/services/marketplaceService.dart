import 'package:dio/dio.dart';
import 'package:freelance/models/freelancerModel.dart';

import '../utils/logging.dart';

class MarketplaceController {
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'http://172.22.224.1:8080/api/auth',
      baseUrl: 'http://localhost:8080/api/auth',
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000,
      receiveDataWhenStatusError: true, // 60 seconds
    ),
  )..interceptors.add(Logging());
  late List<FreelancerModel> listVide = [];
  // ignore: non_constant_identifier_names
  Future<List<FreelancerModel>> fetchFreelancers() async {
    try {
      Response response = await _dio.get('/freelancers');
      if (response.statusCode == 200) {
        var getUsersData = response.data as List;
        var listUsers =
            getUsersData.map((i) => FreelancerModel.fromJSON(i)).toList();
        return listUsers;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
      return listVide;
    }
  }
}
