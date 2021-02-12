import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:net_guru_blocs/data/repositories/values_repository.dart';
import 'package:net_guru_blocs/data/models/constants.dart' as constants;
part 'values_event.dart';
part 'values_state.dart';

class ValuesBloc extends Bloc<ValuesEvent, ValuesState> {
  final ValuesRepository repository;
  final Random rnd = Random();

  ValuesBloc({@required this.repository}) : super(ValuesStateLoading());

  @override
  void onTransition(Transition<ValuesEvent, ValuesState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<ValuesState> mapEventToState(ValuesEvent event) async* {
    if (event is AddedNewValue) {
      yield* _mapAddedNewValueToState(event);
    } else if (event is LikedValue) {
      yield* _mapLikedValueToState(event);
    } else if (event is AnimationEnded) {
      yield* _mapAnimationEndedToState(event);
    } else if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    }
  }

  Stream<ValuesState> _mapAddedNewValueToState(AddedNewValue event) async* {
    final currentState = (state as ValuesUpdateSuccess);
    yield ValuesUpdateSuccess(newValue: currentState.newValue);
    repository.insertValue(event.newValue);
  }

  Stream<ValuesState> _mapLikedValueToState(LikedValue event) async* {
    // update current ValueBase object and pass it to the new state
    final ValueBase newValue =
        event.likedValue.copyWith(isFavorite: true, timestamp: DateTime.now());
    yield ValuesUpdateSuccess(newValue: newValue);
    repository.updateValue(newValue);
  }

  Stream<ValuesState> _mapAnimationEndedToState(AnimationEnded event) async* {
    try {
      List<ValueBase> valuesList = await repository.getAllValues();
      final int index = _getNextIndex(valuesList);
      yield ValuesUpdateSuccess(newValue: valuesList[index]);
    } catch (error) {
      print('Error in _mapAnimationEndedToState: $error');
      yield ValuesLoadFailure(error: error);
    }
  }

  Stream<ValuesState> _mapAppStartedToState(AppStarted event) async* {
    try {
      List<ValueBase> valuesList = await repository.getAllValues();
      if (valuesList.length == 0) {
        valuesList = constants.startingValuesList;
        repository.saveValues(constants.startingValuesList);
      }
      final int index = rnd.nextInt(valuesList.length);
      yield ValuesUpdateSuccess(newValue: valuesList[index]);
    } catch (error) {
      print('Error in _mapAppStartedToState $error');
      yield ValuesLoadFailure(error: error);
    }
  }

  int _getNextIndex(List<ValueBase> valuesList) {
    final currentState = (state as ValuesUpdateSuccess);
    int nextIndex = rnd.nextInt(valuesList.length);

    while (valuesList[nextIndex].id == currentState.newValue.id) {
      nextIndex = rnd.nextInt(valuesList.length);
    }
    return nextIndex;
  }
}
