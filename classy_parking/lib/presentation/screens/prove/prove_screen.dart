// prove_screen.dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:classy_parking/presentation/screens/prove/prove_view_model.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/router/route_path.dart';
import '../../widgets/custom_bottom_button.dart';

class ProveScreen extends StatefulWidget {
  const ProveScreen({super.key});

  @override
  State<ProveScreen> createState() => _ProveScreenState();
}

class _ProveScreenState extends State<ProveScreen> {
  late ProveViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProveViewModel();
    // 화면이 생성되자마자 카메라 초기화 시작
    _viewModel.initializeCamera();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProveViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        appBar: CustomSubAppBar(title: '입출차 인증하기',),
        bottomNavigationBar: Consumer<ProveViewModel>(
          builder: (context, viewModel, child) => CustomBottomButton(
            text: "촬영하기",
            onPressed : () => context.go(RoutePath.prove_success),
          ),
        ),
        body: Consumer<ProveViewModel>(
          builder: (context, vm, child) {
            // 카메라가 준비되지 않았거나 현재 촬영 단계가 완료된 경우
            if (!vm.isCameraReady) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. 단계 안내 텍스트
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '차량과 주차 공간이 잘 보이는 곳에서 촬영해주세요.',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // 2. 카메라 미리보기/사진 영역
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: AspectRatio(
                        aspectRatio: 1.0, // 정사각형 비율
                        child: _buildCameraPreview(vm),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // 카메라 미리보기 위젯 구성
  Widget _buildCameraPreview(ProveViewModel vm) {
    // 현재 단계의 사진이 이미 저장되어 있으면 저장된 사진을 보여줍니다.
    final currentType = vm.model.getCurrentProofType();
    final imagePath = vm.model.proofImages[currentType];

    if (imagePath != null) {
      // 촬영된 사진 (미리보기)
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    } else {
      // 카메라 라이브 프리뷰
      return CameraPreview(vm.cameraController!);
    }
  }
}