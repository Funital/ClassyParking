// lib/screens/park_manage_screen.dart (최종 수정본)

import 'package:classy_parking/presentation/screens/my_page/manage/my_parking_manage_view_model.dart';
import 'package:classy_parking/presentation/widgets/custom_app_bar.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/color.dart';
import '../../../widgets/custom_bottom_button.dart';
import 'my_parking_manage_model.dart';


class MyParkinigManageScreen extends StatelessWidget {
  const MyParkinigManageScreen({super.key});

  // 헬퍼 함수: 시간 설정 다이얼로그를 표시합니다.
  Future<void> _showTimeSelectionDialog(BuildContext context, MyParkingManageViewModel viewModel) async {
    // 다이얼로그를 띄우기 전에 현재 저장된 상태를 임시 선택 상태에 동기화합니다.
    viewModel.syncSelectionToCurrentSlots();

    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // [핵심 수정 부분]
        // 다이얼로그 위젯 트리에 기존 viewModel 인스턴스를 다시 제공합니다.
        return ChangeNotifierProvider.value(
          value: viewModel,
          child: AlertDialog(
            title: const Text('⏰ 주차 가능 시간 설정 (24시간)'),
            content: SizedBox(
              width: double.maxFinite,
              // 다이얼로그 내용: 24시간 리스트
              // [수정] Provider.value로 제공했기 때문에 Consumer를 다시 사용하여 상태 변경 감지
              child: Consumer<MyParkingManageViewModel>(
                builder: (context, vm, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: vm.timeSlots.length,
                    itemBuilder: (context, index) {
                      // CheckboxListTile을 사용하여 다중 선택 가능하게 합니다.
                      return CheckboxListTile(
                        title: Text(vm.timeSlots[index].time),
                        value: vm.dialogSelection[index],
                        onChanged: (bool? newValue) {
                          if (newValue != null) {
                            // 다이얼로그 내부 상태 변경
                            vm.toggleDialogSelection(index, newValue);
                          }
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        // 이용 가능한 시간대 강조
                        activeColor: Colors.green,
                      );
                    },
                  );
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColor.main),
                child: const Text('확인', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // 다이얼로그의 임시 선택 상태를 ViewModel의 실제 상태에 반영
                  viewModel.applyDialogSelection();
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 선택된 시간을 보기 좋게 요약하여 반환
  String _getSummaryTime(List<ParkTimeSlot> slots) {
    if (slots.every((s) => !s.isAvailable)) {
      return '이용 불가능';
    }
    if (slots.every((s) => s.isAvailable)) {
      return '24시간 상시 이용 가능';
    }

    final availableSlots = slots.where((s) => s.isAvailable).toList();
    if (availableSlots.length == 1) {
      return availableSlots.first.time;
    }

    // 단순화된 요약: 이용 가능한 시간대의 개수를 표시
    return '총 ${availableSlots.length}시간 이용 가능';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyParkingManageViewModel(),
      child: Consumer<MyParkingManageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomSubAppBar(title: '내 주차장'),
            bottomNavigationBar: Consumer<MyParkingManageViewModel>(
              builder: (context, viewModel, child) => CustomBottomButton(
                text: "저장하기",
                // enabled: viewModel.saveAvailability,
                onPressed: () async {
                  await viewModel.saveAvailability();
                  // 저장 완료 피드백 (스낵바)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('주차장 이용 가능 시간이 성공적으로 저장되었습니다.')),
                  );
                },
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. 주소 표시 영역
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '📍 현재 주소: ${viewModel.parkingAddress}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(height: 1),

                // 2. 시간 설정 항목 (다이얼로그 트리거)
                ListTile(
                  leading: Icon(Icons.schedule, color: AppColor.main),
                  title: const Text('주차 공간 이용 가능 시간 설정'),
                  // 요약된 시간 표시
                  subtitle: Text(_getSummaryTime(viewModel.timeSlots)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // 탭 시 시간 설정 다이얼로그 호출
                    _showTimeSelectionDialog(context, viewModel);
                  },
                ),
                const Divider(height: 1),

                // 3. (옵션) 상세 설정 또는 다른 항목 추가 가능
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '✅ 현재 설정된 이용 가능 시간',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),

                // 4. (옵션) 현재 설정된 시간을 확인하기 위한 리스트 (읽기 전용)
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.timeSlots.length,
                    itemBuilder: (context, index) {
                      final slot = viewModel.timeSlots[index];
                      // 이용 가능한 시간만 표시하거나, 모두 표시하되 상태를 텍스트로 나타냄
                      return slot.isAvailable
                          ? ListTile(
                        title: Text(slot.time, style: const TextStyle(fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.check_circle, color: Colors.green),
                        dense: true,
                      )
                          : const SizedBox.shrink(); // 이용 불가능한 시간대는 숨김
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}