import 'package:flutter/material.dart';
import 'photo_model.dart';

class PhotoViewModel extends ChangeNotifier {
  PhotoModel _photo = PhotoModel();
  PhotoModel get photo => _photo;

  /// 사진 촬영/선택 시 호출
  void setPhoto(String path) {
    _photo = PhotoModel(imagePath: path);
    notifyListeners();
  }

  /// 사진 제거
  void clearPhoto() {
    _photo = PhotoModel();
    notifyListeners();
  }
}