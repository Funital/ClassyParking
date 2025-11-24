// lib/viewmodels/report_view_model.dart

import 'dart:async';
import 'package:classy_parking/core/router/route_path.dart';
import 'package:classy_parking/presentation/screens/report/report_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportViewModel extends ChangeNotifier {
  // 싱글톤 패턴으로 전역 인스턴스 관리
  static final ReportViewModel _instance = ReportViewModel._internal();
  factory ReportViewModel() => _instance;

  ReportViewModel._internal();

  ReportModel _model = ReportModel();
  ReportModel get model => _model;

  Timer? _reportTimer;
  static const int requiredDelaySeconds = 10;

  @override
  void dispose() {
    _reportTimer?.cancel();
    super.dispose();
  }

  // --- 입력 필드 업데이트 함수 ---

  void updateCarNumber(String value) {
    _model = _model.copyWith(carNumber: value);
    notifyListeners();
  }

  void updateLocation(String value) {
    _model = _model.copyWith(locationAddress: value);
    notifyListeners();
  }

  void updateViolationType(String value) {
    _model = _model.copyWith(violationType: value);
    notifyListeners();
  }

  void updateMemo(String value) {
    _model = _model.copyWith(memo: value);
    notifyListeners();
  }

  void updateImage(String value) {
    _model = _model.copyWith(imagePath: value);
    notifyListeners();
  }

  // --- 메인 신고 로직 ---

  Future<void> handleReportSubmission(BuildContext context) async {
    if (_model.isSubmitting) return;

    // 1. 필수 입력값 검사
    if (_model.carNumber.isEmpty || _model.locationAddress.isEmpty || _model.violationType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('차량 번호, 위치, 위반 유형을 모두 입력해주세요.')),
      );
      return;
    }

    _model = _model.copyWith(isSubmitting: true);
    notifyListeners();

    try {
      if (_model.currentStep == ReportStep.initial) {
        await _processFirstReport(context);
      } else if (_model.currentStep == ReportStep.firstReport) {
        await _processSecondReport(context);
      }
    } finally {
      _model = _model.copyWith(isSubmitting: false);
      notifyListeners();
    }
  }

  // 1차 신고 처리
  Future<void> _processFirstReport(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _model = _model.copyWith(
      currentStep: ReportStep.firstReport,
      firstReportTime: DateTime.now(),
      buttonText: '2차 신고 진행 (10초 후)',
    );
    notifyListeners();

    // 10초 타이머 시작
    _startReportTimer();

    // 알림창 띄우기
    await _showSecondReportAlert(context);
  }

  // 10초 대기 알림창
  Future<void> _showSecondReportAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('2차 신고 필요'),
          content: const Text(
            '신고의 신뢰도를 높이기 위해, 1분 후에 다시 한 번 신고를 진행해야 합니다.',
            style: TextStyle(height: 1.5),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop(); // 팝업만 닫기
                // 홈화면으로 이동 (선택사항)
                context.go('/'); // 또는 context.pop() 사용
              },
            ),
          ],
        );
      },
    );
  }

  // 10초 타이머 시작
  void _startReportTimer() {
    int remainingSeconds = requiredDelaySeconds;

    _reportTimer?.cancel();

    _reportTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        _model = _model.copyWith(
          buttonText: '2차 신고 진행하기',
        );
      } else {
        _model = _model.copyWith(
          buttonText: '2차 신고 (${remainingSeconds}초 남음)',
        );
        remainingSeconds--;
      }
      notifyListeners();
    });
  }

  // 2차 신고 처리
  Future<void> _processSecondReport(BuildContext context) async {
    final elapsed = DateTime.now().difference(_model.firstReportTime!).inSeconds;
    if (elapsed < requiredDelaySeconds) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아직 ${requiredDelaySeconds - elapsed}초 남았습니다.')),
      );
      return;
    }

    _model = _model.copyWith(currentStep: ReportStep.secondReport);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    context.push(RoutePath.report_success);

    // 상태 초기화
    resetReport();
  }

  // 신고 완료 후 상태 초기화 (필요시 호출)
  void resetReport() {
    _reportTimer?.cancel();
    _model = ReportModel();
    notifyListeners();
  }
}