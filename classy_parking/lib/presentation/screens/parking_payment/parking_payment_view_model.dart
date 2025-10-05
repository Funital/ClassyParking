import 'package:classy_parking/presentation/screens/parking_payment/parking_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_path.dart';

class ParkingPaymentViewModel extends ChangeNotifier {
  late ParkingPaymentModel _paymentInfo;
  String _selectedPayment = "토스페이";

  ParkingPaymentModel get paymentInfo => _paymentInfo;
  String get selectedPayment => _selectedPayment;

  ParkingPaymentViewModel() {
    _paymentInfo = ParkingPaymentModel(
      carNumber: "10소 1234",
      location: "B3층 C구역 25번",
      parkingTime: "2시간 45분",
      entryTime: "2025.10.05 10:00",
      exitTime: "2025.10.05 12:45",
      baseFee: 20000,
      discount: 5000,
      totalFee: 15000,
    );
  }

  void selectPayment(String payment) {
    _selectedPayment = payment;
    notifyListeners();
  }

  void payParkingFee(BuildContext context) {
    context.push(RoutePath.success_payment);
    debugPrint("결제 수단: $_selectedPayment");
    debugPrint("결제 진행 중...");
  }
}