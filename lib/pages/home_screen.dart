import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_guru_blocs/bloc/favorites/favorites_bloc.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/pages/values_screen.dart';
import 'add_screen.dart';
import 'favorites_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValuesBloc valuesBloc;
  FavoritesBloc favoritesBloc;

  @override
  void initState() {
    valuesBloc = BlocProvider.of<ValuesBloc>(context);
    favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    valuesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('HOME PAGE BUILD');
    return PageView(
      children: [
        ValuesScreen(
          bloc: valuesBloc,
        ),
        AddScreen(
          bloc: valuesBloc,
        ),
        FavoritesScreen(
          bloc: favoritesBloc,
        ),
      ],
    );
  }
}
