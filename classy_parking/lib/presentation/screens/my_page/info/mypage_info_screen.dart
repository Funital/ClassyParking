import 'package:classy_parking/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_sub_app_bar.dart';
import 'info_model.dart';
import 'info_view_model.dart';

class MypageInfoScreen extends StatelessWidget {
  const MypageInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InfoViewModel(),
      child: Scaffold(
        appBar: CustomSubAppBar(title: '내 정보'),
        body: Consumer<InfoViewModel>(
          builder: (context, viewModel, child) {
            final model = viewModel.model; // 모델 접근 용이

            return SingleChildScrollView( // 스크롤 가능하게 변경 (필드 추가로 인해)
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. 닉네임 설정 섹션 (기존 코드 유지) ---
                  const Text("닉네임 설정", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  _buildNicknameRow(viewModel), // 닉네임 입력 및 중복 확인 버튼

                  const SizedBox(height: 10),
                  // 안내/유효성 메시지
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      model.validationMessage ?? '2~8글자를 입력해 주세요.',
                      style: TextStyle(
                        fontSize: 14,
                        color: _getMessageColor(model),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30), // 섹션 구분 공간

                  // --- 2. 추가 정보 섹션 (5개 항목 추가) ---

                  _buildInfoField(
                    context,
                    label: '전화번호',
                    value: model.phoneNumber,
                    onTap: () => print('전화번호 수정 팝업'),
                  ),

                  _buildInfoField(
                    context,
                    label: '이메일',
                    value: model.email,
                    onTap: () => print('이메일 수정 팝업'),
                  ),

                  // _buildInfoField(
                  //   context,
                  //   label: '비밀번호 변경',
                  //   value: model.passwordPlaceholder, // *******
                  //   isSecure: true,
                  //   onTap: () => print('비밀번호 변경 화면'),
                  // ),

                  _buildInfoField(
                    context,
                    label: '차량 번호',
                    value: model.carNumber,
                    onTap: () => print('차량 정보 수정 팝업'),
                  ),

                  _buildInfoField(
                    context,
                    label: '차종/모델',
                    value: model.carModel,
                    onTap: () => print('차량 정보 수정 팝업'),
                  ),

                  const SizedBox(height: 30),

                  // TODO: 설정 완료 버튼 (필요시 추가)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 기존 닉네임 섹션 로직을 함수로 분리
  Widget _buildNicknameRow(InfoViewModel viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            onChanged: viewModel.updateNickname,
            controller: TextEditingController(text: viewModel.model.currentNickname)
              ..selection = TextSelection.fromPosition(
                  TextPosition(offset: viewModel.model.currentNickname.length)),
            decoration: InputDecoration(
              hintText: "닉네임을 입력하세요",
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 15),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 100,
          height: 50,
          child: ElevatedButton(
            onPressed: viewModel.model.isChecking
                ? null
                : () => viewModel.checkNicknameDuplication(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: viewModel.model.isChecking
                ? const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              ),
            )
                : const Text("중복 확인",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  // 추가 정보 필드를 위한 공통 위젯 (닉네임 필드 스타일과 유사하게)
  Widget _buildInfoField(
      BuildContext context, {
        required String label,
        required String value,
        VoidCallback? onTap,
        bool isSecure = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap, // 탭 시 수정 액션 실행
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    // 비밀번호 필드에만 가리기 적용
                    // style: isSecure ? TextStyle(letterSpacing: 3.0) : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // 유효성 메시지에 따라 색상 결정 (기존 함수 유지)
  Color _getMessageColor(InfoModel model) {
    if (model.validationMessage == '사용 가능한 닉네임입니다.') {
      return Colors.green;
    }
    if (model.validationMessage != null && model.validationMessage!.contains('사용 중')) {
      return Colors.red;
    }
    return Colors.grey.shade600;
  }
}