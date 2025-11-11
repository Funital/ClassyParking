import 'package:classy_parking/presentation/screens/parking_payment/parking_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_bottom_button.dart';
import '../../widgets/custom_sub_app_bar.dart';

class ParkingPaymentScreen extends StatelessWidget {
  const ParkingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParkingPaymentViewModel(),
      child: const _ParkingPaymentView(),
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
      appBar: CustomSubAppBar(title: '주차요금 결제하기'),
      bottomNavigationBar: Consumer<ParkingPaymentViewModel>(
        builder: (context, viewModel, child) => CustomBottomButton(
          text: "결제하기",
          onPressed: () => viewModel.payParkingFee(context),
        ),
      ),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            info.carNumber,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.refresh, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Text(
                        info.location,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
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

                      const Divider(),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "결제 수단",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Column(
                        children: [
                          _buildPaymentOption(
                            context,
                            icon: "assets/images/toss_pay.png",
                            title: "토스페이",
                            subtitle: "5만원 이상 2천원 선착순 할인 (매일 0시/10시/18시 400명)",
                          ),
                          _buildPaymentOption(
                            context,
                            icon: "assets/images/naver_pay.png",
                            title: "네이버페이",
                            subtitle: "네이버페이 포인트 최대 1.6% 상시 적립",
                          ),
                          _buildPaymentOption(
                            context,
                            icon: "assets/images/payco.png",
                            title: "페이코",
                            subtitle: "PAYCO 포인트 적립 가능",
                          ),
                          _buildPaymentOption(
                            context,
                            icon: "assets/images/kakao_pay.png",
                            title: "카카오페이",
                            subtitle: "간편 결제 및 송금 가능",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  Widget _buildPaymentOption(
      BuildContext context, {
        required String icon,
        required String title,
        required String subtitle,
      }) {
    final viewModel = Provider.of<ParkingPaymentViewModel>(context);

    return GestureDetector(
      onTap: () => viewModel.selectPayment(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 라디오 버튼
            Radio<String>(
              value: title,
              groupValue: viewModel.selectedPayment,
              onChanged: (value) {
                if (value != null) viewModel.selectPayment(value);
              },
              activeColor: Colors.blueAccent,
            ),

            // 아이콘 + 텍스트
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        icon,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}