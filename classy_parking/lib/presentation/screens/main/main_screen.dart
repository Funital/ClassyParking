import 'package:classy_parking/presentation/screens/bill/bill_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_tab_bar.dart';
import '../home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const BillScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: CustomTabBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}