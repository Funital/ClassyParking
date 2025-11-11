// my_park_model.dart

import 'package:flutter/material.dart';

class MyParkItemModel {
  final int id;
  final String locationAddress;
  final String usageDate;
  final String usageTime;
  final String usageFee;
  final String paymentMethod;
  final bool isAvailable; // 이용 가능 여부 (true: 이용 가능, false: 이용 불가능)

  MyParkItemModel({
    required this.id,
    required this.locationAddress,
    required this.usageDate,
    required this.usageTime,
    required this.usageFee,
    required this.paymentMethod,
    required this.isAvailable,
  });
}

class MyParkDetailModel {
  final String parkingName; // 주차장 이름 등 상세 정보
  // 여기에 필요에 따라 상세 정보를 추가할 수 있습니다.

  MyParkDetailModel({required this.parkingName});
}