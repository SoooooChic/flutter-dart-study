import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/form_button.dart';
import 'interests_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 텍스트 컨드롤러
  final TextEditingController _passwordController = TextEditingController();

  String _password = '';

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onConfirmCodeTap() {
    if (_password.isNotEmpty && _isValidPassword()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InterestsScreen(),
        ),
      );
    }
  }

  // 비밀번호 유효성 검사
  bool _isValidPassword() {
    if (_password.isEmpty) return false;
    final passwordRegExp = RegExp(r"^[a-zA-Z0-9]{8,20}$");
    return passwordRegExp.hasMatch(_password);
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gaps.v28,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: Sizes.size20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.blueAccent,
                    size: Sizes.size28,
                  ),
                  Gaps.v24,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You'll need password",
                          style: TextStyle(
                            fontSize: Sizes.size24,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Gaps.v10,
                        Text(
                          'Make sure it\'s 8 characters or more.',
                          style: TextStyle(
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v28,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    autocorrect: false,
                    maxLength: 20,
                    decoration: InputDecoration(
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _toggleObscureText,
                            child: FaIcon(
                              _obscureText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: Colors.grey.shade500,
                              size: Sizes.size20,
                            ),
                          ),
                          Gaps.h10,
                          _password.isNotEmpty && _isValidPassword()
                              ? FaIcon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: Sizes.size20,
                                )
                              : Gaps.h20,
                        ],
                      ),
                      hintText: "Password",
                    ),
                  ),
                  Gaps.v28,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 280,
          child: GestureDetector(
            onTap: _onConfirmCodeTap,
            child: FormButton(
              disabled: _isValidPassword(),
              buttonSize: 0.8,
              buttonText: 'Next',
              blueColor: false,
            ),
          ),
        ),
      ),
    );
  }
}
