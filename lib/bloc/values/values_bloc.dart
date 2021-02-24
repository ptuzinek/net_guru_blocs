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
    yield ValueAddSuccess(addedValue: event.newValue);

    final ValueBase newValue = repository.getValueWithTimestamp(event.newValue);
    final int id = await repository.insertValue(newValue);

    yield ValuesUpdateSuccess(newValue: newValue.copyWith(id: id));
  }

  Stream<ValuesState> _mapLikedValueToState(LikedValue event) async* {
    // update current ValueBase object and pass it to the new state
    final ValueBase newValue = await repository.getLikedValue(event.likedValue);
    yield ValuesUpdateSuccess(newValue: newValue);
  }

  Stream<ValuesState> _mapAnimationEndedToState(AnimationEnded event) async* {
    try {
      final ValueBase valueBase = await repository.getRandomValue(
          previousId: (state as ValuesUpdateSuccess).newValue.id);

      yield ValuesUpdateSuccess(newValue: valueBase);
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
      final ValueBase valueBase = await repository.getRandomValue(
          previousId:
              0); // zero to not exclude any possible value from the valuesList
      yield ValuesUpdateSuccess(newValue: valueBase);
    } catch (error) {
      print('Error in _mapAppStartedToState $error');
      yield ValuesLoadFailure(error: error);
    }
  }
}
