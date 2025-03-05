import 'package:flutter/material.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/widgets/auth_button.dart';
import 'package:mood_tracker/widgets/auth_form.dart';
import 'package:mood_tracker/widgets/heart_beat.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // 폼 데이터 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeartBeat(),
              Gaps.v60,
              Form(
                key: _formKey,
                child: AuthForm(
                  onEmailSaved:
                      (newValue) => formData['email'] = newValue ?? '',
                  onPasswordSaved:
                      (newValue) => formData['password'] = newValue ?? '',
                ),
              ),
              Gaps.v14,
              AuthButton(text: 'Create Account', onTap: _onSubmitTap),
            ],
          ),
        ),
      ),
    );
  }
}
