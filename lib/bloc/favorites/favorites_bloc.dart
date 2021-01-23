import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../values_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ValuesRepository repository;
  FavoritesBloc({this.repository})
      : super(FavoritesUpdateSuccess(
            favoritesList: repository.localFavoritesList));

  @override
  void onTransition(Transition<FavoritesEvent, FavoritesState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is NewFavoriteValue) {
      yield* _mapNewFavoriteValueToState(event);
    }
  }

  Stream<FavoritesState> _mapNewFavoriteValueToState(
      NewFavoriteValue event) async* {
    // Save favoritesList to SharedPreferences
    List<String> updatedList = repository.addToFavoritesList(event.newFavorite);
    yield FavoritesUpdateSuccess(
      favoritesList: updatedList,
    );
  }
}
