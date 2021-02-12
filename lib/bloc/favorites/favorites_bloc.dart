import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:net_guru_blocs/data/repositories/values_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ValuesRepository repository;

  FavoritesBloc({this.repository}) : super(NewFavoritesEmpty());

  @override
  void onTransition(Transition<FavoritesEvent, FavoritesState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is FavoritesListRequested) {
      yield* _mapFavoritesListRequestedToState(event);
    }
  }

  Stream<FavoritesState> _mapFavoritesListRequestedToState(
      FavoritesListRequested event) async* {
    try {
      List<ValueBase> valuesList = await repository.getAllValues();
      final favoritesList = _mapValuesToFavorites(valuesList);
      if (favoritesList.length == 0) {
        yield NewFavoritesEmpty();
      } else {
        yield NewFavoritesUpdateSuccess(favoritesList: favoritesList);
      }
    } catch (e) {
      yield ValuesLoadFailure(error: e);
    }
  }

  List<String> _mapValuesToFavorites(List<ValueBase> valuesList) {
    List<String> favoritesList = List();
    valuesList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    valuesList.forEach((element) {
      if (element.isFavorite) {
        favoritesList.add(element.valueText);
      }
    });
    return favoritesList;
  }
}
