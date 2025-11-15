import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';
import '../../../core/constants/font.dart';


class HorizontalLabeledToggle extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged;
  final List<String> options;
  final String? selectedValue;

  const HorizontalLabeledToggle({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.onChanged,
    required this.options,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 92,
          child: Text(
            title,
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
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                hintText: hintText,
                hintStyle: AppFont.size16.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              value: selectedValue,
              items: options.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    style: AppFont.size16.copyWith(fontWeight: FontWeight.w600),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
