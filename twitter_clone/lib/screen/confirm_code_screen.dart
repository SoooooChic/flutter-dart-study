import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/form_button.dart';
import 'password_screen.dart';
// import 'sign_up_screen.dart';

class ConfirmCodeScreen extends StatefulWidget {
  const ConfirmCodeScreen({super.key});

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  static const String _code = '123456';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 텍스트 컨드롤러러
  final List<TextEditingController> _textController = [];

  // FOCUS 노드
  final List<FocusNode> _focusNodes = [];

  // Form 데이터 저장용 Map
  Map<String, String> formData = {};

  // 입력 텍스트 갯수
  final int _inputFields = 6;

  // 매치 검증
  bool _codeMatch = false;

  String _inputCode = '';

  @override
  void initState() {
    super.initState();

    // for 루프를 사용해 6개의 FocusNode 추가
    for (int i = 0; i < _inputFields; i++) {
      _textController.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    // for 루프를 사용해 6개의 FocusNode 추가
    for (int i = 0; i < _inputFields; i++) {
      _textController[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  void _onConfirmCodeTap() {
    // print(_codeMatch);

    if (_codeMatch) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PasswordScreen(),
        ),
      );
    }
  }

  void _onNextFocus(String value, int index) {
    setState(() {
      if (value.isNotEmpty) {
        if (index < _focusNodes.length - 1) _focusNodes[index].nextFocus();
        if (index == _focusNodes.length - 1) FocusScope.of(context).unfocus();

        _inputCode = '';

        for (int i = 0; i < _inputFields; i++) {
          _inputCode += _textController[i].text;
        }

        if (_inputCode == _code) {
          _codeMatch = true;
          FocusScope.of(context).unfocus();
        }
      } else {
        _codeMatch = false;
      }
    });
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
                          "We sent you a code",
                          style: TextStyle(
                            fontSize: Sizes.size24,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Gaps.v10,
                        Text(
                          'Enter it below to vefify\njhon.mobbin@gmail.com.',
                          style: TextStyle(
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v28,
                  Text(
                    'SENT CODE : $_code',
                    style: TextStyle(
                      color: Colors.red[300],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gaps.v10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 0; i < _inputFields; i++)
                        SizedBox(
                          width: Sizes.size28 + Sizes.size2,
                          child: TextFormField(
                            controller: _textController[i],
                            focusNode: _focusNodes[i],
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: TextStyle(
                              fontSize: Sizes.size24,
                              fontWeight: FontWeight.bold,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                            onChanged: (value) => _onNextFocus(value, i),
                          ),
                        ),
                    ],
                  ),
                  Gaps.v20,
                  AnimatedOpacity(
                    opacity: _codeMatch ? 1 : 0,
                    duration: Duration(microseconds: 500),
                    child: Center(
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: Sizes.size32,
                      ),
                    ),
                  )
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
              disabled: _codeMatch,
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
