import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ParkingBottomSheet extends StatelessWidget {
  final LatLng location;
  final String title;
  final String address;
  final String phone;
  final int totalSpaces;
  final int availableSpaces;
  final String feeInfo;
  final String operationInfo;

  const ParkingBottomSheet({
    super.key,
    required this.location,
    required this.title,
    required this.address,
    required this.phone,
    required this.totalSpaces,
    required this.availableSpaces,
    required this.feeInfo,
    required this.operationInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Phone and Address
            Row(
              children: [
                const Icon(Icons.phone, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    phone,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
            // Spaces Info
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text("전체"),
                        const SizedBox(height: 4),
                        Text(
                          "$totalSpaces",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text("여유"),
                        const SizedBox(height: 4),
                        Text(
                          "$availableSpaces",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Fee Info
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
            // Operation Info
            const Text(
              "운영정보",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              operationInfo,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            // 자세히 보기 Button
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //       // 여기서 상세 페이지 이동 같은 추가 동작 가능
            //     },
            //     child: const Text("자세히 보기"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}