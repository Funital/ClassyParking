import 'package:flutter/material.dart';
import 'info_model.dart';

class InfoViewModel extends ChangeNotifier {
  final List<InfoModel> infos = [
    InfoModel(
      icon: Icons.directions_car,
      iconColor: Colors.red,
      title: "빈자리 찾기",
      description: "주변 주차장의 빈자리를 찾아줍니다.",
    ),
    InfoModel(
      icon: Icons.map,
      iconColor: Colors.green,
      title: "주차장 지도",
      description: "주변 주차장의 위치를 안내합니다.",
    ),
    InfoModel(
      icon: Icons.local_parking,
      iconColor: Colors.green,
      title: "주차장 지도",
      description: "주차 요금 및 위치 정보를 제공합니다.",
    ),
    InfoModel(
      icon: Icons.attach_money,
      iconColor: Colors.orange,
      title: "불차요금 안내/결제",
      description: "주차 요금 조회 및 결제를 지원합니다.",
    ),
  ];
}