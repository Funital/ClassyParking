import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈화면',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: '주차장 지도',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: '마이페이지',
        ),
      ],
    );
  }
}
