// prove_view_model.dart
import 'package:camera/camera.dart';
import 'package:classy_parking/presentation/screens/prove/prove_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // ScaffoldMessenger 등을 위해 필요

class ProveViewModel extends ChangeNotifier {
  // 초기 상태 설정
  ProveModel _model = ProveModel(
    currentStep: 1,
    totalSteps: 3,
    proofImages: {},
  );

  ProveModel get model => _model;

  // 카메라 관련 상태
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;
  bool _isCameraReady = false;
  bool get isCameraReady => _isCameraReady;

  // 카메라 초기화
  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        // 카메라가 없는 경우 처리
        return;
      }

      // 전면 카메라 대신 후면 카메라 사용
      _cameraController = CameraController(
        cameras.first, // 첫 번째 카메라 (보통 후면)
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      _isCameraReady = true;
      notifyListeners();
    } catch (e) {
      _isCameraReady = false;
      notifyListeners();
      // 에러 핸들링
      print("카메라 초기화 오류: $e");
    }
  }

  // 사진 촬영 로직
  Future<void> takePicture(BuildContext context) async {
    if (!_isCameraReady || _cameraController == null) return;

    try {
      final XFile file = await _cameraController!.takePicture();
      final currentType = _model.getCurrentProofType();

      // 모델 업데이트 (현재 단계의 사진을 저장)
      final updatedImages = Map<String, String>.from(_model.proofImages);
      updatedImages[currentType] = file.path;

      _model = _model.copyWith(
        proofImages: updatedImages,
      );

      // 다음 단계로 이동
      if (_model.currentStep < _model.totalSteps) {
        _model = _model.copyWith(
          currentStep: _model.currentStep + 1,
        );
      }

      notifyListeners();

      // UI 피드백 (선택 사항)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$currentType 사진이 촬영되었습니다.')),
      );

    } on CameraException catch (e) {
      print('사진 촬영 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사진 촬영에 실패했습니다: ${e.code}')),
      );
    }
  }

  // 메모리 해제
  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  // 이미지 썸네일 재촬영 (예시로 첫 번째 정면 사진 재촬영)
  void retakePicture(String proofType) {
    // 해당 사진을 모델에서 제거하고, 단계를 해당 단계로 되돌림
    final updatedImages = Map<String, String>.from(_model.proofImages);
    updatedImages.remove(proofType);

    int newStep;
    switch (proofType) {
      case '정면':
        newStep = 1;
        break;
      case '측면':
        newStep = 2;
        break;
      case '후면':
        newStep = 3;
        break;
      default:
        return;
    }

    _model = _model.copyWith(
      currentStep: newStep,
      proofImages: updatedImages,
    );
    notifyListeners();
  }
}