import 'dart:math';
import 'package:flutter/material.dart';

List<Map<String, String>> quizList = [
  {"question": "지구에서 가장 큰 대륙은?", "answer": "아시아"},
  {"question": "태양계에서 가장 큰 행성은?", "answer": "목성"},
  {"question": "빛의 속도는 초속 약 몇 km인가?", "answer": "약 30만 km"},
  {"question": "한국의 수도는?", "answer": "서울"},
  {"question": "피카소가 주로 활동한 예술 장르는?", "answer": "입체파 (큐비즘)"},
];

class Assignment31FlashcardsApp extends StatefulWidget {
  const Assignment31FlashcardsApp({super.key});

  @override
  State<Assignment31FlashcardsApp> createState() =>
      _Assignment31FlashcardsAppState();
}

class _Assignment31FlashcardsAppState extends State<Assignment31FlashcardsApp>
    with TickerProviderStateMixin {
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

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  late final Animation<double> _turn = Tween<double>(
    begin: 0.0,
    end: pi,
  ).animate(_controller)..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _isFront = !_isFront;
      });
    }
  });

  bool _isDrag = false;
  int _index = 0;
  bool _isFront = true;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_isFront) return;
    setState(() {
      _isDrag = true;
      _position.value += details.delta.dx;
    });
  }

  void _whenComplete() {
    if (_isFront) return;
    _position.value = 0;
    _controller.value = 0;
    _isFront = true;
    _isDrag = false;
    setState(() {
      _index = (_index + 1) == quizList.length ? 0 : _index + 1;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_isFront) return;
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

    setState(() {
      _isDrag = false;
    });
  }

  void _tapCard() {
    if (_controller.isAnimating) return;

    if (_isFront) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double swipeRatio = (_position.value.abs() / size.width).clamp(0.5, 1);
    Color backgroundColor =
        Color.lerp(
          Colors.white,
          _position.value > 0 ? Colors.green : Colors.red,
          swipeRatio,
        )!;
    double progress = (_index + 1) / quizList.length;
    return Scaffold(
      backgroundColor: _isFront || !_isDrag ? Colors.blue : backgroundColor,
      appBar: AppBar(title: const Text('Flashcards App')),
      body: Column(
        children: [
          SizedBox(height: 80),
          Text(
            !_isFront && _isDrag
                ? _position.value > 0
                    ? "맞춤"
                    : "틀림"
                : "",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _isFront ? _controller : _position,
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
                        child: Card(
                          index:
                              (_index + 1) == quizList.length ? 0 : _index + 1,
                          front: true,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: GestureDetector(
                        onTap: _isFront ? _tapCard : null,
                        onHorizontalDragUpdate:
                            _isFront ? null : _onHorizontalDragUpdate,
                        onHorizontalDragEnd:
                            _isFront ? null : _onHorizontalDragEnd,
                        child:
                            _isFront
                                ? Transform(
                                  alignment: FractionalOffset.center,
                                  transform:
                                      Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_turn.value),
                                  child: Card(index: _index, front: _isFront),
                                )
                                : Transform.translate(
                                  offset: Offset(_position.value, 0),
                                  child: Transform.rotate(
                                    angle: angle,
                                    child: Card(index: _index, front: _isFront),
                                  ),
                                ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 500),
            tween: Tween<double>(begin: progress, end: progress),
            builder: (context, double value, child) {
              return CustomPaint(
                painter: ProgressPainter(progress: value),
                size: Size(size.width * 0.8, 50),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;
  final bool front;

  const Card({super.key, required this.index, required this.front});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: Container(
        color: Colors.grey[100],
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Center(
          child: Text(
            front ? quizList[index]["question"]! : quizList[index]["answer"]!,
            style: TextStyle(fontSize: 24),
          ),
        ),
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
    final progressEnd = Offset(size.width * progress, size.height - 50);

    final backgroundPaint =
        Paint()
          ..color = Colors.black.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 15;
    canvas.drawLine(start, end, backgroundPaint);

    final progressPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 15;

    canvas.drawLine(start, progressEnd, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
