// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:goflex_courier/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _storage = SharedPreferences.getInstance();

class MainRepository {
  startWork() async {
    final dio = Dio();
    final url = mainUrl;
    String finalUrl = '${url}delivery/accept/';
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
        if (response.statusCode == 201) {
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

  createRoute({
    required double s_lat,
    required double s_long,
    required double d_lat,
    required double d_long,
  }) async {
    final dio = Dio();
    String finalUrl =
        'http://routing.api.2gis.com/routing/7.0.0/global?key=64cca5be-30f8-4772-8d5c-d64bab285c67';
    final storage = await _storage;
    String? token = storage.getString('auth_token');
    if (token == null) return null;
    dio.options.headers["authorization"] = "Token $token";
    Uri? uri = Uri.tryParse(finalUrl);
    if (uri != null) {
      try {
        final response = await dio.post(
          finalUrl,
          data: jsonEncode(
            {
              "points": [
                {
                  "type": "stop",
                  "lon": s_long,
                  "lat": s_lat,
                },
                {
                  "type": "stop",
                  "lon": d_long,
                  "lat": d_lat,
                }
              ],
              "locale": "ru",
              "transport": "car",
              "route_mode": "fastest",
              "traffic_mode": "jam"
            },
          ),
        );
        if (kDebugMode) {
          print(response.data);
        }
        if (response.statusCode == 200) {
          return [];
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
