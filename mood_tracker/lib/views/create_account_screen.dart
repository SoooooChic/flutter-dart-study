import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/util.dart';
import 'package:mood_tracker/view_model/auth_view_model.dart';
import 'package:mood_tracker/widgets/auth_button.dart';
import 'package:mood_tracker/widgets/auth_form.dart';
import 'package:mood_tracker/widgets/heart_beat.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> formData = {};

  void _onSubmitTap() async {
    final auth = ref.read(authServiceProvider);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await auth.signUpWithEmail(formData['email']!, formData['password']!);
        if (mounted) context.go('/');
      } catch (e) {
        // ignore: use_build_context_synchronously
        showFirebaseErrorSnack(context, e);
      }
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
