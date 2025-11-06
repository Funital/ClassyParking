// parking_lot_model.dart
import 'package:flutter/material.dart'; // Color 사용을 위해 추가
import 'package:latlong2/latlong.dart';

class ParkingLotModel {
  final LatLng location;
  final String name;
  final String address;
  final String phone;
  final int totalSpaces;
  final int availableSpaces;
  final String feeInfo;
  final String operationInfo;
  // 새로 추가된 속성
  final Color markerColor;

  ParkingLotModel({
    required this.location,
    required this.name,
    required this.address,
    required this.phone,
    required this.totalSpaces,
    required this.availableSpaces,
    required this.feeInfo,
    required this.operationInfo,
    // markerColor 필수 요구사항으로 추가
    required this.markerColor,
  });
}