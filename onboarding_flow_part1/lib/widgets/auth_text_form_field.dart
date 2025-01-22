import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? helperText;
  final String? errorText;
  final bool readOnly;
  final Widget suffixIcon;
  final void Function()? onTap;
  final void Function(String?)? onSaved;

  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.helperText,
    this.errorText,
    this.readOnly = false,
    required this.suffixIcon,
    this.onTap,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        helperText: helperText ?? " ",
        errorText: errorText,
        suffixIcon: suffixIcon,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
      onSaved: onSaved,
    );
  }
}
