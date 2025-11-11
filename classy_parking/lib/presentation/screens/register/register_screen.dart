import 'package:classy_parking/presentation/screens/register/register_view_model.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // LatLng 사용을 위해 추가 (필요 없을 수도 있지만 안전하게 유지)

import '../../../core/constants/color.dart';
import '../../../core/router/route_path.dart';

final MapController _registerMapController = MapController();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: const CustomSubAppBar(title: '주차장 등록하기'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: _buildStepOneContent(context, viewModel),
            ),
            bottomNavigationBar: _buildBottomButton(context, viewModel),
          );
        },
      ),
    );
  }

  // 1. 주소 검색 팝업을 띄우고 결과를 ViewModel에 전달하는 함수
  void _showAddressSearchDialog(BuildContext context, RegisterViewModel viewModel) {
    String searchKeyword = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('주소 검색'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "예: 안양역, 서울시청",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              searchKeyword = value;
            },
            onSubmitted: (value) => Navigator.of(context).pop(value), // 엔터키로도 검색 가능
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(searchKeyword),
              child: const Text('검색'),
            ),
          ],
        );
      },
    ).then((result) async {
      // 팝업이 닫힌 후, 검색 결과(result)가 문자열이고 비어있지 않은 경우
      if (result != null && result is String && result.isNotEmpty) {
        // 검색어를 ViewModel의 searchAddress에 전달하여 실제 검색 수행
        await viewModel.searchAddress(result);

        // 검색 후 지도를 새 위치로 이동
        _registerMapController.move(viewModel.mapCenter, 15.0);
      }
    });
  }

  // 2. 1단계 본문 내용 구성 (FlutterMap 적용)
  Widget _buildStepOneContent(BuildContext context, RegisterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // 1. 기본 정보 헤더
        const Text(
          "1. 기본 정보",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),

        // (주차장 이름 입력 필드)
        const Text("주차장 이름", style: TextStyle(color: Colors.grey)),
        TextFormField(
          initialValue: viewModel.model.parkingName,
          decoration: const InputDecoration(
            hintText: "예: 강남역 2번 출구 민영 주차장",
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(),
          ),
          onChanged: viewModel.updateParkingName,
        ),
        const SizedBox(height: 25.0),

        // 주소
        const Text("주소", style: TextStyle(color: Colors.grey)),

        // ⭐ 수정: 주소 검색 여부에 따른 조건부 UI
        if (viewModel.model.address.isEmpty)
        // 주소 검색 버튼
          ElevatedButton(
            onPressed: () {
              // ⭐ 수정: 팝업을 띄워 실제 검색어를 받도록 변경
              _showAddressSearchDialog(context, viewModel);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: AppColor.main,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            child: const Text("주소 검색", style: TextStyle(fontSize: 16.0)),
          )
        else
        // 검색된 주소와 재검색 버튼
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("도로명 주소 (검색 결과)", style: TextStyle(color: Colors.black)),
              Text(viewModel.model.address, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10.0),

              ElevatedButton(
                onPressed: () {
                  // ⭐ 수정: 팝업을 띄워 실제 검색어를 받도록 변경
                  _showAddressSearchDialog(context, viewModel);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  // backgroundColor: Colors.blue.shade100,
                  foregroundColor: AppColor.main,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text("주소 재검색", style: TextStyle(fontSize: 16.0)),
              ),
            ],
          ),

        const SizedBox(height: 15.0),

        // 상세 주소 (검색 결과가 있으면 표시)
        if (viewModel.model.address.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("상세 주소", style: TextStyle(color: Colors.grey)),
                TextFormField(
                  initialValue: viewModel.model.detailAddress,
                  decoration: const InputDecoration(
                    hintText: "건물명, 동/호수 등",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: viewModel.updateDetailAddress,
                ),
              ],
            ),
          ),

        const SizedBox(height: 25.0),

        // 지도 미리보기 (FlutterMap 사용)
        Container(
          height: 200, // 높이를 조금 늘려 지도를 더 잘 보이게 함
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FlutterMap(
              mapController: _registerMapController,
              options: MapOptions(
                initialCenter: viewModel.mapCenter, // ViewModel의 현재 좌표 사용
                initialZoom: 15.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                ),
                // 핀 드래그 완료 시 좌표 업데이트 (FlutterMap에서는 마커 옵션에서 처리)
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  // MapScreen의 userAgentPackageName을 그대로 사용하거나 적절히 변경
                  userAgentPackageName: 'com.funital.classyparking',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: viewModel.parkingPosition, // ViewModel의 핀 위치 사용
                      width: 50,
                      height: 50,
                      child: Draggable( // Draggable 위젯을 사용하여 핀 드래그 구현
                        feedback: const Icon(Icons.location_on, color: AppColor.main, size: 50),
                        childWhenDragging: Container(),
                        data: viewModel.parkingPosition,
                        onDragEnd: (details) {
                          // 여기서는 간단히 지도 중앙을 새로운 핀 위치로 업데이트
                          viewModel.updateParkingPosition(_registerMapController.camera.center);
                        },
                        child: const Icon(Icons.location_on, color: AppColor.main, size: 40),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30.0),

        // (주차장 종류 헤더 및 총 주차 가능 면수 입력 필드)
        const Text(
          "주차장 종류",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),

        const Text("총 주차 가능 면수", style: TextStyle(color: Colors.grey)),
        TextFormField(
          initialValue: viewModel.model.totalSpaces,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "50",
            suffixText: "대",
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(),
          ),
          onChanged: viewModel.updateTotalSpaces,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  // 3. 하단 "다음 단계" 버튼 (기존 코드 유지)
  Widget _buildBottomButton(BuildContext context, RegisterViewModel viewModel) {
    // ⭐ 수정: isStepValid()를 사용하여 버튼 활성화/비활성화
    final bool isButtonEnabled = viewModel.isStepValid();

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10 + MediaQuery.of(context).padding.bottom,
        top: 10,
      ),
      child: ElevatedButton(
        // ⭐ 수정: 유효성 검사를 통과했을 때만 onPressed 함수 실행
        onPressed: isButtonEnabled ? () => viewModel.goToHome(context) : null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          // ⭐ 수정: 버튼 활성화 여부에 따라 색상 변경
          backgroundColor: isButtonEnabled ? AppColor.main : Colors.grey,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: const Text(
          "다음 단계",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}