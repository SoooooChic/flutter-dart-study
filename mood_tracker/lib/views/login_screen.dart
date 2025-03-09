import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/util.dart';
import 'package:mood_tracker/view_model/auth_view_model.dart';
import 'package:mood_tracker/views/create_account_screen.dart';
import 'package:mood_tracker/widgets/action_button.dart';
import 'package:mood_tracker/widgets/auth_form.dart';
import 'package:mood_tracker/widgets/heart_beat.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String routeName = "login";
  static String routeURL = "/login";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> formData = {};

  void _onSubmitTap() async {
    final auth = ref.read(authServiceProvider);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await auth.signInWithEmail(formData['email']!, formData['password']!);
        if (mounted) context.go('/');
      } catch (e) {
        // ignore: use_build_context_synchronously
        showFirebaseErrorSnack(context, e);
      }
    }
  }

  void _onCreateAccountTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateAccountScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                onEmailSaved: (newValue) => formData['email'] = newValue ?? '',
                onPasswordSaved:
                    (newValue) => formData['password'] = newValue ?? '',
              ),
            ),
            Gaps.v14,
            ActionButton(text: 'Log in', onTap: _onSubmitTap),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 12,
          left: 20,
          right: 20,
        ),
        child: ActionButton(
          text: 'Create New Account',
          onTap: () => _onCreateAccountTap(context),
          backgroundColor: Colors.transparent,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
