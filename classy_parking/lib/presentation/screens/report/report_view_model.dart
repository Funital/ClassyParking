// lib/viewmodels/report_view_model.dart

import 'dart:async';
import 'package:classy_parking/core/router/route_path.dart';
import 'package:classy_parking/presentation/screens/report/report_model.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart'; // go_router 사용 가정

class ReportViewModel extends ChangeNotifier {
  ReportModel _model = ReportModel();
  ReportModel get model => _model;

  // 1차 신고 후 10초 타이머
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
        // --- A. 1차 신고 처리 ---
        await _processFirstReport(context);
      } else if (_model.currentStep == ReportStep.firstReport) {
        // --- B. 2차 신고 처리 ---
        await _processSecondReport(context);
      }
    } finally {
      _model = _model.copyWith(isSubmitting: false);
      notifyListeners();
    }
  }

  // 1차 신고 처리 (알림창 띄우기)
  Future<void> _processFirstReport(BuildContext context) async {
    // 서버에 1차 신고 정보를 전송하거나 저장하는 로직 (선택 사항)
    await Future.delayed(const Duration(milliseconds: 500));

    // 1차 신고 성공 및 상태 업데이트
    _model = _model.copyWith(
      currentStep: ReportStep.firstReport,
      firstReportTime: DateTime.now(),
      buttonText: '2차 신고 진행 (10초 후)', // 임시 텍스트
    );
    notifyListeners();

    // 10초 알림창 띄우기
    await _showSecondReportAlert(context);

    // 10초 타이머 시작 (버튼 텍스트 업데이트)
    _startReportTimer();
  }

  // 10초 대기 알림창 (오류 수정 완료)
  Future<void> _showSecondReportAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('2차 신고 필요'),
          content: const Text(
            '신고의 신뢰도를 높이기 위해, 10초 후에 다시 한 번 신고를 진행해야 합니다.',
            style: TextStyle(height: 1.5),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                // 💡 수정: 팝업창만 닫고 현재 화면에 머물러 타이머가 진행되도록 수정
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 10초 타이머 시작 및 버튼 텍스트 업데이트
  void _startReportTimer() {
    int remainingSeconds = requiredDelaySeconds;

    _reportTimer?.cancel(); // 이전 타이머 취소

    _reportTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        _model = _model.copyWith(
          buttonText: '2차 신고 진행하기', // 10초 후 활성화
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

  // 2차 신고 처리 (성공 화면으로 이동)
  Future<void> _processSecondReport(BuildContext context) async {
    // 1. 시간 간격 검사
    final elapsed = DateTime.now().difference(_model.firstReportTime!).inSeconds;
    if (elapsed < requiredDelaySeconds) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아직 ${requiredDelaySeconds - elapsed}초 남았습니다. 잠시 후 다시 시도해주세요.')),
      );
      return;
    }

    // 2. 서버에 최종 신고 데이터 전송 (성공 로직)
    _model = _model.copyWith(currentStep: ReportStep.secondReport);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500)); // 서버 처리 시뮬레이션

    // 성공 화면으로 이동
    context.push(RoutePath.report_success);

    // 상태 초기화
    _model = ReportModel();
  }
}