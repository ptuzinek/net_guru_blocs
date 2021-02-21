import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_guru_blocs/bloc/favorites/favorites_bloc.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:net_guru_blocs/data/repositories/values_repository.dart';

class MockValuesRepository extends Mock implements ValuesRepository {}

void main() {
  MockValuesRepository mockValuesRepository;
  FavoritesBloc favoritesBloc;

  setUp(() {
    mockValuesRepository = MockValuesRepository();
    favoritesBloc = FavoritesBloc(repository: mockValuesRepository);
  });

  tearDown(() {
    favoritesBloc.close();
  });

  group('FavoritesBloc', () {
    test('the initial state for the FavoritesBloc is NewFavoritesEmpty', () {
      expect(favoritesBloc.state, NewFavoritesEmpty());
    });

    test('after closing FavoritesBloc does not emit any states', () {
      expectLater(favoritesBloc, emits(emitsDone));

      favoritesBloc.close();
    });

    test(
        'WHEN favorites_screen is shown'
        'AND no values in database have isFavorite property set to true'
        'THEN FavoritesBloc emits NewFavoritesEmpty state', () {
      final List<ValueBase> valuesList = [
        ValueBase(
          id: 1,
          valueText: '1 Exceed clients\' and colleagues\' expectations',
          isFavorite: false,
          timestamp: DateTime.now(),
        ),
        ValueBase(
          id: 2,
          valueText:
              '2 Take ownership and question the status quo in a constructive manner',
          isFavorite: false,
          timestamp: DateTime.now(),
        ),
        ValueBase(
          id: 3,
          valueText:
              '3 Be brave, curious and experiment. Learn from all successes and failures',
          isFavorite: false,
          timestamp: DateTime.now(),
        ),
      ];

      final List<String> favoritesList = List();

      when(mockValuesRepository.getAllValues())
          .thenAnswer((_) => Future.value(valuesList));

      when(mockValuesRepository.getFavoritesList())
          .thenAnswer((_) => Future.value(favoritesList));

      expectLater(
          favoritesBloc,
          emitsInOrder([
            NewFavoritesEmpty(),
          ]));

      favoritesBloc.add(FavoritesListRequested());
    });

    test(
        'WHEN favorites_screen is shown'
        'AND some values in database have isFavorite property set to true'
        'THEN FavoritesBloc emits NewFavoritesUpdateSuccess state with favoritesList',
        () {
      final List<ValueBase> valuesList = [
        ValueBase(
          id: 1,
          valueText: '1 Exceed clients\' and colleagues\' expectations',
          isFavorite: false,
          timestamp: DateTime.now(),
        ),
        ValueBase(
          id: 2,
          valueText:
              '2 Take ownership and question the status quo in a constructive manner',
          isFavorite: true,
          timestamp: DateTime.now(),
        ),
        ValueBase(
          id: 3,
          valueText:
              '3 Be brave, curious and experiment. Learn from all successes and failures',
          isFavorite: true,
          timestamp: DateTime.now(),
        ),
      ];

      final List<String> favoritesList = [
        '2 Take ownership and question the status quo in a constructive manner',
        '3 Be brave, curious and experiment. Learn from all successes and failures',
      ];
      when(mockValuesRepository.getAllValues())
          .thenAnswer((_) => Future.value(valuesList));

      when(mockValuesRepository.getFavoritesList())
          .thenAnswer((_) => Future.value(favoritesList));

      expectLater(
          favoritesBloc,
          emitsInOrder([
            NewFavoritesUpdateSuccess(favoritesList: favoritesList),
          ]));

      favoritesBloc.add(FavoritesListRequested());
    });
  });
}
