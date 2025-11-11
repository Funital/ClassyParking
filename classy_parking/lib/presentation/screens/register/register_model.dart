// lib/presentation/screens/register/register_model.dart

class RegisterModel {
  // --- 1단계: 기본 정보 ---
  String parkingName;
  String address;
  String detailAddress;
  String parkingType;
  String totalSpaces;

  // 지도 좌표 추가 (핀의 최종 위치)
  double? latitude;
  double? longitude;


  // --- 2단계: 운영 및 요금 정보 (추가) ---

  // 운영 시간
  String operationHours; // 예: "24시간 운영" 또는 "평일 09:00~18:00"

  // 기본 요금
  int? baseFee;      // 예: 1000원
  int? baseTime;     // 예: 30분

  // 추가 요금
  int? extraFee;     // 예: 500원
  int? extraTime;    // 예: 10분

  // 일일 최대 요금
  int? dailyMaxFee;

  // --- 생성자 ---
  RegisterModel({
    // 1단계 초기값
    this.parkingName = '',
    this.address = '',
    this.detailAddress = '',
    this.parkingType = '일반 주차장',
    this.totalSpaces = '',
    this.latitude,
    this.longitude,

    // 2단계 초기값
    this.operationHours = '',
    this.baseFee,
    this.baseTime,
    this.extraFee,
    this.extraTime,
    this.dailyMaxFee,
  });

  // 다음 단계의 정보를 포함하도록 확장되었습니다.
  @override
  String toString() {
    return 'RegisterModel(\n'
        '  Name: $parkingName, Address: $address,\n'
        '  LatLng: $latitude, $longitude,\n'
        '  BaseFee: $baseFee/$baseTime, DailyMax: $dailyMaxFee'
        ')';
  }
}