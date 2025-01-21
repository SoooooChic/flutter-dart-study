import 'package:flutter/material.dart';
import 'package:onboarding_flow_part1/constants/gaps.dart';
import 'package:onboarding_flow_part1/widgets/form_button.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 260,
      child: Column(
        children: [
          Text(
              'By sining up, you agree to ther Terms of Service\nand Privacy Policy, including Cookie Use. Twitter\nmay use your contact information,including your\nemail address and phone number for purpose\noutlined in our Privacy Policy, like keeping your\naccount secure and pseronlizing our services,\nincluding ads. Learn more. Others will be able to\nfind you by email or phone number,when provided,\nunless you choose otherwise here.'),
          Gaps.v20,
          Center(
            child: GestureDetector(
              child: FormButton(
                disabled: true,
                buttonSize: 0.8,
                buttonText: 'Sign up',
                blueColor: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
