import 'package:flutter/material.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'dart:math';

// Animated Widget code
class FadeAnimation extends StatefulWidget {
  FadeAnimation({
    this.bloc,
    this.valuesList,
    this.valueText,
  });

  final ValuesBloc bloc;
  final List valuesList;
  final String valueText;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  int index;
  Random rnd = Random();

  int getNextIndex() {
    int nextIndex = rnd.nextInt(widget.valuesList.length);
    while (nextIndex == index) {
      nextIndex = rnd.nextInt(widget.valuesList.length);
    }
    return nextIndex;
  }

  @override
  void initState() {
    super.initState();
    //index = rnd.nextInt(widget.valuesList.length);
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
        widget.bloc.add(AnimationEnded());

        //
        // setState(() {
        //   index = getNextIndex();
        // });

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
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
    );
  }
}
