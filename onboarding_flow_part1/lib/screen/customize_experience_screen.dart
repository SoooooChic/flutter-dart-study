import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboarding_flow_part1/constants/gaps.dart';
import 'package:onboarding_flow_part1/constants/sizes.dart';
import 'package:onboarding_flow_part1/widgets/form_button.dart';

class CustomizeExperienceScreen extends StatefulWidget {
  const CustomizeExperienceScreen({super.key});

  @override
  State<CustomizeExperienceScreen> createState() =>
      _CustomizeYourExperienceScreenState();
}

class _CustomizeYourExperienceScreenState
    extends State<CustomizeExperienceScreen> {
  bool agree = false;

  void _onSignResultTap() {
    if (agree) {
      Navigator.pop(context, agree);
    }
  }

  void _toggleButton() => setState(() => agree = !agree);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: Sizes.size20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blueAccent,
                  size: Sizes.size28,
                ),
              ),
              Gaps.v60,
              Text(
                "Customize your\nexperience",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              Gaps.v20,
              Text(
                "Track where you see Twitter\ncontent across the web",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              Gaps.v16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Twitter uses this data to\npersonalize yout experience. This\nweb browsing history will nver be\nstored with your name, email, or\nphone number.",
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  GestureDetector(
                    onTap: _toggleButton,
                    child: FaIcon(
                      agree
                          ? FontAwesomeIcons.toggleOn
                          : FontAwesomeIcons.toggleOff,
                      color: agree ? Colors.green : Colors.grey,
                      size: Sizes.size36,
                    ),
                  ),
                ],
              ),
              Gaps.v16,
              const Text(
                "By signing up, you agree to our Terms, Privacy Policy, and Cookie Use. Tiwtter may use your contact information, including your email address and phone number for purposes outlined in our Privacu Policy. Learn more",
                style: TextStyle(
                  fontSize: Sizes.size10 + Sizes.size3,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 100,
        child: GestureDetector(
          onTap: _onSignResultTap,
          child: FormButton(
            disabled: agree,
            buttonSize: 0.8,
            buttonText: 'Next',
            blueColor: false,
          ),
        ),
      ),
    );
  }
}
