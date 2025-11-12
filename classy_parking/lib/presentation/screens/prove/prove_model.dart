// prove_model.dart

class ProveModel {
  // 현재 촬영할 단계 (1/3, 2/3 등)
  final int currentStep;

  // 전체 촬영 단계 수
  final int totalSteps;

  // 단계별 촬영 이미지 파일 경로를 저장하는 Map
  // Key: 사진 유형 (e.g., '정면', '측면', '후면')
  // Value: 이미지 파일 경로 (String)
  final Map<String, String> proofImages;

  ProveModel({
    required this.currentStep,
    required this.totalSteps,
    required this.proofImages,
  });

  // 복사 생성자 (불변성 유지를 위해)
  ProveModel copyWith({
    int? currentStep,
    Map<String, String>? proofImages,
  }) {
    return ProveModel(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps,
      proofImages: proofImages ?? this.proofImages,
    );
  }

  // 현재 촬영해야 할 사진 유형을 반환하는 헬퍼 함수
  String getCurrentProofType() {
    switch (currentStep) {
      case 1:
        return '정면';
      case 2:
        return '측면';
      case 3:
        return '후면';
      default:
        return '완료';
    }
  }
}