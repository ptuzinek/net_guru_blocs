import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:net_guru_blocs/presentation/animations/fade_animation.dart';
import 'package:net_guru_blocs/presentation/pages/values_screen.dart';

class MockValuesBloc extends Mock implements ValuesBloc {}

void main() {
  ValuesBloc mockValuesBloc;
  StreamController<ValuesState> blocController;

  setUp(() {
    blocController = StreamController<ValuesState>();
    mockValuesBloc = MockValuesBloc();
  });

  tearDown(() {
    mockValuesBloc.close();
    blocController.close();
  });

  Future<void> pumpValuesScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<ValuesBloc>(
        create: (context) => mockValuesBloc,
        child: MaterialApp(
          home: ValuesScreen(),
        ),
      ),
    );
    await tester.pump();
  }

  void stubBlocStateChangedYields(Iterable<ValuesState> newState) {
    blocController.addStream(Stream<ValuesState>.fromIterable(newState));
    whenListen(mockValuesBloc, blocController.stream);
  }

  testWidgets('bloc waiting', (WidgetTester tester) async {
    stubBlocStateChangedYields([ValuesStateLoading()]);

    await pumpValuesScreen(tester);

    final circularProgressIndicator = find.byType(CircularProgressIndicator);
    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets(
      'Value updated successfully and adds LikedValue event when IconButton taped',
      (WidgetTester tester) async {
    final ValueBase valueBase = ValueBase(
        id: 7,
        valueText: '7 Recognize excellence and engagement',
        isFavorite: false,
        timestamp: DateTime.now());

    stubBlocStateChangedYields([ValuesUpdateSuccess(newValue: valueBase)]);

    await pumpValuesScreen(tester);

    final fadeAnimation = find.byType(FadeAnimation);
    expectLater(fadeAnimation, findsOneWidget);

    final iconButton = find.byKey(Key('IconButton'));
    expectLater(iconButton, findsOneWidget);

    await tester.tap(iconButton);

    verify(mockValuesBloc.add(
      LikedValue(likedValue: valueBase),
    )).called(1);
  });

  testWidgets('Failed to update value', (WidgetTester tester) async {
    stubBlocStateChangedYields([ValuesLoadFailure()]);

    await pumpValuesScreen(tester);

    final textInfo = find.text('Something went wrong.');
    expectLater(textInfo, findsOneWidget);
  });
}
