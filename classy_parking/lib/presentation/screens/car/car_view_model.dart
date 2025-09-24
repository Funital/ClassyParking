import 'package:flutter/material.dart';

class CarViewModel extends ChangeNotifier {
  final TextEditingController carNumberController = TextEditingController();

  bool _isRequiredChecked = false;
  bool get isRequiredChecked => _isRequiredChecked;

  CarViewModel() {
    carNumberController.addListener(_validateCarNumber);
  }

  void _validateCarNumber() {
    _isRequiredChecked = carNumberController.text.trim().isNotEmpty;
    notifyListeners();
  }

  @override
  void dispose() {
    carNumberController.dispose();
    super.dispose();
  }
}