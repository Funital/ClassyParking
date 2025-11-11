import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 상태 관리를 위해 Provider 추가
import 'login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ViewModel을 Provider로 관리하는 것이 일반적이지만,
    // 현재 파일 구조상 StatelessWidget 내에서 인스턴스화합니다.
    // 상태 변화를 추적하지 않는 간단한 View Model이므로 일단 이렇게 유지합니다.
    final viewModel = LoginViewModel();

    return Scaffold(
      // ⭐️ 속성을 Scaffold의 인자로 옮깁니다. (해결)
      resizeToAvoidBottomInset: false, // 키보드 올라올 때 레이아웃 변경 X

      // 이미지의 흐릿한 그라데이션 배경을 비슷하게 구현
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // 아무 곳 터치 시 키보드 닫기
          behavior: HitTestBehavior.translucent,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                // 이미지 상단의 로고 대체 (임시로 Text 위젯 사용)
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Image.asset(
                    'assets/images/logo.png', // 원하는 실제 로고 파일 경로로 교체하세요
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),

                const Text(
                  '주차의 품격',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),

                /// E-Mail 입력
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('이메일'),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'your@example.com',
                    hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF64B5F6), width: 1.5),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 30),

                /// 비밀번호 입력
                const Padding(
                  padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('비밀번호'),
                  ),
                ),
                const _PasswordField(), // 비밀번호 필드 재사용
                const SizedBox(height: 80),

                /// 로그인 버튼
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    viewModel.login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50), // 하단 간격 확보

                /// 회원가입 텍스트 링크
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "아직 계정이 없으신가요? ",
                      style: TextStyle(color: Color(0xFF8D8D8D)),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        viewModel.signUp(context);
                      },
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF64B5F6), // 파란색
                          decoration: TextDecoration.none, // 밑줄 제거
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50), // 하단 여백
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar 제거
    );
  }
}

/// 비밀번호 입력 필드 분리 (UnderlineInputBorder로 수정)
class _PasswordField extends StatefulWidget {
  const _PasswordField({super.key});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  // 이미지에 눈 아이콘이 없으므로 일단 제거하고 일반 텍스트 필드로 변경했습니다.
  // 만약 기능을 유지하고 싶다면 TextField 위젯 내부에 `obscureText: true` 만 남겨둡니다.
  @override
  Widget build(BuildContext context) {
    return const TextField(
      obscureText: true, // 비밀번호 숨김
      decoration: InputDecoration(
        hintText: 'yourpassword',
        hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        isDense: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF64B5F6), width: 1.5),
        ),
        // suffixIcon 제거
      ),
    );
  }
}