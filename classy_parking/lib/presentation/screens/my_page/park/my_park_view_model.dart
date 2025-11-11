// my_park_view_model.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart'; // 라우터 사용 시 주석 해제
import 'my_park_model.dart';

class MyParkViewModel extends ChangeNotifier {
  // 찜한 주차장 목록 (샘플 데이터)
  List<MyParkItemModel> _parkList = [];

  MyParkViewModel() {
    _loadInitialData();
  }

  List<MyParkItemModel> get parkList => _parkList;

  void _loadInitialData() {
    _parkList = [
      MyParkItemModel(
        id: 1,
        locationAddress: "경기도 안양시 동안구 시민대로",
        usageDate: "2025년 09월 09일(화)",
        usageTime: "13:00 ~ 16:00",
        usageFee: "3,000",
        paymentMethod: "카카오페이",
        isAvailable: true, // 이용 가능
      ),
      MyParkItemModel(
        id: 2,
        locationAddress: "경기도 안양시 만안구 안양동",
        usageDate: "025년 09월 04일(목)",
        usageTime: "10:00 ~ 15:00",
        usageFee: "7,500",
        paymentMethod: "카카오페이",
        isAvailable: false, // 이용 불가능
      ),
      MyParkItemModel(
        id: 3,
        locationAddress: "경기도 안양시 동안구 관양동",
        usageDate: "2025년 10월 20일(월)",
        usageTime: "18:00 ~ 22:00",
        usageFee: "4,000",
        paymentMethod: "네이버페이",
        isAvailable: true, // 이용 가능
      ),
    ];
    notifyListeners();
  }

  // 주차장 항목 클릭 시 액션
  void handleItemClick(BuildContext context, MyParkItemModel item) {
    if (item.isAvailable) {
      // 이용 가능: 다른 상세 페이지로 이동
      // 실제 라우터 사용 시: context.push(RoutePath.parkingDetail, extra: item.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.locationAddress} 상세 페이지로 이동')),
      );
    } else {
      // 이용 불가능: 팝업 문구 표시
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("이용 불가"),
            content: const Text("현재 이 주차장은 이용할 수 없습니다."),
            actions: <Widget>[
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}