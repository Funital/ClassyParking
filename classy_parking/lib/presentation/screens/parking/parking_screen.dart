import 'package:classy_parking/core/constants/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color.dart';
import '../../widgets/custom_sub_app_bar.dart';
import 'parking_view_model.dart';
import 'parking_model.dart';

class ParkingScreen extends StatelessWidget {
  final String title;

  const ParkingScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParkingViewModel(),
      child: Scaffold(
        appBar: CustomSubAppBar(title: '주차 공간 지도'),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<ParkingViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        style: AppFont.size18.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  /// 층 선택 토글
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<int>(
                      value: viewModel.selectedFloorIndex,
                      items: List.generate(
                        viewModel.floors.length,
                            (index) => DropdownMenuItem(
                          value: index,
                          child: Text(viewModel.floors[index].name),
                        ),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.changeFloor(value);
                        }
                      },
                    ),
                  ),

                  /// 주차칸 UI
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 좌/우 구역
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: viewModel.currentFloor.spots.length,
                      itemBuilder: (context, index) {
                        final spot = viewModel.currentFloor.spots[index];
                        return GestureDetector(
                          onTap: spot.isOccupied
                              ? null
                              : () => viewModel.selectSpot(spot.id),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: spot.isSelected
                                    ? AppColor.main
                                    : Colors.grey.shade400,
                              ),
                              color: spot.isOccupied
                                  ? Colors.grey.shade300
                                  : spot.isSelected
                                  ? AppColor.main
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              spot.isSelected
                                  ? "선택"
                                  : spot.id,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: spot.isOccupied
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// Confirm Booking 버튼
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.main,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          final selected = viewModel.currentFloor.spots
                              .firstWhere(
                                (s) => s.isSelected,
                            orElse: () => ParkingSpot(id: ""),
                          );
                          if (selected.id.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "위치가 저장되었습니다. ${selected.id}"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "내차 위치 저장",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}