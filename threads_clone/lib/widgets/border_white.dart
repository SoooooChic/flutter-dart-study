import 'package:flutter/material.dart';

class BorderWhite extends StatelessWidget {
  final Widget child;
  const BorderWhite({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border.fromBorderSide(
          BorderSide(
            color: Colors.white,
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }
}
