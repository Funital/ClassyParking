import 'package:flutter/material.dart';
import 'agree_model.dart';

class AgreeViewModel extends ChangeNotifier {
  final List<AgreeModel> _agreements = [
    AgreeModel(title: "서비스 이용약관", isRequired: true),
    AgreeModel(title: "개인정보 수집/이용 동의", isRequired: true),
    AgreeModel(title: "위치 기반 서비스 이용약관 동의", isRequired: true),
    AgreeModel(title: "마케팅 정보수신 동의", isRequired: false),
  ];

  List<AgreeModel> get agreements => _agreements;

  /// 전체 동의 여부
  bool get isAllChecked =>
      _agreements.every((agreement) => agreement.isChecked);

  /// 필수 항목 모두 동의했는지 여부
  bool get isRequiredChecked =>
      _agreements.where((a) => a.isRequired).every((a) => a.isChecked);

  /// 전체 동의 토글
  void toggleAll(bool value) {
    for (var agreement in _agreements) {
      agreement.isChecked = value;
    }
    notifyListeners();
  }

  /// 개별 항목 토글
  void toggleAgreement(int index, bool value) {
    _agreements[index].isChecked = value;
    notifyListeners();
  }
}