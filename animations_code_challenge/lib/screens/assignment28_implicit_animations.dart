import 'package:flutter/material.dart';

class Assignment28ImplicitAnimations extends StatefulWidget {
  const Assignment28ImplicitAnimations({super.key});

  @override
  State<Assignment28ImplicitAnimations> createState() =>
      _Assignment28ImplicitAnimationsState();
}

class _Assignment28ImplicitAnimationsState
    extends State<Assignment28ImplicitAnimations> {
  bool _isToggle = true;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isToggle = !_isToggle;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _isToggle ? Colors.grey[100] : Colors.black,
      appBar: AppBar(title: const Text('Implicit Animations')),
      body: GestureDetector(
        child: Center(
          child: SizedBox(
            height: size.width * 0.8,
            width: size.width * 0.8,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: _isToggle ? BoxShape.circle : BoxShape.rectangle,
                  ),
                ),
                AnimatedAlign(
                  alignment:
                      _isToggle ? Alignment.centerLeft : Alignment.centerRight,
                  duration: Duration(seconds: 1),
                  child: Container(
                    width: 20,
                    color: _isToggle ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
