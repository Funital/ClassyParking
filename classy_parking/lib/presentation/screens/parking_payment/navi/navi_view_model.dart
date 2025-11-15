// navi_view_model.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import '../../../../core/router/route_path.dart';
import 'navi_model.dart';

// 전달받을 예약 정보를 위한 클래스 (PrevPayViewModel의 SelectedProductInfo와 유사)
class BookedProductInfo {
  final String parkingName;
  final String productTitle;
  final String availableTime;

  BookedProductInfo({
    required this.parkingName,
    required this.productTitle,
    required this.availableTime,
  });
}
// -----------------------------------------------------------------


class NaviViewModel extends ChangeNotifier {
  late NaviModel _naviInfo;
  late Timer _timer;

  NaviModel get naviInfo => _naviInfo;

  NaviViewModel({required BookedProductInfo bookedInfo}) {
    // 1. 모델 초기 데이터 설정
    _naviInfo = NaviModel(
      destinationName: bookedInfo.parkingName,
      destinationAddress: "경기도 안양시 만안구 안양로 332",
      remainingDistanceKm: 15,
      estimatedTimeMin: 25,
      currentInstruction: "2km 앞에서 안양역 방면 오른쪽 차선으로 진입하세요.",
      nextInstruction: "다음 안내까지 1.5km 남았습니다.",
      bookedTime: "${bookedInfo.productTitle} (${bookedInfo.availableTime})",
    );

    // 2. 타이머 시작 (소요 시간과 거리 시뮬레이션을 위해 1초마다 업데이트)
    _startNavigationSimulation();
  }

  // 가상의 내비게이션 진행 시뮬레이션
  void _startNavigationSimulation() {
    // 1초마다 남은 시간/거리를 줄이는 시뮬레이션
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 5초마다 거리와 시간을 갱신하는 것으로 가정
      if (timer.tick % 5 == 0) {
        if (_naviInfo.remainingDistanceKm > 0) {
          _naviInfo = NaviModel(
            destinationName: _naviInfo.destinationName,
            destinationAddress: _naviInfo.destinationAddress,
            // 거리와 시간을 가상으로 감소
            remainingDistanceKm: _naviInfo.remainingDistanceKm - 1,
            estimatedTimeMin: _naviInfo.estimatedTimeMin - 1 < 1
                ? 1
                : _naviInfo.estimatedTimeMin - 1,
            currentInstruction: _naviInfo.currentInstruction,
            nextInstruction: _naviInfo.nextInstruction,
            bookedTime: _naviInfo.bookedTime,
          );
          notifyListeners();
        } else {
          // 목적지 도착 시 타이머 중지 및 도착 처리
          _timer.cancel();
          // 필요하다면 도착 화면으로 이동하는 로직 추가
          // goToArrivalScreen();
        }
      }
    });
  }

  // 화면 종료 시 타이머 해제
  @override
  void dispose() {
    // 내비게이션 종료 시 타이머를 반드시 해제합니다.
    _timer.cancel();
    super.dispose();
  }
}