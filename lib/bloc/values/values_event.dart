part of 'values_bloc.dart';

abstract class ValuesEvent extends Equatable {
  ValuesEvent([List props = const []]) : super(props);
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
  // final String newFavorite;
  // final int index;

  // LikedValue({this.newFavorite, this.index}) : super([newFavorite]);
  LikedValue() : super([]);

  @override
  String toString() => "LikedValue";
}
