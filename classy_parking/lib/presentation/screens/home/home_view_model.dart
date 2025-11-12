import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_path.dart';
import 'home_model.dart';

class HomeViewModel extends ChangeNotifier {
  // UI에 맞게 순서를 변경하고, 아이콘을 새 디자인에 맞춰 업데이트했습니다.
  List<HomeModel> getTopMenu(BuildContext context) => [
    // 1. 불법주차 신고하기 (왼쪽)
    HomeModel(
      title: "불법주차 신고하기",
      icon: Icons.lightbulb_outline, // 새로운 아이콘
      onTap: () {
        context.push(RoutePath.report);
      },
    ),
    // 2. 주차공간 등록하기 (오른쪽)
    HomeModel(
      title: "주차공간 등록하기",
      icon: Icons.directions_car_filled, // 새로운 아이콘
      onTap: () {
        context.push(RoutePath.register);
      },
    ),
  ];

  List<HomeModel> getMiddleMenu(BuildContext context) => [
    HomeModel(
      title: "이용 내역",
      icon: Icons.book_outlined, // 새로운 아이콘
      onTap: () {
        context.push(RoutePath.bill);
      },
    ),
    HomeModel(
      title: "주차요금 결제",
      icon: Icons.credit_card_outlined, // 새로운 아이콘
      onTap: () {
        context.push(RoutePath.payment_category);
      },
    ),
  ];

  List<HomeModel> getBottomMenu(BuildContext context) => [
    HomeModel(
      title: "입출차 인증",
      icon: Icons.camera_alt, // 새로운 아이콘
      onTap: () {
        context.push(RoutePath.prove);
      },
    ),

    HomeModel(
      title: "서비스 이용 안내",
      icon: Icons.info_outline, // 새로운 아이콘
      onTap: () {
        context.push(RoutePath.home_info);
      },
    ),
  ];
}