import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_guru_blocs/bloc/tab/tab_bloc.dart';
import 'package:net_guru_blocs/data/repositories/values_repository.dart';
import 'package:net_guru_blocs/presentation/pages/splash_screen.dart';
import 'bloc/favorites/favorites_bloc.dart';
import 'bloc/values/values_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ValuesRepository newRepository = ValuesRepository();

  runApp(MyApp(
    newRepository: newRepository,
  ));
}

// ToDo - turn to a StatelessWidget ???
class MyApp extends StatefulWidget {
  final ValuesRepository newRepository;

  const MyApp({Key key, this.newRepository}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ValuesBloc>(
          create: (context) => ValuesBloc(repository: widget.newRepository),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(repository: widget.newRepository),
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
        home: SplashScreen(),
      ),
    );
  }
}
