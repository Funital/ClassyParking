import 'package:flutter/foundation.dart';

import 'info_model.dart';


class InfoViewModel extends ChangeNotifier {
  // 초기 닉네임 설정 (예: 기존 사용자 닉네임)
  InfoModel _model = InfoModel(
    currentNickname: '사랑',
    validationMessage: '2~8글자를 입력해 주세요.',
    phoneNumber: '010-1234-5678',
    email: 'salove0518@naver.com',
    carNumber: '123가 4567',
    carModel: '현대 쏘나타',
  );

  InfoModel get model => _model;

  // 닉네임 입력 시 업데이트
  void updateNickname(String newNickname) {
    bool isValidLength = newNickname.length >= 2 && newNickname.length <= 8;

    _model = _model.copyWith(
      currentNickname: newNickname,
      isNicknameValid: false, // 입력이 바뀌면 다시 중복 확인 필요
      validationMessage: isValidLength ? '중복 확인이 필요합니다.' : '2~8글자를 입력해 주세요.',
      isChecking: false,
    );
    notifyListeners();
  }

  // 닉네임 중복 확인 로직 (비동기 처리)
  Future<void> checkNicknameDuplication() async {
    final nickname = _model.currentNickname;

    if (nickname.length < 2 || nickname.length > 8) {
      _model = _model.copyWith(
        validationMessage: '닉네임은 2~8글자 사이여야 합니다.',
        isNicknameValid: false,
      );
      notifyListeners();
      return;
    }

    _model = _model.copyWith(isChecking: true, validationMessage: '중복 확인 중...');
    notifyListeners();

    // 2초 대기 후 서버 응답 시뮬레이션
    await Future.delayed(const Duration(seconds: 2));

    // 임시 로직: 'test'는 중복, 나머지는 사용 가능
    bool isDuplicated = nickname.toLowerCase() == 'test';

    if (isDuplicated) {
      _model = _model.copyWith(
        isChecking: false,
        validationMessage: '이미 사용 중인 닉네임입니다.',
        isNicknameValid: false,
      );
    } else {
      _model = _model.copyWith(
        isChecking: false,
        validationMessage: '사용 가능한 닉네임입니다.',
        isNicknameValid: true,
      );
    }
    notifyListeners();
  }

  // 닉네임 설정 완료 버튼 액션
  void completeNicknameSetting() {
    if (_model.isNicknameValid) {
      // TODO: 서버에 닉네임 최종 저장 후 다음 화면으로 이동
      print('닉네임 설정 완료: ${_model.currentNickname}');
    } else {
      print('닉네임 중복 확인이 필요합니다.');
    }
  }
}