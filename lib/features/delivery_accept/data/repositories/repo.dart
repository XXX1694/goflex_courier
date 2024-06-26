import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:goflex_courier/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _storage = SharedPreferences.getInstance();

class AcceptDeliveryRepo {
  accept(int id) async {
    final dio = Dio();
    final url = mainUrl;
    String finalUrl = '${url}delivery/accept/$id/';
    final storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        final response = await dio.post(finalUrl);
        if (kDebugMode) {
          print(response.data);
        }
        if (kDebugMode) {
          print(response.statusCode);
        }
        if (response.statusCode == 200) {
          return 201;
        } else {
          return response.statusCode;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
