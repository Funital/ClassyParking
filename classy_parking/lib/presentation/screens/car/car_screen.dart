import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color.dart';
import '../../../core/router/route_path.dart';
import '../../widgets/custom_bottom_button.dart';
import 'car_view_model.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarViewModel(),
      child: Consumer<CarViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false, // 키보드가 올라와도 레이아웃 밀리지 않음
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColor.main),
                onPressed: () => context.pop(),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: Consumer<CarViewModel>(
              builder: (context, viewModel, child) => CustomBottomButton(
                text: "다음",
                enabled: viewModel.isRequiredChecked,
                onPressed: viewModel.isRequiredChecked
                    ? () {
                  FocusScope.of(context).unfocus(); // 키보드 닫기
                  context.push(RoutePath.photo);
                }
                    : null,
              ),
            ),

            // GestureDetector로 감싸서 아무 곳 터치 시 키보드 닫기
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "차량번호를 입력하세요",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: viewModel.carNumberController,
                          decoration: InputDecoration(
                            hintText: "차량번호 입력",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 100), // 버튼과의 간격 확보
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}