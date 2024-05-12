import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:goflex_courier/common/constants.dart';
import 'package:goflex_courier/features/orders/data/models/order_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

final _storage = SharedPreferences.getInstance();

class OrderRepository {
  getOrders() async {
    final dio = Dio();
    final url = mainUrl;

    final storage = await _storage;
    String? token = storage.getString('auth_token');
    final lat = storage.getDouble('current_lat');
    final lng = storage.getDouble('current_lng');
    String finalUrl =
        '${url}delivery/active/list/?latitude=$lat&longitude=$lng';

    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    Uri? uri = Uri.tryParse(finalUrl);
    // print(finalUrl);
    // print(token);
    if (uri != null) {
      try {
        final response = await dio.get(finalUrl);
        if (kDebugMode) {
          print(response.data);
        }
        if (kDebugMode) {
          print(response.statusCode);
        }
        if (response.statusCode == 200) {
          List data = response.data;
          List<OrderModel> orders = [];
          for (int i = 0; i < data.length; i++) {
            orders.add(OrderModel.fromJson(data[i]));
          }
          return orders;
        } else {
          return [];
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
