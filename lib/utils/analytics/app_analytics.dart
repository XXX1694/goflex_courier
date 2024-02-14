import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';

class AppAnalytics {
  static Future<void> requestTrackingAuthorization() async {
    try {
      await AppTrackingTransparency.requestTrackingAuthorization();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
