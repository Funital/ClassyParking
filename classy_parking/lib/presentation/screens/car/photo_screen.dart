import 'dart:io';

import 'package:classy_parking/core/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color.dart';
import '../../widgets/custom_bottom_button.dart';
import 'photo_view_model.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhotoViewModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.main),
            onPressed: () => context.pop(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Consumer<PhotoViewModel>(
          builder: (context, viewModel, child) => CustomBottomButton(
            text: "회원가입 완료하기",
            onPressed: () => context.push(RoutePath.home_video),
          ),
        ),
        body: SafeArea(
          child: Consumer<PhotoViewModel>(
            builder: (context, viewModel, child) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "운전면허증 등록",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /// 상단 콘텐츠 (제목 + 가이드 박스)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// 가이드 박스
                            GestureDetector(
                              onTap: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.camera,
                                );

                                if (pickedFile != null) {
                                  viewModel.setPhoto(
                                    pickedFile.path,
                                  ); // ViewModel에 저장
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: viewModel.photo.imagePath != null
                                    ? Image.file(
                                  File(viewModel.photo.imagePath!),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                )
                                    : Column(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 80,
                                      color: AppColor.main,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "가이드에 맞춰 면허증을 촬영해주세요",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            TextButton(
                              onPressed: () {
                                // TODO: 수정하기 로직
                              },
                              child: const Text(
                                "직접 입력하기",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColor.main,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
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