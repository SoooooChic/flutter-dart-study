import 'package:flutter/material.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../screen/confirm_code_screen.dart';
import 'form_button.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  void _onConfirmCodeTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ConfirmCodeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 230,
      child: Column(
        children: [
          Text(
            'By sining up, you agree to ther Terms of Service\nand Privacy Policy, including Cookie Use. Twitter\nmay use your contact information,including your\nemail address and phone number for purpose\noutlined in our Privacy Policy, like keeping your\naccount secure and pseronlizing our services,\nincluding ads. Learn more. Others will be able to\nfind you by email or phone number,when provided,\nunless you choose otherwise here.',
            style: TextStyle(
              fontSize: Sizes.size12,
            ),
          ),
          Gaps.v10,
          Center(
            child: GestureDetector(
              onTap: () => _onConfirmCodeTap(context),
              child: FormButton(
                disabled: false,
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
