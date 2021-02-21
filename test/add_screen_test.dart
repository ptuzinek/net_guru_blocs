// should render properly
// should send event with user-provided ValueBase object when AddButton is taped
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:net_guru_blocs/presentation/pages/add_screen.dart';
import 'package:net_guru_blocs/presentation/widgets/add_value_text_field.dart';

class MockValuesBloc extends Mock implements ValuesBloc {}

void main() {
  ValuesBloc mockValuesBloc;

  setUp(() {
    mockValuesBloc = MockValuesBloc();
  });

  tearDown(() {
    mockValuesBloc.close();
  });

  Future<void> pumpValuesScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<ValuesBloc>(
        create: (context) => mockValuesBloc,
        child: MaterialApp(
          home: AddScreen(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('renders properly and sends event then button tapped',
      (WidgetTester tester) async {
    final ValueBase valueBase =
        ValueBase(valueText: 'New value', isFavorite: false);

    await pumpValuesScreen(tester);

    final addValueTextField = find.byType(AddValueTextField);
    expectLater(addValueTextField, findsOneWidget);

    await tester.tap(addValueTextField);
    await tester.enterText(addValueTextField, 'New value');

    await tester.pump();

    final flatButton = find.byType(FlatButton);
    expectLater(flatButton, findsOneWidget);

    await tester.tap(flatButton);
    await tester.pumpAndSettle();

    verify(mockValuesBloc.add(
      AddedNewValue(newValue: valueBase),
    )).called(1);
  });
}
