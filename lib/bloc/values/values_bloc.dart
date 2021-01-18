import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:net_guru_blocs/model/value_base.dart';

import '../../values_repository.dart';

part 'values_event.dart';
part 'values_state.dart';

class ValuesBloc extends Bloc<ValuesEvent, ValuesState> {
  final ValuesRepository repository;

  ValuesBloc({@required this.repository})
      : super(
            ValuesUpdateSuccess(repository.localValuesList, repository.index));

  @override
  void onTransition(Transition<ValuesEvent, ValuesState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<ValuesState> mapEventToState(
    ValuesEvent event,
  ) async* {
    if (event is AddedNewValue) {
      yield* _mapAddedNewValueToState(event);
    } else if (event is LikedValue) {
      yield* _mapLikedValueToState(event);
    } else if (event is AnimationEnded) {
      yield* _mapAnimationEndedToState(event);
    }
  }

  Stream<ValuesState> _mapAddedNewValueToState(AddedNewValue event) async* {
    yield ValuesStateLoading();
    List<ValueBase> updatedList = repository.addToValuesList(event.newValue);
    yield ValuesUpdateSuccess(
      updatedList,
      repository.index,
      //repository.localLikesList,
    );
  }

  Stream<ValuesState> _mapLikedValueToState(LikedValue event) async* {
    yield ValuesStateLoading();
    // repository.localValuesList[event.index].isFavorite = true;
    // List<String> updatedList = List();
    // repository.localValuesList.forEach((valueBase) {
    //   if (valueBase.isFavorite) {
    //     updatedList.add(valueBase.valueText);
    //   }
    // });
    // print('PRINT THE UPDATEDLIST: $updatedList');
    // yield IconChangedSuccess(
    //   favoritesList: updatedList,
    // );
    yield ValuesUpdateSuccess(repository.localValuesList, repository.index);
  }

  Stream<ValuesState> _mapAnimationEndedToState(AnimationEnded event) async* {
    yield ValuesStateLoading();
    int index = repository.getNextIndex();
    repository.index = index;
    yield ValuesUpdateSuccess(
      repository.getValuesList(),
      index,
    );
  }
}
