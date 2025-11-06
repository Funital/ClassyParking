// lib/viewmodels/park_manage_view_model.dart

import 'package:flutter/foundation.dart';
import 'my_parking_manage_model.dart';

class MyParkingManageViewModel extends ChangeNotifier {
  final String parkingAddress = '서울시 강남구 테헤란로 123';

  // 🕒 시간대별 이용 가능 상태 리스트
  List<ParkTimeSlot> _timeSlots = [];
  List<ParkTimeSlot> get timeSlots => _timeSlots;

  // 📅 다이얼로그에서 임시로 선택된 시간 상태를 저장할 리스트
  List<bool> _dialogSelection = List.generate(24, (index) => false);
  List<bool> get dialogSelection => _dialogSelection;

  MyParkingManageViewModel() {
    _initializeTimeSlots();
  }

  void _initializeTimeSlots() {
    _timeSlots.clear();
    for (int i = 0; i < 24; i++) {
      String start = i.toString().padLeft(2, '0');
      String end = ((i + 1) % 24).toString().padLeft(2, '0');
      String timeRange = '$start:00 - $end:00';
      _timeSlots.add(ParkTimeSlot(time: timeRange, isAvailable: false));
    }
    _loadInitialState();
  }

  void _loadInitialState() {
    // 9시부터 18시까지 기본적으로 '이용 가능'으로 설정
    for (int i = 9; i < 18; i++) {
      _timeSlots[i].isAvailable = true;
    }
    // 초기 로드 시, 다이얼로그 선택 상태도 현재 저장된 상태와 동기화
    syncSelectionToCurrentSlots();
    notifyListeners();
  }

  // 현재 저장된 _timeSlots 상태를 다이얼로그 선택 상태로 동기화
  void syncSelectionToCurrentSlots() { // **_ 제거됨**
    _dialogSelection = _timeSlots.map((slot) => slot.isAvailable).toList();
  }

  // 📝 다이얼로그에서 특정 시간대의 임시 선택 상태를 변경합니다.
  void toggleDialogSelection(int index, bool newValue) {
    if (index >= 0 && index < _dialogSelection.length) {
      _dialogSelection[index] = newValue;
      // 다이얼로그 내부 상태 변경 시 UI 업데이트
      notifyListeners();
    }
  }

  // 🔄 다이얼로그의 임시 선택 상태를 실제 _timeSlots에 반영합니다.
  void applyDialogSelection() {
    for (int i = 0; i < _timeSlots.length; i++) {
      _timeSlots[i].isAvailable = _dialogSelection[i];
    }
    notifyListeners();
  }

  // 💾 현재 설정된 이용 가능 시간을 저장합니다. (로직 변경 없음, 다이얼로그로 상태 변경만 유도)
  Future<void> saveAvailability() async {
    print('--- 이용 가능 시간 저장 시작 ---');
    print('주차장 주소: $parkingAddress');

    final availableTimes = _timeSlots.where((slot) => slot.isAvailable).toList();

    if (availableTimes.isEmpty) {
      print('경고: 이용 가능한 시간이 없습니다.');
      // 실제 UI에서는 사용자에게 피드백을 주어야 함.
      return;
    }

    for (var slot in availableTimes) {
      print('저장 완료: ${slot.time} -> 이용 가능');
      // TODO: 여기서 API 호출을 통해 서버에 데이터 (slot.toJson())를 전송합니다.
    }

    print('--- 이용 가능 시간 저장 완료 ---');
  }
}