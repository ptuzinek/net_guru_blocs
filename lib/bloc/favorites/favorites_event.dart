part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  FavoritesEvent([List props = const []]) : super(props);
}

class FavoritesListRequested extends FavoritesEvent {
  @override
  String toString() => 'FavoritesListRequested';
}
