// my_park_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_sub_app_bar.dart';
import 'my_park_model.dart';
import 'my_park_view_model.dart';

class MyParkScreen extends StatelessWidget {
  const MyParkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyParkViewModel(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: CustomSubAppBar(title: '즐겨찾기'),
        body: Consumer<MyParkViewModel>(
          builder: (context, vm, _) {
            final items = vm.parkList;

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildParkCard(context, index + 1, items[index], vm);
              },
            );
          },
        ),
      ),
    );
  }

  // 주차장 정보 카드 위젯
  Widget _buildParkCard(
      BuildContext context, int number, MyParkItemModel item, MyParkViewModel vm) {

    // 이용 가능 여부에 따라 색상 및 아이콘 설정
    final bool isAvailable = item.isAvailable;
    final Color statusColor = isAvailable ? Colors.green : Colors.red;
    final IconData statusIcon = isAvailable ? Icons.check_circle : Icons.cancel;
    final String statusText = isAvailable ? "이용 가능" : "이용 불가능";

    return InkWell(
      onTap: () => vm.handleItemClick(context, item), // 클릭 액션 추가
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 항목 번호
              Text(
                '0$number',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const Divider(height: 20, thickness: 1, color: Color(0xFFE0E0E0)),

              // 위치 정보
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, size: 18, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.locationAddress,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // 상세 정보 목록
              _buildDetailRow("이용날짜", item.usageDate),
              _buildDetailRow("이용시간", item.usageTime),
              _buildDetailRow("이용요금", item.usageFee, isBold: true),
              _buildDetailRow("결제수단", item.paymentMethod),
              const SizedBox(height: 10),

              // 이용 완료/이용 가능 상태 표시 (오른쪽 하단)
              Align(
                alignment: Alignment.centerRight,
                child: isAvailable
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 18, color: statusColor),
                    const SizedBox(width: 5),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                )
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 18, color: statusColor),
                    const SizedBox(width: 5),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 상세 정보 Row를 위한 헬퍼 위젯
  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black87 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}