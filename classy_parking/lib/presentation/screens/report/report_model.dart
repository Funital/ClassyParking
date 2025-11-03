// lib/models/report_model.dart

import 'package:latlong2/latlong.dart';

enum ReportStep {
  initial,    // 초기 상태 (0차 신고)
  firstReport, // 1차 신고 완료, 10초 대기 중
  secondReport, // 2차 신고 완료, 성공 처리 대기 중
}

class ReportModel {
  // 사용자가 입력한 신고 정보
  final String carNumber;
  final String locationAddress;
  final String violationType;
  final String? memo;
  final String? imagePath;

  // 신고 상태 관리
  final ReportStep currentStep;
  final DateTime? firstReportTime; // 1차 신고 시간

  // 신고 버튼 상태
  final bool isSubmitting; // 신고 처리 중 로딩 상태
  final String buttonText;

  ReportModel({
    this.carNumber = '',
    this.locationAddress = '',
    this.violationType = '',
    this.memo,
    this.imagePath,
    this.currentStep = ReportStep.initial,
    this.firstReportTime,
    this.isSubmitting = false,
    this.buttonText = '신고하기',
  });

  // 불변성을 위한 copyWith
  ReportModel copyWith({
    String? carNumber,
    String? locationAddress,
    String? violationType,
    String? memo,
    String? imagePath,
    ReportStep? currentStep,
    DateTime? firstReportTime,
    bool? isSubmitting,
    String? buttonText,
  }) {
    return ReportModel(
      carNumber: carNumber ?? this.carNumber,
      locationAddress: locationAddress ?? this.locationAddress,
      violationType: violationType ?? this.violationType,
      memo: memo ?? this.memo,
      imagePath: imagePath ?? this.imagePath,
      currentStep: currentStep ?? this.currentStep,
      firstReportTime: firstReportTime ?? this.firstReportTime,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}