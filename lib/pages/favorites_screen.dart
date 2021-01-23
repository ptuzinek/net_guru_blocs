import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:net_guru_blocs/bloc/favorites/favorites_bloc.dart';
import 'package:net_guru_blocs/components/text_bubble.dart';

// Stateful - it will have only a ListView
//git config --global user.email

class FavoritesScreen extends StatefulWidget {
  final FavoritesBloc bloc;

  FavoritesScreen({this.bloc});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        cubit: widget.bloc,
        builder: (BuildContext context, FavoritesState state) {
          if (state is FavoritesUpdateSuccess) {
            List<Widget> favoriteWidgetsList = [];
            for (String favorite in state.favoritesList.reversed) {
              final favoriteWidget = FavoriteBubble(
                text: favorite,
              );
              favoriteWidgetsList.add(favoriteWidget);
            }
            return Scaffold(
              body: Container(
                child: Center(
                  child: ListView(
                    children: favoriteWidgetsList,
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('Your Favorite values will show up here!'),
            );
          }
        },
      ),
    );
  }
}
