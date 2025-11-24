// navi_screen.dart (최종 수정 버전)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/route_path.dart';
import '../../../../core/constants/color.dart';
import '../../../widgets/custom_sub_app_bar.dart';
import 'navi_model.dart';
import 'navi_view_model.dart';


class NaviScreen extends StatelessWidget {
  const NaviScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? extra = GoRouterState.of(context).extra as Map<String, dynamic>?;

    final BookedProductInfo bookedInfo = BookedProductInfo(
      parkingName: extra?['parkingName'] as String? ?? "안양 공영 주차장",
      productTitle: extra?['productTitle'] as String? ?? "하루 종일",
      availableTime: extra?['availableTime'] as String? ?? "24시간",
    );

    // ChangeNotifierProvider는 화면이 트리에서 제거될 때 (context.go()에 의해)
    // 자동으로 dispose()를 호출하도록 설정되어 있습니다.
    return ChangeNotifierProvider(
      create: (_) => NaviViewModel(bookedInfo: bookedInfo),
      child: const _NaviView(),
    );
  }
}

class _NaviView extends StatelessWidget {
  const _NaviView();

  void _showEndNaviDialog(BuildContext context, NaviViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("내비게이션 종료"),
          content: const Text("네비를 종료하시겠습니까?"),
          actions: <Widget>[
            TextButton(
              child: const Text("취소", style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text("확인", style: TextStyle(color: AppColor.main, fontWeight: FontWeight.bold)),
              onPressed: () {
                // 1. Alert 닫기
                Navigator.of(dialogContext).pop();

                // ⭐ 핵심 수정: viewModel.dispose()를 삭제합니다.
                //    Provider가 context.go() 후 자동으로 처리합니다.

                // 2. 홈 화면으로 이동
                context.go(RoutePath.home);
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NaviViewModel>(context);
    final info = viewModel.naviInfo;

    final VoidCallback onEndNaviPressed = () => _showEndNaviDialog(context, viewModel);

    return Scaffold(
      appBar: CustomSubAppBar(
        title: '길 안내',
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. 상단 길 안내 정보 오버레이
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopInstruction(info),
          ),

          // 3. 하단 도착 및 예약 정보 오버레이
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomInfo(context, info, onEndNaviPressed),
          ),
        ],
      ),
    );
  }

  // ... (_buildTopInstruction 생략)

  // 하단 도착 및 예약 정보 위젯
  Widget _buildBottomInfo(
      BuildContext context,
      NaviModel info,
      VoidCallback onEndNaviPressed
      ) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 목적지 정보
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColor.main),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.destinationName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      info.destinationAddress,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // 주차장 도착 버튼
              ElevatedButton(
                onPressed: onEndNaviPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.main,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(100, 40),
                ),
                child: const Text("도착 완료", style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
          const Divider(height: 20),
          // 예약 정보
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.black54),
              const SizedBox(width: 8),
              const Text("예약 정보: ", style: TextStyle(fontSize: 14, color: Colors.black87)),
              Text(
                info.bookedTime,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // _buildTopInstruction 구현은 생략
  Widget _buildTopInstruction(NaviModel info) {
    // ... (기존 _buildTopInstruction 구현)
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black.withOpacity(0.7),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 20),
                const SizedBox(width: 4),
                Text(
                  "${info.estimatedTimeMin}분 남음",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.route, color: Colors.white, size: 20),
                const SizedBox(width: 4),
                Text(
                  "${info.remainingDistanceKm}km",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              info.currentInstruction,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              info.nextInstruction,
              style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}