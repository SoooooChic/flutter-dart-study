import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/view_models/login_view_model.dart';
import 'package:threads_clone/views/create_account_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String routeName = "login";
  static String routeURL = "/login";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
              context,
            );
        context.go('/');
      }
    }
  }

  void _onCreateAccountTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateAccountScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size24),
                color: Colors.black,
              ),
              child: FaIcon(
                FontAwesomeIcons.threads,
                size: Sizes.size64,
                color: Colors.white,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Gaps.v48,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Plase write your email";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['email'] = newValue;
                      }
                    },
                  ),
                  Gaps.v16,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Plase write your password";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['password'] = newValue;
                      }
                    },
                  ),
                  Gaps.v14,
                  GestureDetector(
                    onTap: _onSubmitTap,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Sizes.size14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size5),
                          color: Colors.blue[700],
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v14,
                  Text('Forgot Password?'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + Sizes.size12,
          left: Sizes.size20,
          right: Sizes.size20,
        ),
        child: GestureDetector(
          onTap: _onCreateAccountTap,
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size5),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                'Create New Account',
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
