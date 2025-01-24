import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/auth_text_form_field.dart';
import '../widgets/form_button.dart';
import '../widgets/sign_up.dart';
import 'customize_experience_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Form 데이터 저장용 Map
  Map<String, String> formData = {};

  // 각 TextFormField의 컨트롤러
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  // 입력 값 저장
  String _name = '';
  String _email = '';
  String _birthday = '';

  // 날짜 선택용 기본 값
  final DateTime _date = DateTime.now();

  // 약관 동의 상태 (customize_experience_screen pop)
  // bool _agreement = false;
  bool _agreement = true;

  @override
  void initState() {
    super.initState();

    // 입력 필드 변경 시 상태 업데이트
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

    _birthdayController.addListener(() {
      setState(() {
        _birthday = _birthdayController.text;
      });
    });
  }

  @override
  void dispose() {
    // 컨트롤러 해제
    _usernameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  // 이름 유효성 검사
  bool _isValidName(String name) {
    if (name.isEmpty) return false;
    final nameRegExp = RegExp(r"^[a-zA-Z0-9]{3,}$");
    return nameRegExp.hasMatch(name);
  }

  // 이메일 유효성 검사
  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(email);
  }

  // Next 버튼클릭릭 async await get _agreement
  void _onSubmitTap() async {
    if (_formKey.currentState != null) {
      // 모든 값이 유효한 경우
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

  // 화면 탭 시 키보드 해제
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  // 날짜 선택 후 텍스트 필드에 설정
  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  // showCupertinoModalPopup Modal 표시
  void _showDatePickerModal() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.white,
          child: CupertinoDatePicker(
            maximumDate: _date,
            initialDateTime: _date,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 화면 탭 시 키보드 해제용 GestureDetector
      onTap: _onScaffoldTap,
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Gaps.v28,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
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
                  // 이름 입력 필드
                  AuthTextFormField(
                    controller: _usernameController,
                    hintText: 'Name',
                    errorText: _name.isEmpty || _isValidName(_name)
                        ? null
                        : "Input a valid name",
                    readOnly: _agreement,
                    suffixIcon: _isValidName(_name)
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : Text(' '),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['name'] = newValue;
                      }
                    },
                  ),
                  // 이메일 입력 필드
                  AuthTextFormField(
                    controller: _emailController,
                    hintText: 'Email address',
                    errorText: _email.isEmpty || _isValidEmail(_email)
                        ? null
                        : "Input a valid email",
                    readOnly: _agreement,
                    suffixIcon: _isValidEmail(_email)
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : Text(' '),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['email'] = newValue;
                      }
                    },
                  ),
                  // 생년월일 입력 필드
                  AuthTextFormField(
                    controller: _birthdayController,
                    hintText: 'Date of birth',
                    helperText: _agreement
                        ? " "
                        : _birthday.isNotEmpty
                            ? "This will not be shown publicly. Confirm your\nown age, even if this account is for a\nbusiness, a pet, or something else."
                            : " ",
                    readOnly: true,
                    suffixIcon: _birthday.isNotEmpty
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : Text(' '),
                    onTap: _agreement ? null : _showDatePickerModal,
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['birthday'] = newValue;
                      }
                    },
                  ),
                  Gaps.v60,
                  // "Next" 버튼
                  !_agreement
                      ? GestureDetector(
                          onTap: _onSubmitTap,
                          child: FormButton(
                            disabled: (_isValidName(_name) &&
                                _isValidEmail(_email) &&
                                _birthday.isNotEmpty),
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
        // 표시 _agreement 상태에 따라 결정
        bottomNavigationBar: _agreement ? SignUpWidget() : null,
      ),
    );
  }
}
