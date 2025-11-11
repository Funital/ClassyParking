import 'package:classy_parking/core/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/route_path.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false, // 제목 왼쪽 정렬
      titleSpacing: 0,    // 불필요한 좌측 여백 제거
      title: GestureDetector(
        onTap: () => context.go(RoutePath.home),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '주차의 품격',
            style: AppFont.size20.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),
      ),
      actions: [
        // Padding(
        //   padding: const EdgeInsets.only(right: 10),
        //   child: IconButton(
        //     icon: const Icon(
        //       Icons.settings,
        //       color: Colors.black,
        //     ),
        //     iconSize: 30,
        //     onPressed: () {
        //       context.push(RoutePath.setting);
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(
              Icons.add_alert_rounded,
              color: Colors.black,
            ),
            iconSize: 30,
            onPressed: () {
              context.push(RoutePath.alarm);
            },
          ),
        ),
      ],
    );
  }
}
