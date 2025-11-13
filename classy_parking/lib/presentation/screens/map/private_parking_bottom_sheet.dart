// private_parking_bottom_sheet.dart (map_screen.dart와 동일 디렉토리에 생성 가정)

import 'package:flutter/material.dart';

class PrivateParkingBottomSheet extends StatelessWidget {
  final String title;
  final String address;
  final String feeInfo;
  final String operationInfo;
  // availableSpaces 값이 1이면 비어있음, 0이면 만차로 간주
  final int availableSpaces;

  const PrivateParkingBottomSheet({
    super.key,
    required this.title,
    required this.address,
    required this.feeInfo,
    required this.operationInfo,
    required this.availableSpaces,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 단일 주차 공간의 상태 확인 (1자리만 있다고 가정)
    final bool isAvailable = availableSpaces > 0;

    // 2. 상태에 따른 UI 요소 정의
    final Color statusColor = isAvailable ? Colors.green.shade700 : Colors.red.shade700;
    final Color backgroundColor = isAvailable ? Colors.green.shade100 : Colors.red.shade100;
    final String statusText = isAvailable ? "즉시 주차 가능 (1자리 남음)" : "현재 만차(출차 10분전)";
    final IconData statusIcon = isAvailable ? Icons.check_circle_outline : Icons.cancel_outlined;
    final String availableText = isAvailable ? "1" : "0";

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 타이틀 (개인 주차장)
            Text(
              "$title (개인 주차장)",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            // 주소
            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    address,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // **단일 주차 공간 상태 정보 (수정된 부분)**
            // 현재 주차 가능 여부를 크게 표시하여 쉽게 확인 가능하도록 함
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "총 1자리 중",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        availableText,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        statusIcon,
                        color: statusColor,
                        size: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 요금 정보
            const Text(
              "요금정보",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              feeInfo,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 18),
            // 운영 정보
            const Text(
              "공유 시간",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              operationInfo,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}