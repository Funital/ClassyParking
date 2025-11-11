import 'package:classy_parking/presentation/screens/register/register_view_model.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_map/flutter_map.dart';

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

        // (주차장 이름 입력 필드 - 생략 없이 기존 코드 유지)
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
        ElevatedButton(
          onPressed: () async {
            // TODO: 주소 검색 UI/팝업을 띄우고 결과를 받아와야 함.
            // 임시로 더미 주소 검색을 호출 (ViewModel에 LatLng 업데이트 로직 필요)
            await viewModel.searchAddress("서울특별시 강남구 테헤란로 132");
            // 검색 후 지도를 새 위치로 이동
            _registerMapController.move(viewModel.mapCenter, 15.0);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 45),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          child: const Text("주소 검색", style: TextStyle(fontSize: 16.0)),
        ),
        const SizedBox(height: 15.0),

        // 상세 주소 (검색 결과가 있으면 표시)
        if (viewModel.model.address.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("도로명 주소 (검색 결과)", style: TextStyle(color: Colors.black)),
                Text(viewModel.model.address, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10.0),
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
                        feedback: const Icon(Icons.location_on, color: Colors.blue, size: 50),
                        childWhenDragging: Container(),
                        data: viewModel.parkingPosition,
                        onDragEnd: (details) {
                          // 지도 뷰포트 좌표를 LatLng으로 변환하는 로직 필요
                          // 단순 예시: 화면 중앙 위치를 핀의 새 위치로 가정하거나,
                          // Dragging 위치를 직접 LatLng으로 변환해야 합니다. (더 복잡한 로직 필요)
                          // 간단하게는 MapOptions의 onTap을 사용하거나, Custom Marker 사용이 더 일반적입니다.

                          // 여기서는 간단히 지도 중앙을 새로운 핀 위치로 업데이트하는 로직을 가정
                          viewModel.updateParkingPosition(_registerMapController.camera.center);
                        },
                        child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30.0),

        // (주차장 종류 헤더 및 총 주차 가능 면수 입력 필드 - 기존 코드 유지)
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
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20 + MediaQuery.of(context).padding.bottom,
        top: 10,
      ),
      child: ElevatedButton(
        onPressed: () => viewModel.goToHome(context),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: const Text(
          "등록하기",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}