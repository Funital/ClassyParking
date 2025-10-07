import 'package:classy_parking/presentation/screens/sign_up/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드가 올라와도 화면 전체 밀리지 않음
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => context.pop(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
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
                              borderSide: BorderSide(color: Colors.blue),
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
                              borderSide: BorderSide(color: Colors.blue),
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
                              borderSide: BorderSide(color: Colors.blue),
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
                              borderSide: BorderSide(color: Colors.blue),
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

        /// 하단 고정 버튼
        bottomNavigationBar: SafeArea(
          top: false,
          minimum: const EdgeInsets.all(20.0),
          child: Consumer<SignUpViewModel>(
            builder: (context, viewModel, _) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.isValid
                      ? () {
                    FocusScope.of(context).unfocus(); // 키보드 닫기
                    viewModel.submit(context);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: viewModel.isValid
                        ? Colors.blue
                        : Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "다음",
                    style: TextStyle(
                      color: viewModel.isValid
                          ? Colors.white
                          : Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}