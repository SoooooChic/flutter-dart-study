import 'dart:math';

import 'package:flutter/material.dart';

class Assignment31FlashcardsApp extends StatefulWidget {
  const Assignment31FlashcardsApp({super.key});

  @override
  State<Assignment31FlashcardsApp> createState() =>
      _Assignment31FlashcardsAppState();
}

class _Assignment31FlashcardsAppState extends State<Assignment31FlashcardsApp>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final Tween<double> _rotation = Tween(begin: -15, end: 15);

  late final Tween<double> _scale = Tween(begin: 0.8, end: 1);

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
  }

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index == 5 ? 1 : _index + 1;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    final dropZone = size.width + 100;
    if (_position.value.abs() >= bound) {
      final factor = _position.value.isNegative ? -1 : 1;
      _position
          .animateTo((dropZone) * factor, curve: Curves.easeOut)
          .whenComplete(_whenComplete);
    } else {
      _position.animateTo(0, curve: Curves.easeOut);
    }
  }

  int _index = 1;

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: const Text('Flashcards App')),
      body: Column(
        children: [
          SizedBox(height: 100),
          Text("Need to review"),
          Expanded(
            child: AnimatedBuilder(
              animation: _position,
              builder: (context, child) {
                final angle =
                    _rotation.transform(
                      (_position.value + size.width / 2) / size.width,
                    ) *
                    pi /
                    180;
                final scale = _scale.transform(
                  _position.value.abs() / size.width,
                );
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 50,
                      child: Transform.scale(
                        scale: min(scale, 1.0),
                        child: Card(index: _index == 5 ? 1 : _index + 1),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: GestureDetector(
                        onHorizontalDragUpdate: _onHorizontalDragUpdate,
                        onHorizontalDragEnd: _onHorizontalDragEnd,
                        child: Transform.translate(
                          offset: Offset(_position.value, 0),
                          child: Transform.rotate(
                            angle: angle,
                            child: Card(index: _index),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          CustomPaint(
            painter: ProgressPainter(progress: 1.0),
            size: Size(size.width * 0.8, 50),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;

  const Card({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: Container(
        color: Colors.grey[100],
        width: size.width * 0.8,
        height: size.height * 0.5,
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(0, size.height - 50);
    final end = Offset(size.width, size.height - 50);

    final end2 = Offset(size.width / 2, size.height - 50);

    final backgroundPaint =
        Paint()
          ..color = Colors.black.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 15;
    canvas.drawLine(start, end, backgroundPaint);

    final arcPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 15;

    canvas.drawLine(start, end2, arcPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
