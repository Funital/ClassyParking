import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';
import '../../../core/constants/font.dart';


class HorizontalLabeledTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  // 초기값을 받을 수 있도록 필드 추가
  final String? initialValue;

  const HorizontalLabeledTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.initialValue, // <<< 초기값을 선택적으로 받습니다.
  });

  @override
  State<HorizontalLabeledTextField> createState() => _HorizontalLabeledTextFieldState();
}

class _HorizontalLabeledTextFieldState extends State<HorizontalLabeledTextField> {
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    // 1. 외부에서 controller를 제공하면 그것을 사용합니다.
    if (widget.controller != null) {
      _internalController = widget.controller!;
    } else {
      // 2. 외부에서 controller가 없으면 내부 controller를 생성하고 initialValue로 초기화합니다.
      _internalController = TextEditingController(text: widget.initialValue);
    }
  }

  @override
  void didUpdateWidget(covariant HorizontalLabeledTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // initialValue가 변경되었고, 외부 controller를 사용하지 않을 때만 업데이트합니다.
    if (widget.initialValue != oldWidget.initialValue && widget.controller == null) {
      _internalController.text = widget.initialValue ?? '';
    }
  }

  // 외부 controller를 사용하지 않는 경우 메모리 관리를 위해 dispose합니다.
  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 92,
          child: Text(
            widget.title,
            style: AppFont.size16.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.main, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _internalController, // 내부 컨트롤러 사용
              onChanged: widget.onChanged,
              style: AppFont.size16.copyWith(fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                hintText: widget.hintText,
                hintStyle: AppFont.size16.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}