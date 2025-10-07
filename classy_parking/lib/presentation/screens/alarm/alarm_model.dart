class AlarmModel {
  final String id;
  final String content;
  final String time;
  final bool isRead;
  final AlarmType type;
  final String? imageUrl; // 프로필 이미지가 있는 경우

  AlarmModel({
    required this.id,
    required this.content,
    required this.time,
    required this.isRead,
    required this.type,
    this.imageUrl,
  });
}

enum AlarmType {
  payment,     // 결제 관련 알림
  reservation, // 예약/입차 관련 알림
  expiration,  // 주차 만료/연장 관련 알림
  exit,        // 출차 완료 알림
  availability // 주차장 혼잡도/잔여 자리 알림
}