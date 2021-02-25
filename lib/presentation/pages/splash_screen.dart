import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> _netguruWordList = [];
  AnimationController _controller;
  Animation<Offset> offsetText;
  Animation<Offset> offsetImage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addWords();
      _goToHomePageDelayed();
    });

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    offsetText = Tween<Offset>(begin: Offset.zero, end: Offset(0.6, 0.0))
        .animate(_controller);
    offsetImage = Tween<Offset>(begin: Offset.zero, end: Offset(-0.5, 0.0))
        .animate(_controller);

    _controller.forward();
  }

  void _addWords() {
    List<String> _trips = ['n', 'e', 't', 'g', 'u', 'r', 'u'];
    Future ft = Future(() {});
    _trips.forEach((String word) {
      ft = ft.then((data) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          _netguruWordList.add(word);
          _listKey.currentState.insertItem(_netguruWordList.length - 1);
        });
      });
    });
  }

  Future<bool> _goToHomePageDelayed() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 2500),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return HomePage();
            }),
      );
    });
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Tween<double> opacity = Tween(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333A30),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 200.0,
              width: 400.0,
              child: Center(
                child: SlideTransition(
                  position: offsetText,
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: _netguruWordList.length,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index, animation) {
                      return Center(
                        child: FadeTransition(
                          opacity: animation.drive(opacity),
                          child: Text(
                            _netguruWordList[index],
                            style: TextStyle(fontSize: 30, color: Colors.green),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              child: SlideTransition(
                position: offsetImage,
                child: Hero(
                    tag: 'netguru',
                    child: Image.asset('images/netguru_icon.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
