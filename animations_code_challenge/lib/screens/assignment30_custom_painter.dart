import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Assignment30CustomPainter extends StatefulWidget {
  const Assignment30CustomPainter({super.key});

  @override
  State<Assignment30CustomPainter> createState() =>
      _Assignment30CustomPainterState();
}

class _Assignment30CustomPainterState extends State<Assignment30CustomPainter> {
  double _progress = 2.0;
  double _oldProgress = 2.0;
  static const _minutes = 60 * 1;
  int totalSeconds = _minutes;
  bool isRunning = false;
  Timer? timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isRunning = false;
        totalSeconds = _minutes;
        _progress = 2.0;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
        _oldProgress = _progress;
        _progress = totalSeconds / _minutes * 2.0;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    setState(() {
      totalSeconds = _minutes;
      _progress = 2.0;
      _oldProgress = 2.0;
      isRunning = false;
    });
    timer?.cancel();
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Painter')),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  format(totalSeconds),
                  style: const TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween<double>(begin: _oldProgress, end: _progress),
                  builder: (context, double value, child) {
                    return CustomPaint(
                      painter: ProgressPainter(progress: value),
                      size: const Size(300, 300),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  color: Colors.grey.shade400,
                  iconSize: 60,
                  onPressed: onResetPressed,
                  icon: const Icon(Icons.replay_circle_filled),
                ),
                IconButton(
                  color: Colors.red.shade400,
                  iconSize: 120,
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(
                    isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                  ),
                ),
                IconButton(
                  color: Colors.grey.shade400,
                  iconSize: 60,
                  onPressed: () {},
                  icon: const Icon(Icons.stop_circle),
                ),
              ],
            ),
            const Spacer(),
          ],
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
    final center = Offset(size.width / 2, size.height / 2);
    const startingAngle = -0.5 * pi;

    final backgroundPaint =
        Paint()
          ..color = Colors.grey.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25;

    final radius = (size.width / 2) * 0.9;
    canvas.drawCircle(center, radius, backgroundPaint);

    final arcPaint =
        Paint()
          ..color = Colors.red.shade400
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 25;

    final arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(arcRect, startingAngle, progress * pi, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
