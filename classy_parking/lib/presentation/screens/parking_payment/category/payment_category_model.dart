import 'package:flutter/material.dart';

class PaymentCategoryModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final void Function()? onTap;

  PaymentCategoryModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });
}