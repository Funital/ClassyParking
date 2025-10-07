import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/fixed_button_footer.dart';

class ReportSuccessScreen extends StatefulWidget {
  const ReportSuccessScreen({super.key});

  @override
  State<ReportSuccessScreen> createState() => _ReportSuccessScreenState();
}

class _ReportSuccessScreenState extends State<ReportSuccessScreen> {
  bool _navigated = false; // 중복 이동 방지

  @override
  void initState() {
    super.initState();

    // ✅ 2초 후 홈 화면으로 이동
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted || _navigated) return; // 위젯이 이미 dispose된 경우 방지
      _navigated = true;
      context.go(RoutePath.home); // 홈 화면으로 즉시 교체 이동
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
                      size: 120, color: Colors.blue),
                  const SizedBox(height: 20),
                  const Text(
                    "신고가 정상적으로\n접수되었습니다",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "접수번호 : 20250909-1234",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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