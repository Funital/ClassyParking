import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_path.dart';
import 'home_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<HomeModel> getTopMenu(BuildContext context) => [
    HomeModel(
      title: "주차공간 등록하기",
      icon: Icons.directions_car,
      onTap: () {
        context.push(RoutePath.register);
      },
    ),
    HomeModel(
      title: "불법주차 신고하기",
      icon: Icons.report_problem,
      onTap: () {
        context.push(RoutePath.report);
      },
    ),
  ];

  List<HomeModel> getMiddleMenu(BuildContext context) => [
    HomeModel(
      title: "이용 내역",
      icon: Icons.map,
      onTap: () {
        context.push(RoutePath.bill);
      },
    ),
    HomeModel(
      title: "주차요금 결제",
      icon: Icons.credit_card,
      onTap: () {
        context.push(RoutePath.payment);
      },
    ),
  ];

  List<HomeModel> getBottomMenu(BuildContext context) => [
    HomeModel(
      title: "주차 모음 영상",
      icon: Icons.play_circle_fill,
      onTap: () {
        context.push(RoutePath.home_video);
      },
    ),
    HomeModel(
      title: "서비스 이용 안내",
      icon: Icons.warning,
      onTap: () {
        context.push(RoutePath.home_info);
      },
    ),
  ];
}