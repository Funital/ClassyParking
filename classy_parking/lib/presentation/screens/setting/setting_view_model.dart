import 'package:flutter/material.dart';

class SettingViewModel extends ChangeNotifier {
  bool _isPushEnabled = true;
  bool _isMarketingAgreed = false;

  bool get isPushEnabled => _isPushEnabled;
  bool get isMarketingAgreed => _isMarketingAgreed;

  void togglePushNotification(bool value) {
    _isPushEnabled = value;
    notifyListeners();
  }

  void toggleMarketingAgreement(bool value) {
    _isMarketingAgreed = value;
    notifyListeners();
  }
}