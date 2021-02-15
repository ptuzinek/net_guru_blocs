import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:net_guru_blocs/data/repositories/values_repository.dart';

class MockValuesRepository extends Mock implements ValuesRepository {}

class MockValueBase extends Mock implements ValueBase {}

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

    test('AppStarted Event and AnimationEnded Event', () async {
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

      when(mockValuesRepository.insertValue(valueBase))
          .thenAnswer((_) => Future.value(nextValueBase));

      expectLater(
          valuesBloc,
          emitsInOrder([
            ValuesUpdateSuccess(newValue: valueBase),
            ValuesUpdateSuccess(newValue: nextValueBase),
            ValuesUpdateSuccess(
                newValue: nextValueBase), // -> this is never emitted
          ]));

      valuesBloc.add(AppStarted());
      valuesBloc.add(AnimationEnded());
      valuesBloc.add(AddedNewValue());
    });
  });
}
