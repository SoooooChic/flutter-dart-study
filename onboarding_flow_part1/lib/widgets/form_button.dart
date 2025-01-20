import 'package:flutter/material.dart';
import 'package:onboarding_flow_part1/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    required this.buttonSize,
    required this.buttonText,
  });
  final bool disabled;
  final double buttonSize;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: buttonSize < 0.8 ? Alignment.centerRight : Alignment.center,
      child: FractionallySizedBox(
        widthFactor: buttonSize,
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size20),
            color: disabled ? Colors.black : Colors.grey,
          ),
          duration: const Duration(milliseconds: 500),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 500),
            style: TextStyle(
              color: disabled ? Colors.white : Colors.grey.shade200,
              fontWeight: FontWeight.w600,
            ),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
