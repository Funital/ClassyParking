import 'package:classy_parking/core/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/traffic_light.dart';
import 'home_model.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Consumer<HomeViewModel>(
          builder: (context, vm, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                      "나의 주차 등급",
                      style: AppFont.size22.copyWith(
                        fontWeight: FontWeight.w800
                      )
                  ),

                  const SizedBox(height: 20),
                  // 신호등 영역
                 const TrafficLight(redColor: Colors.red, yellowColor: Colors.yellow, greenColor: Colors.green),

                  const SizedBox(height: 30),
                  _buildMenuRow(context, vm.getTopMenu(context)),

                  const SizedBox(height: 16),
                  _buildMenuRow(context, vm.getMiddleMenu(context)),

                  const SizedBox(height: 16),
                  _buildMenuRow(context, vm.getBottomMenu(context)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuRow(BuildContext context, List<HomeModel> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items
          .map(
            (item) => Expanded(
          child: InkWell(
            onTap: item.onTap, // HomeModel에 정의된 onTap 실행
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  Icon(item.icon, size: 32, color: Colors.blue),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}
