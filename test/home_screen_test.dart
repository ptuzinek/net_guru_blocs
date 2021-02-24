// should render properly according to currently active tab
// check if proper screen widget is rendered after tab tap

import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:net_guru_blocs/bloc/favorites/favorites_bloc.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/data/models/app_tab.dart';
import 'package:net_guru_blocs/presentation/pages/add_screen.dart';
import 'package:net_guru_blocs/presentation/pages/favorites_screen.dart';
import 'package:net_guru_blocs/presentation/pages/home_screen.dart';
import 'package:net_guru_blocs/presentation/pages/values_screen.dart';
import 'package:net_guru_blocs/bloc/tab/tab_bloc.dart';

class MockTabBloc extends Mock implements TabBloc {}

class MockValuesBloc extends Mock implements ValuesBloc {}

class MockFavoritesBloc extends Mock implements FavoritesBloc {}

void main() {
  TabBloc mockTabBloc;
  ValuesBloc mockValuesBloc;
  FavoritesBloc mockFavoritesBloc;
  StreamController<TabState> blocController;

  setUp(() {
    blocController = StreamController<TabState>();
    mockTabBloc = MockTabBloc();
    mockValuesBloc = MockValuesBloc();
    mockFavoritesBloc = MockFavoritesBloc();
  });

  tearDown(() {
    mockTabBloc.close();
    mockValuesBloc.close();
    mockFavoritesBloc.close();
    blocController.close();
  });

  Future<void> pumpHomePage(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<TabBloc>(
            create: (context) => mockTabBloc,
          ),
          BlocProvider<ValuesBloc>(
            create: (context) => mockValuesBloc,
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => mockFavoritesBloc,
          ),
        ],
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );
    await tester.pump();
  }

  void stubBlocStateChangedYields(Iterable<TabState> newState) {
    blocController.addStream(Stream<TabState>.fromIterable(newState));
    whenListen(mockTabBloc, blocController.stream);
  }

  testWidgets('Initially expect ValuesScreen', (WidgetTester tester) async {
    await pumpHomePage(tester);

    final valuesScreen = find.byType(ValuesScreen);
    expect(valuesScreen, findsOneWidget);
  });

  testWidgets('Renders AddScreen when new state comes',
      (WidgetTester tester) async {
    stubBlocStateChangedYields(
        [NewTabSelectionState(selectedTab: AppTab.addValue)]);

    await pumpHomePage(tester);
    await tester.pumpAndSettle();

    final addScreen = find.byType(AddScreen);
    expect(addScreen, findsOneWidget);
    expect(find.byType(ValuesScreen), findsNothing);
  });

  testWidgets('Renders FavoritesScreen when new state comes',
      (WidgetTester tester) async {
    stubBlocStateChangedYields(
        [NewTabSelectionState(selectedTab: AppTab.favoritesList)]);

    await pumpHomePage(tester);
    await tester.pumpAndSettle();

    final favoritesScreen = find.byType(FavoritesScreen);
    expect(favoritesScreen, findsOneWidget);
    expect(find.byType(ValuesScreen), findsNothing);
  });

  testWidgets('Renders FavoritesScreen when new state comes',
      (WidgetTester tester) async {
    stubBlocStateChangedYields(
        [NewTabSelectionState(selectedTab: AppTab.favoritesList)]);

    await pumpHomePage(tester);
    await tester.pumpAndSettle();

    final favoritesScreen = find.byType(FavoritesScreen);
    expect(favoritesScreen, findsOneWidget);
    expect(find.byType(ValuesScreen), findsNothing);
  });
}
