import 'dart:ui';

class BillModel {
  final String index;
  final String address;
  final String date;
  final String time;
  final String fee;
  final String payment;
  final VoidCallback onTap;

  const BillModel({
    required this.index,
    required this.address,
    required this.date,
    required this.time,
    required this.fee,
    required this.payment,
    required this.onTap,
  });
}