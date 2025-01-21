import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboarding_flow_part1/constants/gaps.dart';
import 'package:onboarding_flow_part1/constants/sizes.dart';
import 'package:onboarding_flow_part1/screen/customize_experience_screen.dart';
import 'package:onboarding_flow_part1/widgets/form_button.dart';
import 'package:onboarding_flow_part1/widgets/sign_up.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final FocusNode _birthdayFocusNode = FocusNode();

  String _name = '';
  String _email = '';
  DateTime date = DateTime.now();
  bool _showDatePicker = false;
  bool _agreement = false;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _name = _usernameController.text;
      });
    });

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });

    _birthdayFocusNode.addListener(() {
      setState(() {
        _showDatePicker = _birthdayFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    _birthdayFocusNode.dispose();
    super.dispose();
  }

  bool _isValidName(String name) {
    if (name.isEmpty) return false;
    final emailRegExp = RegExp(r"^[a-zA-Z0-9]{3,}$");
    return emailRegExp.hasMatch(name);
  }

  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(email);
  }

  void _onSubmitTap() async {
    if (_formKey.currentState != null) {
      if (_isValidName(_name) &&
          _isValidEmail(_email) &&
          _birthdayController.text.isNotEmpty) {
        _formKey.currentState!.save();

        final agreement = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CustomizeExperienceScreen(),
          ),
        );

        if (agreement == true) {
          _agreement = agreement;
          setState(() {});
        }
      }
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
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
                      child: _agreement
                          ? Icon(
                              Icons.arrow_back_ios,
                              size: Sizes.size20,
                              color: Colors.black,
                            )
                          : Text(
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
                  Gaps.v24,
                  Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gaps.v24,
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    readOnly: _agreement,
                    scrollPadding: EdgeInsets.all(0),
                    decoration: InputDecoration(
                      hintText: 'Name',
                      helperText: " ",
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
                      errorText: _name.isEmpty
                          ? null
                          : (_isValidName(_name) ? null : "Input a valid name"),
                      suffixIcon: _isValidName(_name)
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : Text(' '),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['name'] = newValue;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    readOnly: _agreement,
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      helperText: " ",
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
                      errorText: _email.isEmpty
                          ? null
                          : (_isValidEmail(_email)
                              ? null
                              : "Input a valid email"),
                      suffixIcon: _isValidEmail(_email)
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : Text(' '),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['email'] = newValue;
                      }
                    },
                  ),
                  TextFormField(
                    focusNode: _birthdayFocusNode,
                    controller: _birthdayController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Date of birth',
                      helperText: _agreement
                          ? " "
                          : _birthdayController.text.isNotEmpty
                              ? "This will not be shown publicly.Confirm your\nown age,even if this account is for a\nbusiness, a pet, or something else."
                              : " ",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      suffixIcon: _birthdayController.text.isNotEmpty
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : Text(' '),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['birthday'] = newValue;
                      }
                    },
                  ),
                  Gaps.v60,
                  !_agreement
                      ? GestureDetector(
                          onTap: _onSubmitTap,
                          child: FormButton(
                            disabled: (_isValidName(_name) &&
                                _isValidEmail(_email) &&
                                _birthdayController.text.isNotEmpty),
                            buttonSize: 0.25,
                            buttonText: 'Next',
                            blueColor: false,
                          ),
                        )
                      : Gaps.v10,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: !_agreement && _showDatePicker
            ? SizedBox(
                height: 110,
                child: CupertinoDatePicker(
                  maximumDate: date,
                  initialDateTime: date,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: _setTextFieldDate,
                ),
              )
            : _agreement
                ? SignUpWidget()
                : null,
      ),
    );
  }
}
