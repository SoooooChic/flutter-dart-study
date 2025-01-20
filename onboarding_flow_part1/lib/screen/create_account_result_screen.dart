import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboarding_flow_part1/constants/gaps.dart';
import 'package:onboarding_flow_part1/constants/sizes.dart';
import 'package:onboarding_flow_part1/widgets/form_button.dart';

class CreateAccountResultScreen extends StatefulWidget {
  // const CreateAccountResultScreen({super.key});
  const CreateAccountResultScreen({
    super.key,
    required this.name,
    required this.email,
    required this.birthday,
  });

  final String name, email, birthday;

  @override
  State<CreateAccountResultScreen> createState() =>
      _CreateAccountResultScreenState();
}

class _CreateAccountResultScreenState extends State<CreateAccountResultScreen> {
  Map<String, String> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Gaps.v28,
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.blueAccent,
                size: Sizes.size28,
              ),
              Gaps.v28,
              Text(
                "Create your account",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gaps.v28,
              TextFormField(
                readOnly: true,
                initialValue: widget.name,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  suffixIcon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),
              TextFormField(
                readOnly: true,
                initialValue: widget.email,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  suffixIcon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),
              TextFormField(
                readOnly: true,
                initialValue: widget.birthday,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  suffixIcon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 100,
        child: Center(
            child: GestureDetector(
          child: FormButton(
            disabled: true,
            buttonSize: 0.8,
            buttonText: 'Sign up',
          ),
        )),
      ),
    );
  }
}
