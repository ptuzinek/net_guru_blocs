import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('flutter netguru app test', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) {
        driver.close();
      }
    });

    final iconButton = find.byType('IconButton');
    final floatingButton = find.byType('FloatingButton');
    final textField = find.byType('AddValueTextField');
    final addButton = find.byType('FlatButton');
    final valuesScreenButton = find.byValueKey('values_screen');
    final valueTextFinder = find.byValueKey('valueText');
    final snackBarTextFinder = find.byValueKey('SnackBarText');
    final favoritesScreenButton = find.byValueKey('favorites_screen');
    final listView = find.byType('ListView');
    final favoritesInfoText = find.byValueKey('favorites_info_text');

    test(
        'After taping AddTab go to AddScreen, add new value, show SnackBar, go back to ValuesScreen'
        'which contains new value, go to FavoritesPage that contains infoText, go back to ValuesScreen'
        'tap iconButton, go to FavoritesScreen which now contains new liked value',
        () async {
      // have to runUnsynchronized to not wait until infinite animation ends
      await driver.runUnsynchronized(() async {
        await Future.delayed(Duration(seconds: 1));

        await driver.waitFor(iconButton);
        await Future.delayed(Duration(seconds: 1));
        await driver.tap(floatingButton);
        await Future.delayed(Duration(seconds: 1));

        await driver.waitFor(textField);
        await Future.delayed(Duration(seconds: 1));

        await driver.tap(textField);
        await Future.delayed(Duration(seconds: 1));

        await driver.enterText('New value');
        await Future.delayed(Duration(seconds: 1));

        await driver.tap(addButton);
        await Future.delayed(Duration(seconds: 1));

        await driver.waitFor(find.text('Added new Value'));
        expect(await driver.getText(snackBarTextFinder), 'Added new Value');

        await driver.tap(valuesScreenButton);
        await Future.delayed(Duration(seconds: 1));

        await driver.waitFor(iconButton);
        await Future.delayed(Duration(seconds: 1));

        expect(await driver.getText(valueTextFinder), 'New value');

        await driver.tap(favoritesScreenButton);

        await driver.waitFor(favoritesInfoText);
        await Future.delayed(Duration(seconds: 1));

        await driver.tap(valuesScreenButton);
        await Future.delayed(Duration(seconds: 1));

        await driver.waitFor(iconButton);
        await Future.delayed(Duration(seconds: 1));

        await driver.tap(iconButton);
        await Future.delayed(Duration(seconds: 1));

        await driver.tap(favoritesScreenButton);
        await Future.delayed(Duration(seconds: 1));

        await driver.waitFor(listView);
        await Future.delayed(Duration(seconds: 1));
      });
    });
  });
}
