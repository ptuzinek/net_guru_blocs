part of 'values_bloc.dart';

abstract class ValuesState extends Equatable {
  ValuesState([List props = const []]) : super(props);
}

class ValuesLoadFailure extends ValuesState {
  final error;

  ValuesLoadFailure({this.error}) : super([error]);

  @override
  String toString() => 'ValuesLoadFailure { ERROR: $error }';
}

class ValuesStateLoading extends ValuesState {
  @override
  String toString() => 'ValuesStateLoading';
}

class ValuesUpdateSuccess extends ValuesState {
  final ValueBase newValue;

  ValuesUpdateSuccess({this.newValue}) : super([newValue]);

  @override
  String toString() =>
      'ValuesUpdateSuccess { newValue: id: ${newValue.id}, valueText: ${newValue.valueText}, isFavorite: ${newValue.isFavorite}, '
      'timestamp: ${newValue.timestamp} }';
}

class ValueAddSuccess extends ValuesState {
  final ValueBase addedValue;

  ValueAddSuccess({this.addedValue}) : super([addedValue]);

  @override
  String toString() => 'ValueAddSuccess { addedValue: ${addedValue.valueText}';
}
