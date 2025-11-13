// lib/viewmodels/register_view_model.dart

import 'package:classy_parking/presentation/screens/register/register_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

import '../../../core/router/route_path.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterModel _model = RegisterModel();

  RegisterModel get model => _model;

  // --- 지도 및 위치 정보 관리 ---

  // 지도 중앙 위치 (MapOptions의 initialCenter나 move에 사용됨)
  LatLng _mapCenter = const LatLng(37.5665, 126.9780);

  LatLng get mapCenter => _mapCenter;

  // 주차장 핀 위치 (초기값은 서울 시청 등 기본 위치로 설정)
  LatLng _parkingPosition = const LatLng(37.5665, 126.9780);

  LatLng get parkingPosition => _parkingPosition;

  final ImagePicker _picker = ImagePicker();

  // 핀 드래그 종료 시 좌표 업데이트
  void updateParkingPosition(LatLng newPosition) {
    _parkingPosition = newPosition;
    _mapCenter = newPosition; // 핀이 움직이면 지도 중심도 업데이트합니다.

    // ⭐ 수정: 모델에 위경도 값도 저장
    _model.latitude = newPosition.latitude;
    _model.longitude = newPosition.longitude;

    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        // 모델에 파일 경로 저장
        _model.imagePath = pickedFile.path;
        notifyListeners();
        print('이미지 선택 성공: ${_model.imagePath}');
      } else {
        print('이미지 선택 취소됨.');
      }
    } catch (e) {
      print('이미지 선택 중 오류 발생: $e');
    }
  }

  // 주소 검색 버튼 액션 (비동기 함수로 수정)
  Future<void> searchAddress(String query) async {
    try {
      if (query.isEmpty) return;

      final List<Location> locations = await locationFromAddress(query); // <-- ⭐ 실제 검색어 사용

      if (locations.isNotEmpty) {
        final Location firstLocation = locations.first;
        final LatLng newPosition = LatLng(
          firstLocation.latitude,
          firstLocation.longitude,
        );

        // 모델에 검색된 주소 및 위경도 저장
        _model.address = query; // <-- ⭐ 검색어(예: "안양역")를 주소로 저장
        _model.latitude = newPosition.latitude;
        _model.longitude = newPosition.longitude;

        // 맵 핀 위치 및 지도 중심 위치 업데이트
        _parkingPosition = newPosition;
        _mapCenter = newPosition; // 지도 중심을 검색된 위치로 이동시킵니다.

        notifyListeners();
        print('주소 검색 성공: ${query}, LatLng: $newPosition');
      } else {
        _model.address = '';
        notifyListeners();
        print('검색 결과를 찾을 수 없습니다: $query');
      }
    } catch (e) {
      print('주소 검색 중 오류 발생: $e');
    }
  }


  // --- 단계 및 유효성 검사 ---

  int _currentStep = 1;
  final int totalSteps = 4;

  int get currentStep => _currentStep;

  // 다음 단계로 이동
  void goToHome(BuildContext context) {
    if (isStepValid()) {
      context.push(RoutePath.success_register);
    }
  }

  // 이전 단계로 이동
  void goToPreviousStep() {
    if (_currentStep > 1) {
      _currentStep--;
      notifyListeners();
    }
  }

  // 현재 단계의 등록 유효성 검사
  bool isStepValid() {
    switch (_currentStep) {
      case 1:
      // ⭐ 수정: 1단계 유효성 검사 로직 (필수 필드 및 위경도 확인)
        return _model.parkingName.isNotEmpty &&
            _model.address.isNotEmpty &&
            _model.totalSpaces.isNotEmpty &&
            _model.latitude != null &&
            _model.longitude != null &&
            _model.imagePath != null &&
            // 초기 기본값(서울 시청)이 아닌지 확인 (주소 검색 또는 핀 이동이 완료되었는지 확인)
            !(_model.latitude == 37.5665 && _model.longitude == 126.9780);
      case 2:
      // TODO: 2단계 유효성 검사 로직 추가 (예: 요금 정보가 올바르게 입력되었는지)
        return true;
      case 3:
      // TODO: 3단계 유효성 검사 로직 추가
        return true;
      case 4:
      // TODO: 4단계 유효성 검사 로직 추가
        return true;
      default:
        return false;
    }
  }


  // --- 1단계 입력 필드 업데이트 (기존 코드 유지) ---

  void updateParkingName(String name) {
    _model.parkingName = name;
    notifyListeners(); // ⭐ 추가: 유효성 검사를 위해 변경 시마다 호출
  }

  void updateDetailAddress(String detail) {
    _model.detailAddress = detail;
    notifyListeners(); // ⭐ 추가: 유효성 검사를 위해 변경 시마다 호출
  }

  void updateTotalSpaces(String spaces) {
    _model.totalSpaces = spaces;
    notifyListeners(); // ⭐ 추가: 유효성 검사를 위해 변경 시마다 호출
  }
}