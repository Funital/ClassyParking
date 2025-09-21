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
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(backgroundColor: redColor, radius: radius),
            CircleAvatar(backgroundColor: yellowColor, radius: radius),
            CircleAvatar(backgroundColor: greenColor, radius: radius),
          ],
        ),
      ),
    );
  }
}