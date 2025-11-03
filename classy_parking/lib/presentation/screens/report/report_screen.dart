// lib/screens/report_screen.dart

import 'dart:io';
import 'package:classy_parking/core/constants/font.dart';
import 'package:classy_parking/core/router/route_path.dart';
import 'package:classy_parking/presentation/widgets/custom_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/text/horizonatal_labeled_toggle.dart';
import '../../widgets/text/horizontal_labeled_text_field.dart';

import 'report_view_model.dart';
import 'report_model.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  static const double _kFooterHeight = 90.0;

  @override
  Widget build(BuildContext context) {
    // ✅ ChangeNotifierProvider.value를 사용하여 기존 인스턴스 재사용
    return ChangeNotifierProvider.value(
      value: ReportViewModel(), // 싱글톤 인스턴스 사용
      child: Consumer<ReportViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: const CustomSubAppBar(title: '차량 신고하기'),
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                SafeArea(
                  bottom: false,
                  child: _buildContent(context, viewModel),
                ),
                _buildFooter(context, viewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ReportViewModel viewModel) {
    final model = viewModel.model;
    final List<String> violationTypes = ['불법 주차', '소화전 앞 주차', '장애인 구역 위반'];

    Future<void> pickImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // viewModel.updateImage(File(pickedFile.path).path);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
          left: 20, right: 20, top: 20, bottom: _kFooterHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageAttachment(model.imagePath, pickImage),
          const SizedBox(height: 30),
          _buildReportFields(context, viewModel, violationTypes),
        ],
      ),
    );
  }

  Widget _buildImageAttachment(String? imagePath, Function() onPickImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '사진 첨부',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),
        GestureDetector(
          onTap: onPickImage,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: imagePath != null
                ? Image.file(File(imagePath!), fit: BoxFit.cover)
                : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Colors.grey, size: 40),
                  SizedBox(height: 8),
                  Text('사진 첨부하기 (선택)', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportFields(BuildContext context, ReportViewModel viewModel, List<String> violationTypes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HorizontalLabeledTextField(
          title: '차량 번호',
          hintText: '차량 번호 입력 (예: 123가 4567)',
          onChanged: viewModel.updateCarNumber,
          initialValue: viewModel.model.carNumber,
        ),
        const SizedBox(height: 25),

        HorizontalLabeledTextField(
          title: '위치',
          hintText: '위치 입력 (예: 주차장 A동 1층)',
          onChanged: viewModel.updateLocation,
          initialValue: viewModel.model.locationAddress,
        ),
        const SizedBox(height: 25),

        HorizontalLabeledToggle(
          title: '위반 유형',
          hintText: '위반 유형을 선택하세요.',
          options: violationTypes,
          selectedValue: viewModel.model.violationType.isNotEmpty ? viewModel.model.violationType : null,
          onChanged: (value) => viewModel.updateViolationType(value!),
        ),
        const SizedBox(height: 25),

        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            onChanged: viewModel.updateMemo,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '메모 (선택)',
            ),
            maxLines: null,
            expands: true,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, ReportViewModel viewModel) {
    final model = viewModel.model;
    bool isFirstReportAwaiting = model.currentStep == ReportStep.firstReport;
    bool isTimerActive = isFirstReportAwaiting && model.buttonText.contains('초');
    bool isSecondReportReady = isFirstReportAwaiting && !isTimerActive;

    bool isButtonEnabled = model.isSubmitting == false &&
        (model.currentStep == ReportStep.initial || isSecondReportReady);

    final double safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 15.0,
          bottom: safeAreaBottom + 15.0,
        ),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: isButtonEnabled
                ? () => viewModel.handleReportSubmission(context)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonEnabled ? Colors.red : Colors.grey.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            icon: isButtonEnabled
                ? const Icon(Icons.warning, size: 24)
                : const Icon(Icons.lock, size: 24),
            label: Text(
              model.buttonText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}