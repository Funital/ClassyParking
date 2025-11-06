// prev_payment_model.dart

class ParkingProductModel {
  final String dayOfWeek;   // 요일 (예: "목", "토")
  final String title;       // 상품 제목 (예: "하루종일")
  final int price;          // 가격 (단위: 원)
  final String availableTime; // 이용 가능 시간 (예: "00:00 - 23:59")
  final void Function()? onSelect; // 선택 버튼 동작

  ParkingProductModel({
    required this.dayOfWeek,
    required this.title,
    required this.price,
    required this.availableTime,
    this.onSelect,
  });
}

class ParkingDetailModel {
  final String parkingName;      // 주차장 이름 (예: 안양빌라 주차장)
  final String locationDetail;   // 상세 위치 정보 (예: 투루파킹 안양빌라)
  final String hourlyRate;       // 시간당 요금 (예: 1시간 2,000원)
  final String distance;         // 현재 위치와의 거리 (예: 약 8분)
  final String imageUrl;         // 주차장 이미지 URL

  ParkingDetailModel({
    required this.parkingName,
    required this.locationDetail,
    required this.hourlyRate,
    required this.distance,
    required this.imageUrl,
  });
}

// **새로 추가된 모델: 검색 결과 항목**
class ParkingSearchModel {
  final String name; // 주차장 이름 (검색어와 동일한 텍스트)
  final String detail; // 주차장 상세 주소/정보 (검색 결과 리스트에 표시될 부가 정보)

  ParkingSearchModel({
    required this.name,
    required this.detail,
  });

  // 이 모델을 ParkingDetailModel로 변환하는 헬퍼 함수
  ParkingDetailModel toDetailModel() {
    return ParkingDetailModel(
      parkingName: name,
      locationDetail: "투루파킹 $name", // 예시로 "투루파킹"을 붙임
      hourlyRate: "1시간 2,000원",
      distance: "약 8분",
      imageUrl: "assets/parking_image.png",
    );
  }
}