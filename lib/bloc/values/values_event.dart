part of 'values_bloc.dart';

abstract class ValuesEvent extends Equatable {
  ValuesEvent([List props = const []]) : super(props);
}

class AppStarted extends ValuesEvent {
  AppStarted() : super([]);

  @override
  String toString() => 'AppStarted';
}

class AnimationEnded extends ValuesEvent {
  @override
  String toString() => 'AnimationEnded';
}

class AddedNewValue extends ValuesEvent {
  final ValueBase newValue;

  AddedNewValue({this.newValue}) : super([newValue]);

  @override
  String toString() => "AddedNewValue { newValue: $newValue }";
}

class LikedValue extends ValuesEvent {
  final ValueBase likedValue;

  LikedValue({this.likedValue}) : super([likedValue]);

  @override
  String toString() => "LikedValue";
}
