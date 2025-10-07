import 'package:flutter/material.dart';
import 'my_page_model.dart';

class MyPageViewModel extends ChangeNotifier {
  late MyPageModel _myPageModel;
  bool _isPushEnabled = true;
  bool _isMarketingAgreed = false;

  MyPageModel get myPageModel => _myPageModel;

  bool get isPushEnabled => _isPushEnabled;
  bool get isMarketingAgreed => _isMarketingAgreed;


  MyPageViewModel() {
    _myPageModel = const MyPageModel(
      nickname: 'Health Revolution',
      phoneNumber: '010-1234-5678',
      carType: '카니발',
      carName: '사랑',
      carNumber: '12가 3456',
      isLicenseUploaded: true,
      parkingStatus: '사용가능',
    );
  }

  // 예: 닉네임 업데이트 함수
  void updateNickname(String newName) {
    _myPageModel = MyPageModel(
      nickname: newName,
      phoneNumber: _myPageModel.phoneNumber,
      carType: _myPageModel.carType,
      carName: _myPageModel.carName,
      carNumber: _myPageModel.carNumber,
      isLicenseUploaded: _myPageModel.isLicenseUploaded,
      parkingStatus: _myPageModel.parkingStatus,
    );
    notifyListeners();
  }

  // 운전면허증 업로드 상태 변경
  void toggleLicenseStatus() {
    _myPageModel = MyPageModel(
      nickname: _myPageModel.nickname,
      phoneNumber: _myPageModel.phoneNumber,
      carType: _myPageModel.carType,
      carName: _myPageModel.carName,
      carNumber: _myPageModel.carNumber,
      isLicenseUploaded: !_myPageModel.isLicenseUploaded,
      parkingStatus: _myPageModel.parkingStatus,
    );
    notifyListeners();
  }

  void togglePushNotification(bool value) {
    _isPushEnabled = value;
    notifyListeners();
  }

  void toggleMarketingAgreement(bool value) {
    _isMarketingAgreed = value;
    notifyListeners();
  }
}