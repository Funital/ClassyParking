import 'package:classy_parking/presentation/screens/sign_up/sigin_up_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_path.dart';

class SignUpViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignUpModel? _signUpModel;
  SignUpModel? get signUpModel => _signUpModel;

  bool _isValid = false;
  bool get isValid => _isValid;

  /// 입력 검증
  void validate() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    _isValid = email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword;
    notifyListeners();
  }

  /// 제출 (회원가입)
  void submit(BuildContext context) {
    if (!_isValid) return;

    _signUpModel = SignUpModel(
      name: nameController.text,
      email: emailController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    context.push(RoutePath.car);
    debugPrint("회원가입 완료: ${_signUpModel!.email}");
    notifyListeners();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}