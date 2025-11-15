class MyPageModel {
  final String nickname;
  final String phoneNumber;
  final String carType;
  final String carName;
  final String carNumber;
  final bool isLicenseUploaded;
  final String parkingStatus;
  bool isPushNotificationEnabled;
  bool isPushMarketingEnabled;

  MyPageModel({
    required this.nickname,
    required this.phoneNumber,
    required this.carType,
    required this.carName,
    required this.carNumber,
    required this.isLicenseUploaded,
    required this.parkingStatus,
    this.isPushNotificationEnabled = true,
    this.isPushMarketingEnabled = true
  });
}
// lib/models/my_page_model.dart
//
// class MyPageModel {
//   final String nickname;
//   bool isPushNotificationEnabled;
//
//   MyPageModel({
//     required this.userName,
//     required this.userNickname,
//     this.isPushNotificationEnabled = true,
//   });
// }