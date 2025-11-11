// lib/models/park_time_slot.dart

class ParkTimeSlot {
  final String time; // 시간대 (예: '09:00 - 10:00')
  bool isAvailable; // 이용 가능 여부 (true: 가능, false: 불가능)

  ParkTimeSlot({
    required this.time,
    this.isAvailable = false,
  });

  // 데이터 저장을 위한 Map 형태로 변환 (선택 사항)
  Map<String, dynamic> toJson() => {
    'time': time,
    'isAvailable': isAvailable,
  };

  // Map 데이터를 ParkTimeSlot 객체로 변환 (선택 사항)
  factory ParkTimeSlot.fromJson(Map<String, dynamic> json) {
    return ParkTimeSlot(
      time: json['time'],
      isAvailable: json['isAvailable'] as bool,
    );
  }
}