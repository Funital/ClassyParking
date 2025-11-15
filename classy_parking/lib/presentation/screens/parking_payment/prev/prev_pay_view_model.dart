// prev_pay_view_model.dart

import 'package:classy_parking/presentation/screens/parking_payment/prev/prev_pay_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_path.dart';

// 전달받을 상품 정보를 위한 클래스를 이 파일에 임시로 정의합니다.
// 실제로는 별도의 모델 파일에 정의하는 것이 좋습니다.
class SelectedProductInfo {
  final String parkingName; // 주차장 이름
  final String productTitle; // 상품 제목 (예: 하루종일(토))
  final String availableTime; // 이용 가능 시간
  final int selectedFee; // 결제할 금액

  SelectedProductInfo({
    required this.parkingName,
    required this.productTitle,
    required this.availableTime,
    required this.selectedFee,
  });
}
// -----------------------------------------------------------------

class PrevPayViewModel extends ChangeNotifier {
  late PrevPayModel _paymentInfo;
  String _selectedPayment = "토스페이";

  // **[추가된 필드]**
  late final String _parkingName;
  late final String _productTitle;
  late final String _availableTime;
  late final int _selectedFee;

  PrevPayModel get paymentInfo => _paymentInfo;
  String get selectedPayment => _selectedPayment;
  // **[추가된 Getter]**
  String get parkingName => _parkingName;
  String get productTitle => _productTitle;
  String get availableTime => _availableTime;
  int get selectedFee => _selectedFee;


  // **[생성자 수정: SelectedProductInfo를 매개변수로 받도록 변경]**
  PrevPayViewModel({required SelectedProductInfo productInfo}) {
    // 전달받은 상품 정보를 내부 필드에 저장
    _parkingName = productInfo.parkingName;
    _productTitle = productInfo.productTitle;
    _availableTime = productInfo.availableTime;
    _selectedFee = productInfo.selectedFee;

    // 결제 정보 초기화 (결제 금액과 주차장 위치를 상품 정보로 대체)
    _paymentInfo = PrevPayModel(
      carNumber: "123가 4567",
      location: _parkingName, // 주차장 이름 사용
      parkingTime: _availableTime, // 실시간 주차 시간은 이 화면의 목적과 다를 수 있어 빈 문자열 유지
      baseFee: _selectedFee, // 선택된 상품 금액
      discount: 0, // 할인 금액은 0으로 임시 설정
      totalFee: _selectedFee, // 총 금액을 상품 금액으로 설정
    );
  }

  void selectPayment(String payment) {
    _selectedPayment = payment;
    notifyListeners();
  }

  void payParkingFee(BuildContext context) {
    context.push(RoutePath.success_prev_payment);
    debugPrint("결제 수단: $_selectedPayment");
    debugPrint("결제 진행 중...");
  }
}