import 'package:classy_parking/core/constants/font.dart';
import 'package:flutter/material.dart';

class BillBox extends StatelessWidget {
  final String index;
  final String address;
  final String date;
  final String time;
  final String fee;
  final String payment;
  final VoidCallback onTap;

  const BillBox({
    Key? key,
    required this.index,
    required this.address,
    required this.date,
    required this.time,
    required this.fee,
    required this.payment,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with index
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                index,
                style: AppFont.size22.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black
                )
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Address row with icon
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.grey,
                size: 18,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Info rows
          _infoRow('이용날짜', date),
          const SizedBox(height: 4),
          _infoRow('이용시간', time),
          const SizedBox(height: 4),
          _infoRow('이용요금', fee),
          const SizedBox(height: 4),
          _infoRow('결제수단', payment),
          const SizedBox(height: 12),
          // Status at bottom right wrapped with GestureDetector
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '이용 완료',
                  style: AppFont.size16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
