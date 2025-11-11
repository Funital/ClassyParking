import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'info/mypage_info_screen.dart';
import 'my_page_view_model.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyPageViewModel(),
      child: Consumer<MyPageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildHeader(viewModel),
                  const SizedBox(height: 30),
                  _buildPushNotificationSetting(viewModel),
                  const Divider(height: 1),
                  _buildMenuList(context, viewModel),
                  const SizedBox(height: 30),
                  _buildFooter(viewModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 1. 헤더 (사용자 프로필 및 닉네임)
  Widget _buildHeader(MyPageViewModel viewModel) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          viewModel.model.nickname,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // 2. 푸시 알림 설정
  Widget _buildPushNotificationSetting(MyPageViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "PUSH 알림",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Switch.adaptive(
                value: viewModel.model.isPushNotificationEnabled,
                onChanged: viewModel.togglePushNotification,
                activeColor: Colors.teal,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "마케팅 알림 수신 동의",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Switch.adaptive(
                value: viewModel.model.isPushNotificationEnabled,
                onChanged: viewModel.togglePushNotification,
                activeColor: Colors.teal,
              ),
            ],
          ),
        ],
      )
    );
  }

  // 3. 메뉴 리스트
  Widget _buildMenuList(BuildContext context, MyPageViewModel viewModel) {
    // 메뉴 항목 정의
    final List<String> menus = [
      '내 정보',
      '내 주차장',
      '즐겨찾기',
      '문의하기',
      '서비스 이용약관',
      '개인정보처리방침',
      '로그아웃',
    ];

    return Column(
      children: menus.map((title) {
        // 구분선 추가 (로그아웃 제외)
        final isLastItem = title == '로그아웃';

        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isLastItem ? Colors.black : Colors.black, // 로그아웃을 특별히 강조하지 않음
                  fontWeight: isLastItem ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              trailing: isLastItem
                  ? null // 로그아웃에는 화살표 없음
                  : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                if (title == '로그아웃') {
                  viewModel.logout();
                } else if (title == '내 정보') {
                  // '내 정보' 항목 클릭 시 닉네임 설정 화면으로 이동
                  context.push(RoutePath.myPage_info);
                } else if (title == '내 주차장') {
                  context.push(RoutePath.park_manage);
                }
                else if (title == '즐겨찾기') {
                  context.push(RoutePath.myPark);
                }
                else {
                  viewModel.navigateTo(title);
                }
              },
            ),
            // 로그아웃 앞에만 구분선을 제거
            if (title != '문의하기' && title != '로그아웃') const Divider(height: 1),
          ],
        );
      }).toList(),
    );
  }

  // 4. 푸터 (앱 버전 및 탈퇴)
  Widget _buildFooter(MyPageViewModel viewModel) {
    const String appVersion = "1.0.0";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "앱 버전",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Text(
                appVersion,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: viewModel.deleteAccount,
              child: const Text(
                "탈퇴하기 ➱",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}