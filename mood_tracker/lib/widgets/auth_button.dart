import 'package:flutter/material.dart';
import 'package:mood_tracker/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const AuthButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size5),
            color: backgroundColor,
          ),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
