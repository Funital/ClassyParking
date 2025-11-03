// lib/models/info_model.dart (확장된 코드)

class InfoModel {
  // 닉네임 설정 필드 (기존)
  final String currentNickname;
  final String? validationMessage;
  final bool isNicknameValid;
  final bool isChecking;

  // 추가된 필드 (정보 수정 항목)
  final String phoneNumber;
  final String email;
  final String carNumber;
  final String carModel;
  final String passwordPlaceholder;

  InfoModel({
    // 닉네임 필드 (기존)
    required this.currentNickname,
    this.validationMessage,
    this.isNicknameValid = false,
    this.isChecking = false,

    // 정보 필드 (추가)
    this.phoneNumber = '010-1234-5678', // 더미 데이터
    this.email = 'hellosoongsil@example.com', // 더미 데이터
    this.carNumber = '123가 4567', // 더미 데이터
    this.carModel = '현대 쏘나타', // 더미 데이터
    this.passwordPlaceholder = '********', // 비밀번호는 보통 플레이스홀더로 표시
  });

  // 상태 변경을 위한 copyWith 패턴 (확장)
  InfoModel copyWith({
    String? currentNickname,
    String? validationMessage,
    bool? isNicknameValid,
    bool? isChecking,
    // 추가 필드 copyWith
    String? phoneNumber,
    String? email,
    String? carNumber,
    String? carModel,
    String? passwordPlaceholder,
  }) {
    return InfoModel(
      currentNickname: currentNickname ?? this.currentNickname,
      validationMessage: validationMessage ?? this.validationMessage,
      isNicknameValid: isNicknameValid ?? this.isNicknameValid,
      isChecking: isChecking ?? this.isChecking,

      // 추가 필드 복사
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      carNumber: carNumber ?? this.carNumber,
      carModel: carModel ?? this.carModel,
      passwordPlaceholder: passwordPlaceholder ?? this.passwordPlaceholder,
    );
  }
}