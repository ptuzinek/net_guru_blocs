import 'package:flutter/material.dart';

// Animated Widget code
class FadeAnimation extends StatefulWidget {
  FadeAnimation({
    this.valueText,
    this.onAnimationEnd,
  });

  final String valueText;
  final VoidCallback onAnimationEnd;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2, milliseconds: 500),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
        new CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        // change the index (fading animation ended)
        widget.onAnimationEnd?.call();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            widget.valueText,
            style: TextStyle(
              fontFamily: 'Vollkorn',
              fontSize: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
