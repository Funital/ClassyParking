import 'package:classy_parking/core/constants/font.dart';
import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      context.push(RoutePath.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          // 이미지의 부드러운 그라데이션 구현 (파랑 -> 민트)
          gradient: LinearGradient(
            colors: [
              Color(0xFF81D4FA), // 밝은 파랑
              Color(0xFFE0F7FA), // 민트
              Color(0xFFF1F8E9), // 연한 연두색 (끝부분)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "편한 주차의 시작",
                style: AppFont.size22.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black
                )
              ),
              SizedBox(height: 10),
              Text(
                "주차의 품격",
                  style: AppFont.size44.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.black
                  )
              ),
              SizedBox(height: 100),
              Icon(
                Icons.directions_car,
                size: 150,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
