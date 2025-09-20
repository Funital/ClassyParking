import 'package:flutter/material.dart';
import 'home_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<HomeModel> getTopMenu() => [
    HomeModel(title: "빈자리 찾기", icon: Icons.directions_car),
    HomeModel(title: "불법주차 신고하기", icon: Icons.report_problem),
  ];

  List<HomeModel> getMiddleMenu() => [
    HomeModel(title: "주차 요금 안내", icon: Icons.attach_money),
    HomeModel(title: "주차요금 결제", icon: Icons.credit_card),
  ];

  List<HomeModel> getBottomMenu() => [
    HomeModel(title: "주차장 지도", icon: Icons.map),
    HomeModel(title: "주차 모음 영상", icon: Icons.play_circle_fill),
  ];
}