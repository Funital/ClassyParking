// This is a basic Flutter widgets test.
//
// To perform an interaction with a widgets in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widgets
// tree, read text, and verify that the values of widgets properties are correct.

import 'package:classy_parking/app/classyparking_app.dart';
import 'package:classy_parking/presentation/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:classy_parking/main.dart';

void main() {
  testWidgets('로그인 화면에 텍스트가 보이는지 확인', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainScreen(),
      ),
    );

    expect(find.text('로그인 / 회원가입'), findsOneWidget);
  });

  testWidgets('ClassyParking 로고 이미지가 있는지 확인', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainScreen(),
      ),
    );

    expect(find.byType(Image), findsNWidgets(4)); // logo, title, kakao/apple 아이콘
  });
}
