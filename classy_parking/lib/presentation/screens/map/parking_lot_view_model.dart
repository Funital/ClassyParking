import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'parking_lot_model.dart';

class ParkingLotViewModel extends ChangeNotifier {
  // 주차장 리스트
  final List<ParkingLotModel> _parkingLots = [
    ParkingLotModel(
      location: LatLng(37.5665, 126.9780),
      name: "서울시청 본청사 주차장",
      address: "중구 세종대로 110",
      phone: "02-2133-5981",
      totalSpaces: 101,
      availableSpaces: 31,
      feeInfo: "기본 요금: 1,000원/10분\n추가 요금: 1,000원/10분\n"
          "경차/저공해차: 50% 할인\n장애인: 80% 할인\n"
          "국가유공자/고엽제: 80% 할인\n다자녀: 50% 할인",
      operationInfo: "평일: 09:00~18:00\n토요일: 24시간\n공휴일: 24시간",
    ),
    ParkingLotModel(
      location: LatLng(37.5700, 126.9769),
      name: "광화문 주차장",
      address: "서울 종로구 세종대로 175",
      phone: "02-1234-5678",
      totalSpaces: 200,
      availableSpaces: 80,
      feeInfo: "기본 요금: 1,200원/10분\n추가 요금: 1,200원/10분\n"
          "경차/저공해차: 50% 할인\n장애인: 80% 할인",
      operationInfo: "평일: 07:00~22:00\n주말: 09:00~20:00",
    ),
    // 테스트 케이스 원하는 만큼 추가 가능
  ];

  // 선택된 주차장 (Marker 클릭 시 할당)
  ParkingLotModel? _selectedLot;

  // getter
  List<ParkingLotModel> get parkingLots => _parkingLots;
  ParkingLotModel? get selectedLot => _selectedLot;

  // 선택된 주차장 업데이트
  void selectLot(ParkingLotModel lot) {
    _selectedLot = lot;
    notifyListeners();
  }

  // 테스트 케이스로 주차장 추가
  void addTestLot(ParkingLotModel lot) {
    _parkingLots.add(lot);
    notifyListeners();
  }
}