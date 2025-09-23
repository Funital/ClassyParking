import 'package:classy_parking/core/constants/font.dart';
import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'agree_view_model.dart';

class AgreeScreen extends StatelessWidget {
  const AgreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AgreeViewModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.brown),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<AgreeViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "약관에 동의하시면\n회원가입이 완료됩니다.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),

                  /// 전체 동의
                  Row(
                    children: [
                      Checkbox(
                        value: viewModel.isAllChecked,
                        onChanged: (value) {
                          viewModel.toggleAll(value ?? false);
                        },
                        activeColor: Colors.blue,
                      ),
                      const Text(
                        "전체 동의",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),

                  /// 개별 동의 목록
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.agreements.length,
                      itemBuilder: (context, index) {
                        final agreement = viewModel.agreements[index];
                        return ListTile(
                          leading: Checkbox(
                            value: agreement.isChecked,
                            onChanged: (value) {
                              viewModel.toggleAgreement(
                                  index, value ?? false);
                            },
                            activeColor: Colors.blue,
                          ),
                          title: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  agreement.isRequired ? "(필수) " : "(선택) ",
                                  style: TextStyle(
                                    color: agreement.isRequired
                                        ? Colors.black
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: agreement.title,
                                  style: TextStyle(
                                    color: agreement.isRequired
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        );
                      },
                    ),
                  ),

                  /// 가입 완료 버튼
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: viewModel.isRequiredChecked
                            ? () {
                          context.push(RoutePath.signup);
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor: Colors.grey.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                            "가입 완료",
                            style: AppFont.size18.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}