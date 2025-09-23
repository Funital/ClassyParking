import 'package:flutter/material.dart';

class FixedButtonFooter extends StatefulWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const FixedButtonFooter({
    super.key,
    required this.text,
    this.isEnabled = true,
    this.onPressed,
  });

  @override
  State<FixedButtonFooter> createState() => _FixedButtonFooterState();
}

class _FixedButtonFooterState extends State<FixedButtonFooter> {
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    /// SafeArea 사용
    return SafeArea(
      minimum: const EdgeInsets.only(left: 30, right: 30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTapDown: (_) {
            if (widget.isEnabled) setState(() => _buttonPressed = true);
          },
          onTapUp: (_) {
            if (widget.isEnabled) setState(() => _buttonPressed = false);
          },
          onTapCancel: () {
            if (widget.isEnabled) setState(() => _buttonPressed = false);
          },
          onTap: widget.isEnabled && widget.onPressed != null
              ? () {
            widget.onPressed!();
          }
              : null,
          child: Opacity(
            opacity: widget.isEnabled
                ? (_buttonPressed ? 0.7 : 1.0)
                : 0.5,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}