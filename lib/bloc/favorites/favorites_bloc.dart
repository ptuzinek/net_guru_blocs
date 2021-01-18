import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../values_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  // final ValuesBloc valuesBloc;
  // StreamSubscription valuesBlocSubscription;
  // FavoritesBloc({@required this.valuesBloc}) : super(FavoritesEmpty()) {
  //   valuesBlocSubscription = valuesBloc.listen((valuesState) {
  //     if (valuesState is IconChangedSuccess) {
  //       add(NewFavoriteValue(valuesState.favoritesList));
  //     }
  //   });
  // }
  final ValuesRepository repository;
  FavoritesBloc({this.repository}) : super(FavoritesEmpty());

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
    //yield FavoritesUpdateSuccess(favoritesList: event.favoritesList);
    repository.localValuesList[event.index].isFavorite = true;
    List<String> updatedList = List();
    repository.localValuesList.forEach((valueBase) {
      if (valueBase.isFavorite) {
        updatedList.add(valueBase.valueText);
      }
    });
    print('PRINT THE UPDATEDLIST: $updatedList');
    yield FavoritesUpdateSuccess(
      favoritesList: updatedList,
    );
  }
}
