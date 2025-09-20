import 'package:flutter/material.dart';

enum CustomButtonType { danger, primary }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final CustomButtonType type;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Widget child;

    switch (type) {
      case CustomButtonType.danger:
        backgroundColor = Colors.red;
        child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        );
        break;

      case CustomButtonType.primary:
        backgroundColor = Colors.blue;
        child = Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
        break;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: child,
    );
  }
}