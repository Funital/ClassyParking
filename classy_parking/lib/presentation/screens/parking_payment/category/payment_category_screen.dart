import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_sub_app_bar.dart';
import 'payment_category_model.dart';
import 'payment_category_view_model.dart';

class PaymentCategoryScreen extends StatelessWidget {
  const PaymentCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentCategoryViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomSubAppBar(title: '결제방식 선택하기'),
        body: Consumer<PaymentCategoryViewModel>(
          builder: (context, vm, _) {
            final items = vm.getCategoryItems(context);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  // 큰 제목
                  const Text(
                    "어떤 방식의 결제를 원하시나요?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 항목 리스트 (카드)
                  ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _CategoryCard(item: item),
                  )).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// 항목을 표시하는 커스텀 카드 위젯
class _CategoryCard extends StatelessWidget {
  final PaymentCategoryModel item;

  const _CategoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // 은은한 그림자 효과 추가 (이미지 참고)
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 아이콘 영역 (좌측)
            Icon(
              item.icon,
              size: 28,
              color: item.iconColor,
            ),
            const SizedBox(width: 15),
            // 텍스트 영역 (우측)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}