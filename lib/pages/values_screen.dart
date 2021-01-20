import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:net_guru_blocs/bloc/favorites/favorites_bloc.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/components/fade_animation.dart';

class ValuesScreen extends StatefulWidget {
  ValuesScreen({@required this.bloc});
  final ValuesBloc bloc;

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
            cubit: widget.bloc,
            builder: (BuildContext context, ValuesState state) {
              if (state is ValuesStateLoading) {
                return Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(child: CircularProgressIndicator()));
              }
              if (state is ValuesUpdateSuccess) {
                print('INDEX: ${state.index}');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      child: FadeAnimation(
                        valueText: state.valuesList[state.index],
                        bloc: widget.bloc,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 30,
                          color: state.favoritesList
                                  .contains(state.valuesList[state.index])
                              ? Colors.red
                              : Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .color,
                        ),
                        onPressed: () {
                          BlocProvider.of<FavoritesBloc>(context).add(
                              NewFavoriteValue(
                                  newFavorite: state.valuesList[state.index],
                                  index: state.index));
                          widget.bloc.add(LikedValue(index: state.index));
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Values goes here'),
                );
              }
            }),
      ),
    );
  }
}
