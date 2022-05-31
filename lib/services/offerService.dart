import 'package:dio/dio.dart';
import 'package:freelance/models/offerModel.dart';
import 'package:freelance/utils/logging.dart';

class OfferController {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/api/auth',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  Future<OfferModel?> getOffer({required String id}) async {
    OfferModel? offer;

    try {
      Response offerData = await _dio.get('/offer/$id');

      print('User Info: ${offerData.data}');

      offer = OfferModel.fromJson(offerData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return offer;
  }

  Future<OfferModel?> createOffer({required OfferModel offerInfo}) async {
    OfferModel? retrievedOffer;

    try {
      Response response = await _dio.post(
        '/offer/create',
        data: offerInfo.toJson(),
      );

      print('Offer created: ${response.data}');

      retrievedOffer = OfferModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedOffer;
  }

  Future<OfferModel?> updateOffer({
    required OfferModel offerInfo,
    required String id,
  }) async {
    OfferModel? updatedOffer;

    try {
      Response response = await _dio.put(
        '/offer/update/$id',
        data: offerInfo.toJson(),
      );

      print('offer updated: ${response.data}');

      updatedOffer = OfferModel.fromJson(response.data);
    } catch (e) {
      print('Error updating offer: $e');
    }

    return updatedOffer;
  }

  Future<void> deleteOffer({required String id}) async {
    try {
      await _dio.delete('/offer/delete/$id');
      print('offer deleted!');
    } catch (e) {
      print('Error deleting offer: $e');
    }
  }
}
