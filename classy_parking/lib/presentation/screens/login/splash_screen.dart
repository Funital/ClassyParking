import 'package:classy_parking/core/constants/font.dart';
import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.push(RoutePath.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
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
    );
  }
}
