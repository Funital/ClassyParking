import 'package:flutter/foundation.dart';

import 'my_page_model.dart';

class MyPageViewModel extends ChangeNotifier {
  // 초기 더미 데이터 설정
  final MyPageModel _model = MyPageModel(
    nickname: '홍길동',
    phoneNumber: '010-1234-5678',
    carType: '카니발',
    carName: '사랑',
    carNumber: '12가 3456',
    isLicenseUploaded: true,
    parkingStatus: '사용가능',
    isPushNotificationEnabled: true,
  );

  MyPageModel get model => _model;

  // // 푸시 알림 설정 토글
  // void togglePushNotification(bool newValue) {
  //   _model.isPushNotificationEnabled = newValue;
  //   notifyListeners();
  //
  //   // 실제 서버/로컬 설정 업데이트 로직이 여기에 들어갑니다.
  //   print('푸시 알림 상태 변경: $newValue');
  // }
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



  // 로그아웃 로직
  void logout() {
    // TODO: 인증 토큰 삭제, 상태 초기화, 로그인 화면으로 이동
    print('로그아웃 시도');
  }

  // 탈퇴하기 로직
  void deleteAccount() {
    // TODO: 사용자에게 경고 메시지 표시 후 계정 삭제 API 호출
    print('계정 탈퇴 시도');
  }

  // 기타 페이지 이동 로직 (더미)
  void navigateTo(String page) {
    print('$page 페이지로 이동합니다.');
    // 실제로는 Navigator.push 등을 사용하여 화면을 이동시킵니다.
  }
}