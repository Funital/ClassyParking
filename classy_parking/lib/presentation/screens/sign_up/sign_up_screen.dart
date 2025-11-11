import 'package:classy_parking/presentation/screens/sign_up/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color.dart';
import '../../../core/router/route_path.dart';
import '../../widgets/custom_bottom_button.dart';
import '../../widgets/custom_sub_app_bar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드가 올라와도 화면 전체 밀리지 않음
        appBar: CustomSubAppBar(title: ''),
        bottomNavigationBar: Consumer<SignUpViewModel>(
          builder: (context, viewModel, child) => CustomBottomButton(
            text: "다음",
            enabled: viewModel.isValid,
            onPressed: viewModel.isValid
                ? () {
              FocusScope.of(context).unfocus(); // 키보드 닫기
              viewModel.submit(context);
            }
                : null,
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(), // 아무 곳 터치 시 키보드 닫기
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<SignUpViewModel>(
                builder: (context, viewModel, child) {
                  return SingleChildScrollView(
                    // 입력 영역만 스크롤 가능
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "회원가입 하기",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),

                        /// 이름
                        const Text(
                          "이름",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: viewModel.nameController,
                          decoration: const InputDecoration(
                            hintText: "이름 입력",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.main),
                            ),
                          ),
                          onChanged: (_) => viewModel.validate(),
                        ),
                        const SizedBox(height: 16),

                        /// 이메일
                        const Text(
                          "이메일",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: viewModel.emailController,
                          decoration: const InputDecoration(
                            hintText: "이메일 주소 입력",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.main),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (_) => viewModel.validate(),
                        ),
                        const SizedBox(height: 16),

                        /// 비밀번호
                        const Text(
                          "비밀번호",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: viewModel.passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "비밀번호 (영문, 숫자, 특수문자)",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.main),
                            ),
                          ),
                          onChanged: (_) => viewModel.validate(),
                        ),
                        const SizedBox(height: 16),

                        /// 비밀번호 확인
                        const Text(
                          "비밀번호 확인",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: viewModel.confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "비밀번호 확인",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.main),
                            ),
                          ),
                          onChanged: (_) => viewModel.validate(),
                        ),

                        const SizedBox(height: 100), // 버튼과의 간격 확보
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}