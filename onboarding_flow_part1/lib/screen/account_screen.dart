import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboarding_flow_part1/constants/gaps.dart';
import 'package:onboarding_flow_part1/constants/sizes.dart';
import 'package:onboarding_flow_part1/widgets/auth_button.dart';
import 'package:onboarding_flow_part1/widgets/form_button.dart';
//import 'package:onboarding_flow_part1/features/authentication/login_screen.dart';
//import 'package:onboarding_flow_part1/features/authentication/username_screen.dart';
//import 'package:onboarding_flow_part1/features/authentication/widgets/auth_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<AccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }
  }

  // void _onLoginTap(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 5,
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        title: FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.blue,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  //textAlign: TextAlign.left,
                ),
                Gaps.v40,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Name',
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
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your email";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['name'] = newValue;
                    }
                  },
                ),
                Gaps.v32,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Phone number or email address',
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
                  ),
                ),
                Gaps.v32,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Date of birth',
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
                  ),
                ),
                Gaps.v32,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(disabled: false),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
