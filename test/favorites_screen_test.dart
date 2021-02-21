// should send event at build
// should render properly with a ListView of favorite values
import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:net_guru_blocs/presentation/pages/favorites_screen.dart';
import 'package:net_guru_blocs/presentation/pages/values_screen.dart';
import 'package:net_guru_blocs/bloc/favorites/favorites_bloc.dart';

class MockFavoritesBloc extends Mock implements FavoritesBloc {}

void main() {
  FavoritesBloc mockFavoritesBloc;
  StreamController<FavoritesState> blocController;

  setUp(() {
    blocController = StreamController<FavoritesState>();
    mockFavoritesBloc = MockFavoritesBloc();
  });

  tearDown(() {
    mockFavoritesBloc.close();
    blocController.close();
  });

  Future<void> pumpFavoritesScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<FavoritesBloc>(
        create: (context) => mockFavoritesBloc,
        child: MaterialApp(
          home: FavoritesScreen(),
        ),
      ),
    );
    await tester.pump();
  }

  void stubBlocStateChangedYields(Iterable<FavoritesState> newState) {
    blocController.addStream(Stream<FavoritesState>.fromIterable(newState));
    whenListen(mockFavoritesBloc, blocController.stream);
  }

  testWidgets('bloc waiting', (WidgetTester tester) async {
    stubBlocStateChangedYields([NewFavoritesEmpty()]);

    await pumpFavoritesScreen(tester);

    final textInfo = find.text('Your Favorite values will show up here!');
    expect(textInfo, findsOneWidget);
  });

  testWidgets(
      'Value updated successfully and adds LikedValue event when IconButton taped',
      (WidgetTester tester) async {
    stubBlocStateChangedYields([
      NewFavoritesUpdateSuccess(
          favoritesList: ['Value 1', 'Value 2', 'Value 3'])
    ]);

    await pumpFavoritesScreen(tester);

    final listView = find.byType(ListView);
    expectLater(listView, findsOneWidget);

    verify(mockFavoritesBloc.add(
      FavoritesListRequested(),
    )).called(1);
  });
}
