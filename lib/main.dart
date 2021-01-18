import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_guru_blocs/bloc/tab/tab_bloc.dart';
import 'package:net_guru_blocs/pages/home_screen.dart';
import 'package:net_guru_blocs/values_repository.dart';
import 'bloc/favorites/favorites_bloc.dart';
import 'bloc/values/values_bloc.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValuesRepository repository = ValuesRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ValuesBloc>(
          create: (context) => ValuesBloc(repository: repository),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(repository: repository),
        ),
        BlocProvider<TabBloc>(
          create: (context) => TabBloc(),
        )
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
