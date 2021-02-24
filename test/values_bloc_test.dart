import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:net_guru_blocs/data/repositories/values_repository.dart';

class MockValuesRepository extends Mock implements ValuesRepository {}

void main() {
  MockValuesRepository mockValuesRepository;
  ValuesBloc valuesBloc;

  setUp(() {
    mockValuesRepository = MockValuesRepository();
    valuesBloc = ValuesBloc(repository: mockValuesRepository);
  });

  tearDown(() {
    valuesBloc.close();
  });

  group('ValuesBloc', () {
    test('the initial state for the ValuesBloc is ValuesStateLoading', () {
      expect(valuesBloc.state, ValuesStateLoading());
    });

    test('after closing ValuesBloc does not emit any states', () {
      expectLater(valuesBloc, emits(emitsDone));

      valuesBloc.close();
    });

    test(
        'WHEN app starts'
        'THEN ValueBloc emits ValuesUpdateSuccess state with new ValueBase object',
        () {
      final ValueBase valueBase = ValueBase(
          id: 7,
          valueText: '7 Recognize excellence and engagement',
          isFavorite: false,
          timestamp: DateTime.now());

      when(mockValuesRepository.getAllValues())
          .thenAnswer((_) => Future.value(List<ValueBase>()));

      when(mockValuesRepository.getRandomValue(previousId: 0))
          .thenAnswer((_) => Future.value(valueBase));

      expectLater(
          valuesBloc,
          emitsInOrder([
            ValuesUpdateSuccess(newValue: valueBase),
          ]));

      valuesBloc.add(AppStarted());
    });

    test(
        'WHEN app started'
        'AND animation ends'
        'THEN ValueBloc emits ValuesUpdateSuccess state with new ValueBase object',
        () {
      final ValueBase valueBase = ValueBase(
          id: 7,
          valueText: '7 Recognize excellence and engagement',
          isFavorite: false,
          timestamp: DateTime.now());

      final ValueBase nextValueBase = ValueBase(
          id: 5,
          valueText:
              '5 Build an inclusive, transparent and socially responsible culture',
          isFavorite: false,
          timestamp: DateTime.now());

      when(mockValuesRepository.getAllValues())
          .thenAnswer((_) => Future.value(List<ValueBase>()));

      when(mockValuesRepository.getRandomValue(previousId: 0))
          .thenAnswer((_) => Future.value(valueBase));

      when(mockValuesRepository.getRandomValue(previousId: 7))
          .thenAnswer((_) => Future.value(nextValueBase));

      expectLater(
          valuesBloc,
          emitsInOrder([
            ValuesUpdateSuccess(newValue: valueBase),
            ValuesUpdateSuccess(newValue: nextValueBase),
          ]));

      valuesBloc.add(AppStarted());
      valuesBloc.add(AnimationEnded());
    });

    test(
        'WHEN new ValueBase object is added '
        'THEN ValuesBloc emits ValuesUpdateSuccess state with addedValue', () {
      final timestamp = DateTime.now();
      final ValueBase valueBaseToAdd = ValueBase(
          id: 8,
          valueText: 'New Value',
          isFavorite: false,
          timestamp: timestamp);

      when(mockValuesRepository.getValueWithTimestamp(valueBaseToAdd))
          .thenReturn(valueBaseToAdd.copyWith(timestamp: timestamp));

      when(mockValuesRepository.insertValue(valueBaseToAdd))
          .thenAnswer((_) => Future.value(valueBaseToAdd.id));

      expectLater(
          valuesBloc,
          emitsInOrder([
            ValueAddSuccess(addedValue: valueBaseToAdd),
            ValuesUpdateSuccess(newValue: valueBaseToAdd),
          ]));

      valuesBloc.add(AddedNewValue(newValue: valueBaseToAdd));
    });
    test(
        'WHEN app starts'
        'AND user click like Button'
        'THEN ValueBloc emits ValuesUpdateSuccess state with liked ValueBase object',
        () {
      final ValueBase valueBase = ValueBase(
          id: 7,
          valueText: '7 Recognize excellence and engagement',
          isFavorite: false,
          timestamp: DateTime.now());

      when(mockValuesRepository.getAllValues())
          .thenAnswer((_) => Future.value(List<ValueBase>()));

      when(mockValuesRepository.getRandomValue(previousId: 0))
          .thenAnswer((_) => Future.value(valueBase));

      expectLater(
          valuesBloc,
          emitsInOrder([
            ValuesUpdateSuccess(newValue: valueBase),
          ]));

      valuesBloc.add(AppStarted());
    });

    test(
        'WHEN user likes a value'
        'THEN ValuesBloc emits ValuesUpdateSuccess state with liked value', () {
      final ValueBase likedValue = ValueBase(
          id: 7,
          valueText: '7 Recognize excellence and engagement',
          isFavorite: false,
          timestamp: DateTime.now());

      final DateTime newTimestamp = DateTime.now();

      when(mockValuesRepository.getLikedValue(likedValue)).thenAnswer((_) =>
          Future.value(
              likedValue.copyWith(isFavorite: true, timestamp: newTimestamp)));

      expectLater(
          valuesBloc,
          emitsInOrder([
            ValuesUpdateSuccess(
                newValue: likedValue.copyWith(
                    isFavorite: true, timestamp: newTimestamp)),
          ]));

      valuesBloc.add(LikedValue(likedValue: likedValue));
    });
  });
}
