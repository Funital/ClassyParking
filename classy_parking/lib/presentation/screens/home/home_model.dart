import 'package:flutter/cupertino.dart';

class HomeModel {
  final String title;
  final IconData icon; // asset 경로 or emoji
  final void Function()? onTap;

  HomeModel({
    required this.title,
    required this.icon,
    this.onTap,
  });
}