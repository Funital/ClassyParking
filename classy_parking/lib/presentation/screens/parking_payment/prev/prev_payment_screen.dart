// prev_payment_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/route_path.dart';
import '../../../widgets/custom_bottom_button.dart';
import 'prev_payment_model.dart';
import 'prev_payment_view_model.dart';

class PrevPaymentScreen extends StatelessWidget {
  const PrevPaymentScreen({super.key});

  // 예약하기 버튼 높이 + 하단 패딩
  static const double _kReserveButtonHeight = 70.0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PrevPaymentViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Consumer<PrevPaymentViewModel>(
          builder: (context, viewModel, child) {
            final isEnabled = viewModel.isReserveButtonEnabled;

            return CustomBottomButton(
              text: '예약하기',
              onPressed: isEnabled
                  ? () {
                // 선택된 상품 정보 출력 또는 다음 화면 이동 로직
                final selectedProduct = viewModel.products![viewModel
                    .selectedIndex!];
                print("--- 예약하기 버튼 활성화 ---");
                print("선택된 상품: ${selectedProduct.title}(${selectedProduct
                    .dayOfWeek}), ${selectedProduct.price}원");
                // TODO: 예약/결제 로직 실행
                context.push(RoutePath.success_prev_payment);
              }
                  : null,
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Consumer<PrevPaymentViewModel>(
            builder: (context, vm, _) {
              // 상품 목록이 보일 때 (주차장이 선택됨)는 뒤로가기 버튼, 아닐 때는 기본 뒤로가기
              if (vm.isProductListVisible) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: vm.goBackToSearch,
                );
              }
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          // 이미지의 검색창 디자인을 AppBar Title로 구현
          title: Consumer<PrevPaymentViewModel>(
            builder: (context, vm, _) {
              // 상품 목록이 보일 때는 Text로 주차장 이름 표시, 아닐 때는 TextField 유지
              if (vm.isProductListVisible) {
                // 주차장 상세 정보의 text도 검색어와 동일한 text가 뜨도록 수정되었습니다.
                return Text(
                  vm.selectedParkingDetail!.parkingName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                );
              }
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  // 검색 로직 연결
                  onChanged: vm.searchParking,
                  decoration: const InputDecoration(
                    hintText: "주차장을 검색하세요",
                    // 검색 유도 힌트
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 8),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          ),
          actions: [
            // 오른쪽 차량 아이콘
            IconButton(
              icon: Stack(
                children: [
                  const Icon(
                      Icons.directions_car, color: Colors.blueAccent, size: 28),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () {
                // TODO: 차량 정보 또는 알림 기능
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        // [수정된 부분: GestureDetector로 body를 감싸 키보드 닫기 기능 추가]
        body: GestureDetector(
          onTap: () {
            // 현재 포커스를 제거 (키보드 닫기)
            FocusScope.of(context).unfocus();
          },
          child: Consumer<PrevPaymentViewModel>(
            builder: (context, vm, _) {
              // 1. 주차장 상품 목록 표시 (주차장이 선택된 경우)
              if (vm.isProductListVisible && vm.products != null) {
                // Stack을 사용하여 스크롤 가능한 목록 위에 고정된 버튼을 배치
                return Stack(
                  children: [
                    SingleChildScrollView(
                      // 하단에 예약하기 버튼 공간 확보를 위한 패딩 추가
                      padding: const EdgeInsets.only(
                          bottom: _kReserveButtonHeight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 주차장 상세 정보 섹션 (선택된 상세 정보 사용)
                          _buildParkingInfo(context, vm.selectedParkingDetail!),
                          const Divider(height: 1,
                              thickness: 1,
                              color: Color(0xFFE0E0E0)),

                          // 할인 배너 섹션
                          _buildDiscountBanner(),

                          // 상품 목록
                          ...List.generate(vm.products!.length, (index) {
                            return _buildProductItem(
                              context,
                              vm.products![index],
                              index, // 현재 항목의 인덱스 전달
                              vm,
                            );
                          }),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                );
              }

              // 2. 검색 결과 리스트 표시
              if (vm.searchList.isNotEmpty) {
                return ListView.builder(
                  itemCount: vm.searchList.length,
                  itemBuilder: (context, index) {
                    final item = vm.searchList[index];
                    return _buildSearchItem(context, item, vm);
                  },
                );
              }

              // 3. 초기 화면 (검색 결과/상품 목록이 없을 때)
              return const Center(
                child: Text("주차장 이름을 검색해주세요."),
              );
            },
          ),
        ),
      ),
    );
  }

  // **새로 추가된 검색 결과 항목 위젯**
  Widget _buildSearchItem(BuildContext context, ParkingSearchModel item,
      PrevPaymentViewModel vm) {
    return InkWell(
      onTap: () => vm.selectParking(item, context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color(0xFFF5F5F5), width: 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.detail,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 주차장 상세 정보 위젯 (수정됨: ParkingDetailModel 사용)
  Widget _buildParkingInfo(BuildContext context, ParkingDetailModel details) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 주차장 이름 (상세)
                Row(
                  children: [
                    Text(
                      details.locationDetail, // ex: 투루파킹 안양빌라 주차장
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Icon(
                        Icons.chevron_right, size: 20, color: Colors.black54),
                  ],
                ),
                const SizedBox(height: 4),
                // 요금 및 거리
                Text(
                  "${details.hourlyRate} | ${details.distance}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // 주차장 사진
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                // 실제 이미지 경로나 NetworkImage 사용 필요
                image: AssetImage(details.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 할인 배너 위젯 (이전과 동일)
  Widget _buildDiscountBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          Icon(Icons.star, color: Color(0xFF3333FF), size: 18), // M 아이콘 대신 별 사용
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "주차권 최대 20% 할인받는 방법",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Icon(Icons.chevron_right, size: 20, color: Colors.black54),
        ],
      ),
    );
  }

  // 주차 상품 항목 위젯 수정: index와 vm을 받아 선택 상태를 처리
  Widget _buildProductItem(BuildContext context,
      ParkingProductModel product,
      int index,
      PrevPaymentViewModel vm,) {
    // ViewModel에서 현재 항목이 선택되었는지 확인
    final isSelected = vm.selectedIndex == index;
    final isWeekend = product.dayOfWeek == "토" || product.dayOfWeek == "일";

    return InkWell(
      onTap: () => vm.selectProduct(index), // 항목 선택 로직 호출
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F5FF) : Colors.white,
          // 선택된 항목 배경색 변경
          border: const Border(
            bottom: BorderSide(color: Color(0xFFF5F5F5), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 요일 및 상품 제목
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${product.title}(${product.dayOfWeek})",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 이용 가능 시간
                  Text(
                    "이용가능 ${product.availableTime}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // 가격 정보
            Text(
              "${product.price.toString()}원",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isWeekend ? Colors.red : Colors.black, // 주말 가격 강조 예시
              ),
            ),
            const SizedBox(width: 20),

            // **선택하기 버튼 (아이콘) - 체크 상태 반영**
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                // 선택 상태에 따라 테두리 색상과 배경색 변경
                color: isSelected ? Colors.blue : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey[300]!,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.check,
                size: 18,
                // 선택 상태에 따라 아이콘 색상 변경
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}