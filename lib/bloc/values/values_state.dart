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
      'ValuesUpdateSuccess { newValue: ${newValue.valueText} }';
}
