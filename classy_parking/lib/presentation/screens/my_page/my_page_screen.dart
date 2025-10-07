import 'dart:ui';

import 'package:classy_parking/core/constants/font.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/traffic_light.dart';
import 'my_page_view_model.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => MyPageViewModel(),
          child: Consumer<MyPageViewModel>(
            builder: (context, viewModel, _) {
              final model = viewModel.myPageModel;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // 프로필 및 주차 상태
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.transparent,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: BackdropFilter(
                                    filter:
                                    ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                    child: Container(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      child: Center(
                                        child: Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: InteractiveViewer(
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              child: Image.asset(
                                                'assets/images/profile.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/profile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TrafficLight(
                              redColor: Colors.grey,
                              yellowColor: Colors.grey,
                              greenColor: Colors.green,
                              radius: 25,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '내 주차자리 상태',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: model.parkingStatus == '사용가능'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  model.parkingStatus,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 정보 카드
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _infoRow('닉네임', model.nickname),
                          _infoRow('전화번호', model.phoneNumber),
                          _infoRow('차종', model.carType),
                          _infoRow('차 이름', model.carName),
                          _infoRow('차 번호', model.carNumber),
                          const SizedBox(height: 20),
                          _licenseButton(model.isLicenseUploaded),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppFont.size16.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppFont.size16.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _licenseButton(bool isUploaded) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: 업로드 동작 연결
        },
        label: Text(
          isUploaded ? "운전면허증 업로드 완료" : "운전면허증 업로드 필요",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        icon: Icon(
          isUploaded ? Icons.check_circle : Icons.upload_file,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isUploaded ? Colors.blue : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}