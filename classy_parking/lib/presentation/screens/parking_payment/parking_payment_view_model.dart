import 'package:classy_parking/presentation/screens/parking_payment/parking_payment_model.dart';
import 'package:flutter/material.dart';

class ParkingPaymentViewModel extends ChangeNotifier {
  late ParkingPaymentModel _paymentInfo;

  ParkingPaymentModel get paymentInfo => _paymentInfo;

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

  void payParkingFee() {
    // 결제 로직 추가 (ex. API 요청 or Navigator 이동)
    debugPrint("결제 진행 중...");
  }
}