import 'package:classy_parking/core/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
import 'home_view_model.dart';

// 기존의 TrafficLight 위젯은 새 디자인에서 필요 없으므로 제거하고,
// 새로운 UI 컴포넌트들을 추가합니다.

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold의 기본 배경색을 흰색으로 변경하여 깔끔하게 만듭니다.
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        // 앱바는 CustomScrollView 내부에 SliverAppBar로 구현하여 유기적인 디자인을 만듭니다.
        // 현재 코드에서는 AppBar가 없으므로 body 위젯 내부에 직접 구현합니다.
        // Scaffold의 배경색은 흰색으로 유지합니다.
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0, // AppBar 영역은 body의 CustomHeader에서 처리
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, vm, _) {
            // 헤더, 등급, 메뉴들을 모두 포함하는 SingleChildScrollView
            return SingleChildScrollView(
              child: Column(
                children: [
                  // 1. 그라데이션 헤더와 등급 시각화 영역
                  _CustomHeader(
                    userName: "OOO", // 사용자 이름을 ViewModel에서 받아오는 것이 좋으나, 임시로 하드코딩
                    grade: "GRACE",
                    score: 85,
                  ),

                  // 2. 핵심 액션 버튼 (Top Menu)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    child: _buildActionButtons(context, vm.getTopMenu(context)),
                  ),

                  // 3. 일반 기능 버튼 (Middle + Bottom Menu 통합)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
                    child: _buildGridMenu(context, [
                      ...vm.getMiddleMenu(context),
                      ...vm.getBottomMenu(context),
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  // 핵심 액션 버튼 위젯 (가로 2열, 각 버튼의 디자인이 다름)
  Widget _buildActionButtons(BuildContext context, List<HomeModel> items) {
    return Row(
      children: [
        // 불법주차 신고하기 (왼쪽 버튼)
        Expanded(
          child: _ActionCard(
            item: items[1], // 불법주차 신고하기
            iconColor: const Color(0xFF1E88E5), // 파란색
            icon: Icons.lightbulb_outline, // 이미지의 전구 아이콘
            backgroundColor: const Color(0xFFE3F2FD), // 밝은 파란색 배경
            borderColor: Colors.transparent,
          ),
        ),
        const SizedBox(width: 12),
        // 주차공간 등록하기 (오른쪽 버튼)
        Expanded(
          child: _ActionCard(
            item: items[0], // 주차공간 등록하기
            iconColor: const Color(0xFF43A047), // 녹색
            icon: Icons.directions_car_filled, // 이미지의 차량 아이콘
            backgroundColor: const Color(0xFFE8F5E9), // 밝은 녹색 배경
            borderColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

  // 일반 기능 버튼 위젯 (2x2 그리드)
  Widget _buildGridMenu(BuildContext context, List<HomeModel> items) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // SingleChildScrollView와 충돌 방지
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.0, // 정사각형 유지
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _FeatureCard(item: items[index]);
      },
    );
  }
}

// 1. 그라데이션 헤더 위젯
class _CustomHeader extends StatelessWidget {
  final String userName;
  final String grade;
  final int score;

  const _CustomHeader({
    required this.userName,
    required this.grade,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 30),
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
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 사용자 인사말
          Text(
            '$userName님의 점수는!',
            style: AppFont.size16.copyWith(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          // 등급 원형 차트 시각화
          Center(
            child: SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // CircularProgressIndicator 대신 CustomPaint 등으로 구현 가능하나,
                  // 간단한 시각화를 위해 ProgressIndicator 사용
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: score / 100, // 점수를 0.0 ~ 1.0으로 변환
                      strokeWidth: 15,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)), // 파란색
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        grade,
                        style: AppFont.size18.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${score}점',
                        style: AppFont.size36.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
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

// 2. 핵심 액션 버튼 디자인 (_ActionCard)
class _ActionCard extends StatelessWidget {
  final HomeModel item;
  final Color iconColor;
  final Color backgroundColor;
  final IconData icon;
  final Color borderColor;

  const _ActionCard({
    required this.item,
    required this.iconColor,
    required this.backgroundColor,
    required this.icon,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: iconColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: AppFont.size14.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. 일반 기능 버튼 디자인 (2x2 그리드 카드)
class _FeatureCard extends StatelessWidget {
  final HomeModel item;

  const _FeatureCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이미지에 표시된 아이콘 (책, 카드, 플레이 버튼, 정보)에 맞게 변경
            Icon(_getIconData(item.title), size: 40, color: Colors.blueGrey),
            const SizedBox(height: 10),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: AppFont.size18.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ViewModel에서 가져온 title에 따라 아이콘을 매핑
  IconData _getIconData(String title) {
    switch (title) {
      case "이용 내역":
        return Icons.book_outlined;
      case "주차요금 결제":
        return Icons.credit_card_outlined;
      case "주차 모음 영상":
        return Icons.play_circle_outline;
      case "서비스 이용 안내":
        return Icons.info_outline;
      default:
        return Icons.ac_unit;
    }
  }
}