import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon? icon;
  final bool reversal;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.reversal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Sizes.size10),
      decoration: BoxDecoration(
        color: reversal ? Colors.black : Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: Sizes.size1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          if (icon != null) Gaps.h10,
          Text(
            text,
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w800,
              color: reversal ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
