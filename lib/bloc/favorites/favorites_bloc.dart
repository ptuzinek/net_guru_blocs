import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:net_guru_blocs/data/repositories/values_repository.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ValuesRepository repository;
  final ValuesBloc valuesBloc;
  StreamSubscription valuesSubscription;

  FavoritesBloc({this.repository, this.valuesBloc})
      : super(NewFavoritesEmpty()) {
    valuesSubscription = valuesBloc.listen((state) {
      if (state is ValuesStateLoading) {
        add(FavoritesListRequested());
      }
    });
  }

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
      final favoritesList = await repository.getFavoritesList();
      if (favoritesList.length == 0) {
        yield NewFavoritesEmpty();
      } else {
        yield NewFavoritesUpdateSuccess(favoritesList: favoritesList);
      }
    } catch (e) {
      print('ERROR content: ${e.toString()}');
      yield ValuesLoadFailure(error: e);
    }
  }

  @override
  Future<void> close() {
    valuesSubscription.cancel();
    return super.close();
  }
}
