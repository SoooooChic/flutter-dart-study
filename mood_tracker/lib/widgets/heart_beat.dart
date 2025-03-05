import 'package:flutter/material.dart';

class HeartBeat extends StatefulWidget {
  final double size;
  const HeartBeat({super.key, this.size = 100.0});

  @override
  State<HeartBeat> createState() => _HeartBeatState();
}

class _HeartBeatState extends State<HeartBeat>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  final Tween<double> _scaleTween = Tween(begin: 1.0, end: 1.5);
  final ColorTween _colorTween = ColorTween(
    begin: Colors.red,
    end: Colors.pink,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _scaleAnimation = _scaleTween.animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = _colorTween.animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Icon(Icons.favorite, size: widget.size),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Icon(
            Icons.favorite,
            size: widget.size,
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
