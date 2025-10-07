import 'package:flutter/material.dart';

class TrafficLight extends StatelessWidget {
  final double radius;
  final EdgeInsetsGeometry padding;
  final Color redColor;
  final Color yellowColor;
  final Color greenColor;

  const TrafficLight({
    super.key,
    this.radius = 35,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    required this.redColor,
    required this.yellowColor,
    required this.greenColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Row 크기를 자식에 맞게 줄임
          mainAxisAlignment: MainAxisAlignment.center, // 균등 분배 대신 중앙 정렬
          children: [
            _buildCircle(redColor),
            const SizedBox(width: 8),
            _buildCircle(yellowColor),
            const SizedBox(width: 8),
            _buildCircle(greenColor),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(Color color) {
    return CircleAvatar(backgroundColor: color, radius: radius);
  }
}