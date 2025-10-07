import 'package:classy_parking/presentation/screens/setting/setting_view_model.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/font.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSubAppBar(title: '설정',),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => SettingViewModel(),
          child: Consumer<SettingViewModel>(
            builder: (context, viewModel, _) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // ------------------------
                    // 알림 설정
                    // ------------------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '알림',
                          style: AppFont.size16.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const Divider(thickness: 1, height: 20),

                        // PUSH 알림
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PUSH 알림',
                              style: AppFont.size16.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                              value: viewModel.isPushEnabled,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.blue,
                              inactiveThumbColor: Colors.blue,
                              inactiveTrackColor:
                              Colors.grey.withOpacity(0.4),
                              onChanged: (value) {
                                viewModel.togglePushNotification(value);
                              },
                            ),
                          ],
                        ),

                        // 마케팅 알림 수신 동의
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '마케팅 알림 수신 동의',
                              style: AppFont.size16.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                              value: viewModel.isMarketingAgreed,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.blue,
                              inactiveThumbColor: Colors.blue,
                              inactiveTrackColor:
                              Colors.grey.withOpacity(0.4),
                              onChanged: (value) {
                                viewModel.toggleMarketingAgreement(value);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '고객 지원',
                          style: AppFont.size16.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const Divider(thickness: 1, height: 20),

                        // 버전 정보
                        ListTile(
                          title: Text(
                            '버전 정보',
                            style: AppFont.size16.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Text(
                            '1.0.0',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {},
                        ),

                        // 문의하기
                        ListTile(
                          title: Text(
                            '문의하기',
                            style: AppFont.size16.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right,
                              color: Colors.blue),
                          onTap: () {
                            // TODO: 문의 페이지로 이동
                          },
                        ),

                        // 로그아웃
                        ListTile(
                          title: Text(
                            '로그아웃',
                            style: AppFont.size16.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right,
                              color: Colors.blue),
                          onTap: () {
                            // TODO: 로그아웃 로직
                          },
                        ),

                        // 계정 탈퇴
                        ListTile(
                          title: Text(
                            '계정 탈퇴',
                            style: AppFont.size16.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.redAccent,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right,
                              color: Colors.blue),
                          onTap: () {
                            // TODO: 계정 탈퇴 로직
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}