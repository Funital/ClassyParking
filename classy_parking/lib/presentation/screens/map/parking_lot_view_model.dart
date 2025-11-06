// parking_lot_view_model.dart
import 'package:flutter/material.dart'; // Color 사용을 위해 추가
import 'package:latlong2/latlong.dart';

import 'parking_lot_model.dart';

class ParkingLotViewModel extends ChangeNotifier {
  // 주차장 리스트
  final List<ParkingLotModel> _parkingLots = [
    // 기존 주차장 (마커색: 파란색)
    ParkingLotModel(
      location: LatLng(37.392707, 126.932324),
      name: "연성대 내부 주차장",
      address: "경기도 안양시 만안구 양화로 37번길 34",
      phone: "031-442-8300",
      totalSpaces: 566,
      availableSpaces: 200,
      feeInfo: "최초 10분 무료 / 30분 1,000원 / 이후 10분당 500원",
      operationInfo: "24시간",
      markerColor: Colors.blue,
    ),
    ParkingLotModel(
      location: LatLng(37.394971, 126.935873),
      name: "남부시장 공영주차장",
      address: "경기도 안양시 만안구 안양로248번길 13",
      phone: "031-8045-5466",
      totalSpaces: 189,
      availableSpaces: 50,
      feeInfo: "전통시장 이용 시 90분 무료 제공, 이후 요금 적용",
      operationInfo: "일대 영업시간 / 24시간 여부 확인 필요",
      markerColor: Colors.blue,
    ),
    ParkingLotModel(
      location: LatLng(37.396437, 126.933967),
      name: "명학역 노상공영주차장",
      address: "경기도 안양시 만안구 덕천로48번길 5",
      phone: "(공개된 정보 없음)",
      totalSpaces: 87,
      availableSpaces: 30,
      feeInfo: "09:00 ~ 17:00 / 요금 적용 (10분 단위 혹은 고정 요금)",
      operationInfo: "월~금 09:00~17:00",
      markerColor: Colors.blue,
    ),
    ParkingLotModel(
      location: LatLng(37.393824, 126.935638),
      name: "문예 노상공영주차장",
      address: "경기도 안양시 만안구 문예로 41 일대",
      phone: "(공개된 정보 없음)",
      totalSpaces: 54,
      availableSpaces: 20,
      feeInfo: "10:00 ~ 18:00 운영 / 요금 적용",
      operationInfo: "월~금 10:00~18:00",
      markerColor: Colors.blue,
    ),
    ParkingLotModel(
      location: LatLng(37.396184, 126.954726),
      name: "관양동 공영주차장",
      address: "경기도 안양시 동안구 관양동 시민대로 235",
      phone: "031-389-5326",
      totalSpaces: 200,
      availableSpaces: 50,
      feeInfo: "기본 요금: 600원/30분\n추가 요금: 10분당 200원\n유형: 노상/노외",
      operationInfo: "24시간",
      markerColor: Colors.blue,
    ),
    ParkingLotModel(
      location: LatLng(37.395444, 126.953402),
      name: "안양2동 노외 무료주차장",
      address: "경기도 안양시 만안구 안양2동 822-21",
      phone: "031-389-5326",
      totalSpaces: 23,
      availableSpaces: 23,
      feeInfo: "무료",
      operationInfo: "24시간",
      markerColor: Colors.blue,
    ),
    ParkingLotModel(
      location: LatLng(37.392939, 126.948983),
      name: "박달시장 노외주차장",
      address: "경기도 안양시 만안구 박달동 731-9",
      phone: "(공개된 정보 없음)",
      totalSpaces: 100,
      availableSpaces: 40,
      feeInfo: "기본 요금: 600원/30분\n추가 요금: 10분당 200원",
      operationInfo: "08:00 ~ 22:00",
      markerColor: Colors.blue,
    ),
    // **새로 추가된 주차장 (마커색: 빨간색)**
    ParkingLotModel(
      location: LatLng(37.394000, 126.945000), // 임시 안양 좌표
      name: "안양빌라 주차장",
      address: "경기도 안양시 동안구 비산동 111-1",
      phone: "050-0000-0001",
      totalSpaces: 10,
      availableSpaces: 3,
      feeInfo: "개인 주차장: 시간당 2,000원",
      operationInfo: "24시간 (공유 시간 외 폐쇄)",
      markerColor: Colors.red,
    ),
    ParkingLotModel(
      location: LatLng(37.398000, 126.950000), // 임시 안양 좌표
      name: "범계빌라 주차장",
      address: "경기도 안양시 동안구 평촌동 222-2",
      phone: "050-0000-0002",
      totalSpaces: 15,
      availableSpaces: 5,
      feeInfo: "개인 주차장: 시간당 1,500원",
      operationInfo: "평일 저녁 및 주말",
      markerColor: Colors.red,
    ),
    ParkingLotModel(
      location: LatLng(37.390000, 126.960000), // 임시 안양 좌표
      name: "인덕원빌라 주차장",
      address: "경기도 안양시 동안구 관양동 333-3",
      phone: "050-0000-0003",
      totalSpaces: 8,
      availableSpaces: 2,
      feeInfo: "개인 주차장: 시간당 2,500원",
      operationInfo: "주말 전일",
      markerColor: Colors.red,
    ),
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