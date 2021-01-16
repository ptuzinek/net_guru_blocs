part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  FavoritesState([List props = const []]) : super(props);
}

class FavoritesEmpty extends FavoritesState {
  @override
  String toString() => 'FavoritesEmpty';
}

class FavoritesUpdateSuccess extends FavoritesState {
  final List<String> favoritesList;

  FavoritesUpdateSuccess({this.favoritesList}) : super([favoritesList]);
  @override
  String toString() =>
      'FavoritesUpdateSuccess: favoritesQuantity: ${favoritesList.length}';
}
