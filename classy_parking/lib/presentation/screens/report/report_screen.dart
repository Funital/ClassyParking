import 'dart:io';

import 'package:classy_parking/core/constants/font.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/fixed_button_footer.dart';
import '../../widgets/text/horizonatal_labeled_toggle.dart';
import '../../widgets/text/horizontal_labeled_text_field.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> violationTypes = [
      '불법 주차',
      '소화전 앞 주차',
      '장애인 구역 위반'
    ];

    return Scaffold(
      appBar: CustomSubAppBar(title: '차량 신고하기'),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// 이미지 선택 영역
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: _selectedImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.file(
                      _selectedImage!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Column(
                    children: [
                      Icon(Icons.camera_alt,
                          color: Colors.blue, size: 120),
                      const SizedBox(height: 10),
                      Text(
                        '사진 촬영',
                        style: AppFont.size22.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// 입력 폼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 25),
                HorizontalLabeledTextField(
                    title: '차량 번호', hintText: '123가 1123'),
                const SizedBox(height: 25),
                HorizontalLabeledTextField(title: '위치', hintText: '안양'),
                const SizedBox(height: 25),
                HorizontalLabeledToggle(
                  title: '위반 유형',
                  hintText: '선택',
                  options: violationTypes,
                  selectedValue: null,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 25),

                /// 메모 입력
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '메모 (선택)',
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                /// 제출 버튼
                const FixedButtonFooter(text: '신고하기'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}