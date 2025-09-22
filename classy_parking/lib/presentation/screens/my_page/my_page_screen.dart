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
      appBar: CustomSubAppBar(title: '마이페이지',),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                const SizedBox(height: 20),

                // 내용 카드
                Expanded(
                  child: ChangeNotifierProvider(
                    create: (_) => MyPageViewModel(),
                    child: Consumer<MyPageViewModel>(
                      builder: (context, viewModel, _) {
                        final model = viewModel.myPageModel;
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      model.nickname.isNotEmpty ? model.nickname[0] : '',
                                      style: const TextStyle(fontSize: 40),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Column(
                                  children: [
                                    TrafficLight(
                                      redColor: Colors.grey,
                                      yellowColor: Colors.grey,
                                      greenColor: Colors.green,
                                      radius: 20,
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    ),
                                    // 주차 상태
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '내 주차자리 상태',
                                            style: TextStyle(color: Colors.grey, fontSize: 12),
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
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
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
                                    const Spacer(),
                                    _licenseButton(model.isLicenseUploaded),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
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
        icon: Icon(
          isUploaded ? Icons.check_circle : Icons.upload_file,
          color: Colors.white,
        ),
        label: Text(
          isUploaded ? "운전면허증 업로드 완료" : "운전면허증 업로드 필요",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
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