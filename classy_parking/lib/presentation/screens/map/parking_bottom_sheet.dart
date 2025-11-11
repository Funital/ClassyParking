// parking_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/color.dart';
import '../../../core/router/route_path.dart';

// StatefulWidget으로 변경하여 찜하기 상태를 관리합니다.
class ParkingBottomSheet extends StatefulWidget {
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
  State<ParkingBottomSheet> createState() => _ParkingBottomSheetState();
}

class _ParkingBottomSheetState extends State<ParkingBottomSheet> {
  // 찜하기 상태를 저장할 변수
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    // 사용자에게 피드백 제공
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? '${widget.title} 찜하기 완료!' : '${widget.title} 찜하기 해제.',
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // DraggableScrollableSheet 내부에서 사용되므로 padding을 제거하고 Column에 적용
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Favorite Icon (찜하기 추가 및 상태 변경 로직 적용)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // 찜하기 아이콘
                IconButton(
                  // _isFavorite 상태에 따라 아이콘과 색상 변경
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Phone and Address
            Row(
              children: [
                const Icon(Icons.phone, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.phone,
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
                    widget.address,
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
                          "${widget.totalSpaces}",
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
                      color: AppColor.main,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text("여유"),
                        const SizedBox(height: 4),
                        Text(
                          "${widget.availableSpaces}",
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

            // 빈자기 보기 Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // context.push(RoutePath.parking, extra: title);
                  // TODO: GoRouter를 사용하여 해당 주차장으로 예약 페이지 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.title} 예약 페이지로 이동!')),
                  );
                },
                child: const Text("빈자리 찾기"),
              ),
            ),

            const SizedBox(height: 20),

            // Fee Info
            const Text(
              "요금정보",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              widget.feeInfo,
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
              widget.operationInfo,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),

            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}