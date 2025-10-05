import 'package:classy_parking/presentation/screens/parking_payment/parking_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_sub_app_bar.dart';

class ParkingPaymentScreen extends StatelessWidget {
  const ParkingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParkingPaymentViewModel(),
      child: const _ParkingPaymentView(), // 내부 실제 UI 분리
    );
  }
}

class _ParkingPaymentView extends StatelessWidget {
  const _ParkingPaymentView();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ParkingPaymentViewModel>(context);
    final info = viewModel.paymentInfo;

    return Scaffold(
      appBar: CustomSubAppBar(title: '주차요금 결제 내역'),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [Color(0xFFa8adb5), Color(0xFFedf0f5)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "안양 공영 주차장",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // 상세 카드
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 차량번호
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            info.carNumber,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.refresh, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 위치
                      Text(
                        info.location,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Divider(height: 32),

                      // 주차 시간
                      Column(
                        children: [
                          const Text(
                            "현재 주차시간",
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            info.parkingTime,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "입차 : ${info.entryTime}\n출차 : ${info.exitTime}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 12),

                      // 요금 정보
                      Column(
                        children: [
                          _buildFeeRow("주차요금", info.baseFee),
                          _buildFeeRow("할인 금액", -info.discount),
                          const SizedBox(height: 12),
                          const Divider(),
                          _buildFeeRow("결제 예정 금액", info.totalFee,
                              isBold: true, color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 하단 결제 버튼
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: viewModel.payParkingFee,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "주차요금 결제",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeeRow(String label, int amount,
      {bool isBold = false, Color color = Colors.black54}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: color,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            "${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}원",
            style: TextStyle(
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}