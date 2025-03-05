import 'package:flutter/material.dart';
import 'package:mood_tracker/constants/gaps.dart';

class AuthForm extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final FormFieldValidator<String>? emailValidator;
  final FormFieldValidator<String>? passwordValidator;
  final Function(String?)? onEmailSaved;
  final Function(String?)? onPasswordSaved;

  const AuthForm({
    super.key,
    this.emailController,
    this.passwordController,
    this.emailValidator,
    this.passwordValidator,
    this.onEmailSaved,
    this.onPasswordSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          validator: emailValidator,
          onSaved: onEmailSaved,
        ),
        Gaps.v16,
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          validator: passwordValidator,
          onSaved: onPasswordSaved,
        ),
      ],
    );
  }
}
