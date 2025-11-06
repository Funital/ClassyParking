// prev_payment_view_model.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'prev_payment_model.dart';

class PrevPaymentViewModel extends ChangeNotifier {
  // **새로운 상태 변수**
  List<ParkingSearchModel> _searchList = [];
  ParkingDetailModel? _selectedParkingDetail; // 선택된 주차장 상세 정보
  List<ParkingProductModel>? _products; // 선택된 주차장의 상품 목록

  // **추가된 상태 변수: 선택된 상품 인덱스 (단일 선택)**
  int? _selectedIndex;

  // **Getter**
  List<ParkingSearchModel> get searchList => _searchList;
  ParkingDetailModel? get selectedParkingDetail => _selectedParkingDetail;
  List<ParkingProductModel>? get products => _products;
  bool get isProductListVisible => _selectedParkingDetail != null;

  // **추가된 Getter**
  int? get selectedIndex => _selectedIndex;
  bool get isReserveButtonEnabled => _selectedIndex != null; // 선택된 항목이 있을 때만 활성화

  // **검색어 리스트 (하드코딩된 원본 데이터)**
  final List<ParkingSearchModel> _allParkingList = [
    ParkingSearchModel(name: "안양빌라 주차장", detail: "경기도 안양시 동안구"),
    ParkingSearchModel(name: "범계빌라 주차장", detail: "경기도 안양시 동안구"),
    ParkingSearchModel(name: "인덕원빌라 주차장", detail: "경기도 안양시 동안구"),
  ];

  // **검색 로직**
  void searchParking(String keyword) {
    if (keyword.isEmpty) {
      _searchList = [];
    } else {
      _searchList = _allParkingList
          .where((parking) => parking.name.contains(keyword))
          .toList();
    }
    _products = null; // 검색 시작 시 상품 목록 초기화
    _selectedParkingDetail = null; // 상세 정보 초기화
    _selectedIndex = null; // 선택된 인덱스 초기화
    notifyListeners();
  }

  // **주차장 선택 로직**
  void selectParking(ParkingSearchModel selectedSearchItem, BuildContext context) {
    // 1. 상세 정보 설정
    _selectedParkingDetail = selectedSearchItem.toDetailModel();

    // 2. 상품 목록 로드 (샘플 데이터)
    _products = _loadProducts(selectedSearchItem);

    // 3. 검색 목록 초기화 (화면에서 검색 결과를 숨김)
    _searchList = [];

    _selectedIndex = null; // 새로운 주차장 선택 시 인덱스 초기화
    notifyListeners();
  }

  // **추가된 로직: 상품 선택 (단일 선택)**
  void selectProduct(int index) {
    if (_selectedIndex == index) {
      _selectedIndex = null; // 이미 선택된 항목을 다시 누르면 선택 해제
    } else {
      _selectedIndex = index; // 새 항목 선택
    }
    notifyListeners();
  }

  // **상품 로드 함수 (실제 API 호출 대체)**
  List<ParkingProductModel> _loadProducts(ParkingSearchModel item) {
    // 선택된 주차장에 따라 가격을 다르게 설정하는 등의 로직 가능
    int basePrice = item.name.contains("안양") ? 5000 : 7000;

    // 상품 선택 로직
    void handleSelect(ParkingProductModel product) {
      print("${product.title}(${product.dayOfWeek}) 상품 선택됨: ${product.price}원");
      // TODO: 다음 예약/결제 화면으로 이동하는 로직 구현
    }

    return [
      ParkingProductModel(
        dayOfWeek: "목", title: "하루종일", price: basePrice + 1000, availableTime: "00:00 - 23:59",
        onSelect: () => handleSelect(ParkingProductModel(dayOfWeek: "목", title: "하루종일", price: basePrice + 1000, availableTime: "00:00 - 23:59")),
      ),
      ParkingProductModel(
        dayOfWeek: "토", title: "하루종일", price: basePrice + 3000, availableTime: "00:00 - 23:59",
        onSelect: () => handleSelect(ParkingProductModel(dayOfWeek: "토", title: "하루종일", price: basePrice + 3000, availableTime: "00:00 - 23:59")),
      ),
      ParkingProductModel(
        dayOfWeek: "일", title: "하루종일", price: basePrice + 3000, availableTime: "00:00 - 23:59",
        onSelect: () => handleSelect(ParkingProductModel(dayOfWeek: "일", title: "하루종일", price: basePrice + 3000, availableTime: "00:00 - 23:59")),
      ),
      ParkingProductModel(
        dayOfWeek: "월", title: "하루종일", price: basePrice + 1000, availableTime: "00:00 - 23:59",
        onSelect: () => handleSelect(ParkingProductModel(dayOfWeek: "월", title: "하루종일", price: basePrice + 1000, availableTime: "00:00 - 23:59")),
      ),
      // 나머지 요일은 생략
    ];
  }

  // **뒤로가기/검색 초기화 로직**
  void goBackToSearch() {
    _selectedParkingDetail = null;
    _products = null;
    _selectedIndex = null; // 뒤로 갈 때 선택된 인덱스 초기화
    notifyListeners();
  }
}