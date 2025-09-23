import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login_model.dart';

class LoginViewModel extends ChangeNotifier {
  LoginModel? _loginModel;

  LoginModel? get loginModel => _loginModel;

  /// 로그인 실행
  void login(BuildContext context) {
    // TODO: 실제 로그인 API 연동
    debugPrint("로그인 실행");
    context.push(RoutePath.agree);
  }

  /// 회원가입 실행
  void signUp(BuildContext context) {
    // TODO: 회원가입 화면 이동 또는 API 연동
    debugPrint("회원가입 실행");
    context.push(RoutePath.agree);
  }

  /// 로그인 정보 저장 (옵션)
  void setLoginInfo(String userId, String password) {
    _loginModel = LoginModel(userId: userId, password: password);
    notifyListeners();
  }
}