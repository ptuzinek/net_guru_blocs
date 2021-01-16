import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ValuesBloc valuesBloc;
  StreamSubscription valuesBlocSubscription;
  FavoritesBloc({@required this.valuesBloc}) : super(FavoritesEmpty()) {
    valuesBlocSubscription = valuesBloc.listen((valuesState) {
      print('FavoritesBloc');
      print('Before if statement');
      if (valuesState is IconChangedSuccess) {
        print('FavoritesBloc');
        print('state is IconChangedSuccess');
        print('Favorites List: ${valuesState.favoritesList}');
        add(NewFavoriteValue(valuesState.favoritesList));
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
    if (event is NewFavoriteValue) {
      yield* _mapNewFavoriteValueToState(event);
    }
  }

  Stream<FavoritesState> _mapNewFavoriteValueToState(
      NewFavoriteValue event) async* {
    print('In _mapNewFavoriteValueToState');
    print('favoritesList: ${event.favoritesList}');
    yield FavoritesUpdateSuccess(favoritesList: event.favoritesList);
  }

  @override
  Future<void> close() {
    valuesBlocSubscription.cancel();
    return super.close();
  }
}
