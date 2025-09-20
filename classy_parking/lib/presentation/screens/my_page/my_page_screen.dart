import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSubAppBar(title: '마이 페이지',),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text('마이페이지 입니다.')
        ],
      ),
    );
  }
}
