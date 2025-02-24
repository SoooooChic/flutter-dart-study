import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/auth_button.dart';
import 'create_account_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onSignTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateAccountScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gaps.v48,
              FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.blueAccent,
                size: Sizes.size28,
              ),
              Gaps.v80,
              Text(
                "See what's happening\nin the world right now.",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v96,
              const AuthButton(
                icon: FaIcon(FontAwesomeIcons.google),
                text: "Continue with Google",
                reversal: false,
              ),
              Gaps.v16,
              AuthButton(
                icon: FaIcon(FontAwesomeIcons.apple),
                text: "Continue with Apple",
                reversal: false,
              ),
              Gaps.v16,
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _onSignTap(context),
                child: AuthButton(
                  icon: null,
                  text: "Create account",
                  reversal: true,
                ),
              ),
              Gaps.v10,
              const Text(
                "By signing up, you agree to our Terms, Privacy Policy, and Cookie Use.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Have an account already?',
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h5,
              Text(
                'Log in',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
