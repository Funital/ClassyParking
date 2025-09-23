import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/fixed_button_footer.dart';

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({super.key});

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
                  Icon(Icons.check_circle_outline, size: 120, color: Colors.blue),
                  SizedBox(height: 20),
                  Text("신고가 정상적으로\n접수되었습니다",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("접수번호 : 20250909-1234",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:  FixedButtonFooter(
              text: '메인으로 돌아가기',
              backgroundColor: Colors.blueAccent,
              onPressed: () {
                context.go(RoutePath.home);
              },
            ),
          ),
        ],
      ),
    );
  }
}
