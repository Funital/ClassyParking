import 'package:flutter/material.dart';

import '../core/constants/font.dart';
import '../core/router/app_router.dart';


class ClassyparkingApp extends StatelessWidget {
  final String initialRoute;

  const ClassyparkingApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: createAppRouter(initialRoute), // GoRouter를 동적으로 생성
      title: '주차의 품격',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppFont.family,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: false,
      ),
    );
  }
}
