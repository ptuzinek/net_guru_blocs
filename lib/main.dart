import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_guru_blocs/bloc/tab/tab_bloc.dart';
import 'package:net_guru_blocs/pages/home_screen.dart';
import 'package:net_guru_blocs/values_repository.dart';
import 'bloc/favorites/favorites_bloc.dart';
import 'bloc/values/values_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final ValuesRepository repository = ValuesRepository(preferences: prefs);
  runApp(MyApp(
    repository: repository,
  ));
}

class MyApp extends StatefulWidget {
  final ValuesRepository repository;

  const MyApp({Key key, this.repository}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ValuesBloc>(
          create: (context) => ValuesBloc(repository: widget.repository),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(repository: widget.repository),
        ),
        BlocProvider<TabBloc>(
          create: (context) => TabBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[400],
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.green[700],
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
