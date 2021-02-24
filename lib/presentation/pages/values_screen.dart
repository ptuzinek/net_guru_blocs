import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/presentation/animations/fade_animation.dart';

class ValuesScreen extends StatefulWidget {
  @override
  _ValuesScreenState createState() => _ValuesScreenState();
}

class _ValuesScreenState extends State<ValuesScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        body: BlocBuilder<ValuesBloc, ValuesState>(
            cubit: BlocProvider.of<ValuesBloc>(context),
            builder: (BuildContext context, ValuesState state) {
              if (state is ValuesStateLoading) {
                return Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(child: CircularProgressIndicator()));
              }
              if (state is ValuesUpdateSuccess) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          child: FadeAnimation(
                            valueText: state.newValue.valueText,
                            onAnimationEnd: () {
                              BlocProvider.of<ValuesBloc>(context)
                                  .add(AnimationEnded());
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: IconButton(
                            key: Key('IconButton'),
                            icon: Icon(
                              Icons.favorite,
                              size: 30,
                              color: state.newValue.isFavorite
                                  ? Colors.red
                                  : Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .color,
                            ),
                            onPressed: () {
                              BlocProvider.of<ValuesBloc>(context)
                                  .add(LikedValue(likedValue: state.newValue));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text('Something went wrong.'),
                );
              }
            }),
      ),
    );
  }
}
