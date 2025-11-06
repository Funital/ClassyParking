import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'payment_category_model.dart';

class PaymentCategoryViewModel extends ChangeNotifier {
  // 실제 앱에서는 GoRouter 등을 사용해 화면 이동 로직을 연결해야 합니다.
  // 여기서는 콘솔 출력만 하도록 정의합니다.

  List<PaymentCategoryModel> getCategoryItems(BuildContext context) {
    return [
      PaymentCategoryModel(
        title: "개인 주차장 예약",
        subtitle: "특정 시간에 개인 주차장 예약이 가능해요",
        icon: Icons.local_parking, // 이미지의 반짝이 아이콘
        iconColor: Colors.blueAccent,
        onTap: () {
          context.push(RoutePath.prev_payment);
          print("개인 주차장");
        },
      ),
      PaymentCategoryModel(
        title: "공영 주차장 결제",
        subtitle: "주변의 공영 주차장을 이용해보세요",
        icon: Icons.public, // 옷 아이콘 (Flutter 기본 아이콘)
        iconColor: Colors.blueAccent,
        onTap: () {
          context.push(RoutePath.payment);
          print("공영주차장");
        },
      ),
    ];
  }
}