import 'package:classy_parking/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_path.dart';

class PrevPaymentSuccessScreen extends StatefulWidget {
  const PrevPaymentSuccessScreen({super.key});

  @override
  State<PrevPaymentSuccessScreen> createState() => _PrevPaymentSuccessScreenState();
}

class _PrevPaymentSuccessScreenState extends State<PrevPaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.push(RoutePath.navi);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_outline,
                      size: 120, color: AppColor.main),
                  const SizedBox(height: 20),
                  const Text(
                    "예약을 완료했습니다!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}