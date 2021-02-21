import 'package:flutter_test/flutter_test.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      final valueBase = ValueBase.fromMap(null);
      expect(valueBase, null);
    });

    test('Creates ValueBase object with all properties', () {
      final DateTime timestamp = DateTime.now();
      final ValueBase valueBase = ValueBase.fromMap({
        '_id': 1,
        'value_text': 'Example value text',
        'is_favorite': false,
        'timestamp': timestamp.toString(),
      });
      expect(
          valueBase,
          ValueBase(
              id: 1,
              valueText: 'Example value text',
              isFavorite: false,
              timestamp: timestamp));
    });
  });

  group('toMap', () {
    test('Creates a map from ValueBase properties', () {
      final timestamp = DateTime.now();
      final valueBase = ValueBase(
          id: 1, valueText: 'text', isFavorite: false, timestamp: timestamp);
      expect(valueBase.toMap(), {
        '_id': 1,
        'value_text': 'text',
        'is_favorite': 0,
        'timestamp': timestamp.toString(),
      });
    });
  });

  group('copyWith', () {
    test('Creates a ValueBase object with updated properties', () {
      final DateTime timestamp = DateTime.now();
      final DateTime nextTimestamp = DateTime.now();

      final valueBase = ValueBase(
          id: 1, valueText: 'text', isFavorite: false, timestamp: timestamp);
      expect(
          valueBase.copyWith(isFavorite: true, timestamp: nextTimestamp),
          ValueBase(
              id: 1,
              valueText: 'text',
              isFavorite: true,
              timestamp: nextTimestamp));
    });
  });
}
