// navi_model.dart

class NaviModel {
  final String destinationName; // 목적지 주차장 이름
  final String destinationAddress; // 목적지 주소
  final int remainingDistanceKm; // 남은 거리 (km)
  final int estimatedTimeMin; // 예상 소요 시간 (분)
  final String currentInstruction; // 현재 안내 문구
  final String nextInstruction; // 다음 안내 문구
  final String bookedTime; // 예약된 이용 시간 정보

  NaviModel({
    required this.destinationName,
    required this.destinationAddress,
    required this.remainingDistanceKm,
    required this.estimatedTimeMin,
    required this.currentInstruction,
    required this.nextInstruction,
    required this.bookedTime,
  });
}