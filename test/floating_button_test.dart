import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_guru_blocs/data/models/app_tab.dart';
import 'package:net_guru_blocs/presentation/widgets/floating_button.dart';

void main() {
  testWidgets('description', (WidgetTester tester) async {
    bool isClicked = false;
    await tester.pumpWidget(MaterialApp(
        home: FloatingButton(
      onPressed: () => isClicked = true,
      activeTab: AppTab.addValue,
    )));

    final floatingButton = find.byType(FloatingActionButton);
    expect(floatingButton, findsOneWidget);
    await tester.tap(floatingButton);
    expect(isClicked, true);
  });
}
