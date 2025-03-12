import 'package:flutter/material.dart';

class Assignment29ExplicitAnimations extends StatelessWidget {
  const Assignment29ExplicitAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Explicit Animations')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (rowIndex) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (colIndex) {
                    int index = rowIndex.isEven ? colIndex : (4 - colIndex);
                    double delay = (rowIndex * 5 + index) * 50;
                    return ExplicitBox(delay: delay.toInt());
                  }),
                ),
                if (rowIndex < 4) const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExplicitBox extends StatefulWidget {
  final int delay;

  const ExplicitBox({super.key, required this.delay});

  @override
  State<ExplicitBox> createState() => _ExplicitBoxState();
}

class _ExplicitBoxState extends State<ExplicitBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  late final Animation<BorderRadius?> _decoration = BorderRadiusTween(
    begin: BorderRadius.circular(10),
    end: BorderRadius.zero,
  ).animate(_curve);

  late final Animation<Color?> _color = ColorTween(
    begin: Colors.pink,
    end: Colors.red,
  ).animate(_curveOpacity);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 0.8,
  ).animate(_curveScale);

  late final Animation<double> _opacity = Tween<double>(
    begin: 1.0,
    end: 0.0,
  ).animate(_curveOpacity);

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOutBack,
  );

  late final CurvedAnimation _curveScale = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOut,
  );

  late final CurvedAnimation _curveOpacity = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOutCirc,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _animationController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _color.value,
                borderRadius: _decoration.value,
              ),
            ),
            // child: DecoratedBoxTransition(
            //   decoration: _decoration,
            //   child: const SizedBox(height: 50, width: 50),
            // ),
          ),
        );
      },
    );
  }
}
