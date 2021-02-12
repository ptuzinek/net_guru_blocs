part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  FavoritesState([List props = const []]) : super(props);
}

class ValuesLoadFailure extends FavoritesState {
  final String error;

  ValuesLoadFailure({this.error}) : super([error]);

  @override
  String toString() => 'ValuesLoadFailure { ERROR: $error } ';
}

class NewFavoritesEmpty extends FavoritesState {
  @override
  String toString() => 'NewFavoritesEmpty';
}

class NewFavoritesUpdateSuccess extends FavoritesState {
  final List<String> favoritesList;

  NewFavoritesUpdateSuccess({this.favoritesList}) : super([favoritesList]);
  @override
  String toString() =>
      'FavoritesUpdateSuccess { favoritesQuantity: ${favoritesList.length} }';
}
