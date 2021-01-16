import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ValuesBloc _valuesBloc = ValuesBloc(repository: repository);
    final FavoritesBloc _favoritesBloc = FavoritesBloc(valuesBloc: _valuesBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ValuesBloc>(
          create: (context) => ValuesBloc(repository: repository),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) =>
              FavoritesBloc(valuesBloc: BlocProvider.of<ValuesBloc>(context)),
        )
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
