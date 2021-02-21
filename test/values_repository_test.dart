import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:net_guru_blocs/data/data_providers/values_api.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:net_guru_blocs/data/repositories/values_repository.dart';

class MockValuesDataApi extends Mock implements ValuesDataApi {}

void main() {
  ValuesRepository valuesRepository;
  MockValuesDataApi mockValuesDataApi;

  setUp(() {
    mockValuesDataApi = MockValuesDataApi();

    valuesRepository = ValuesRepository(valuesDataApi: mockValuesDataApi);
  });
  group('getFavoritesList', () {
    test(
        'CASE 1: '
        'WHEN getFavorites method is called'
        'THEN it returns a list of String that is sorted based on the timestamp property',
        () async {
      final valuesList = [
        ValueBase(
            valueText: 'First value',
            isFavorite: true,
            timestamp: DateTime.now()),
        ValueBase(
            valueText: 'Second value',
            isFavorite: true,
            timestamp: DateTime.now()),
        ValueBase(
            valueText: 'Third value',
            isFavorite: true,
            timestamp: DateTime.now()),
        ValueBase(
            valueText: 'Fourth value',
            isFavorite: false,
            timestamp: DateTime.now()),
      ];
      final favoritesList = ['First value', 'Second value', 'Third value'];

      when(mockValuesDataApi.getAllValues())
          .thenAnswer((_) => Future.value(valuesList));

      expectLater(await valuesRepository.getFavoritesList(), favoritesList);
    });

    test(
        'CASE 2:'
        'WHEN getFavorites method is called'
        'THEN it returns a list of String that is sorted based on the timestamp property',
        () async {
      final valuesList = [
        ValueBase(
            valueText: 'First value',
            isFavorite: true,
            timestamp: DateTime.fromMillisecondsSinceEpoch(15)),
        ValueBase(
            valueText: 'Second value',
            isFavorite: true,
            timestamp: DateTime.fromMillisecondsSinceEpoch(11)),
        ValueBase(
            valueText: 'Third value',
            isFavorite: true,
            timestamp: DateTime.fromMillisecondsSinceEpoch(10)),
        ValueBase(
            valueText: 'Fourth value',
            isFavorite: false,
            timestamp: DateTime.fromMillisecondsSinceEpoch(13)),
      ];

      final favoritesList = ['Third value', 'Second value', 'First value'];

      when(mockValuesDataApi.getAllValues())
          .thenAnswer((_) => Future.value(valuesList));

      expectLater(await valuesRepository.getFavoritesList(), favoritesList);
    });
  });

  group('getRandomValue', () {
    setUp(() {
      final valuesList = [
        ValueBase(
            id: 1,
            valueText: 'First value',
            isFavorite: true,
            timestamp: DateTime.now()),
        ValueBase(
            id: 2,
            valueText: 'Second value',
            isFavorite: true,
            timestamp: DateTime.now()),
        ValueBase(
            id: 3,
            valueText: 'Third value',
            isFavorite: true,
            timestamp: DateTime.now()),
        ValueBase(
            id: 4,
            valueText: 'Fourth value',
            isFavorite: false,
            timestamp: DateTime.now()),
      ];

      when(mockValuesDataApi.getAllValues())
          .thenAnswer((_) => Future.value(valuesList));
    });

    test(
        'WHEN int value of 1 is passed to the getRandomValue method'
        'THEN it returns int value that is other than 1', () async {
      ValueBase randomValue =
          await valuesRepository.getRandomValue(previousId: 1);
      expectLater(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
      randomValue = await valuesRepository.getRandomValue(previousId: 1);
      expect(randomValue.id, isNot(1));
    });

    test(
        'WHEN int value of 3 is passed to the getRandomValue method'
        'THEN it returns int value that is other than 3', () async {
      ValueBase randomValue =
          await valuesRepository.getRandomValue(previousId: 3);
      expectLater(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
      randomValue = await valuesRepository.getRandomValue(previousId: 3);
      expect(randomValue.id, isNot(3));
    });
  });
}
