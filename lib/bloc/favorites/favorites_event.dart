part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  FavoritesEvent([List props = const []]) : super(props);
}

class NewFavoriteValue extends FavoritesEvent {
  //final List<String> favoritesList;
  //NewFavoriteValue(this.favoritesList) : super([favoritesList]);
  final String newFavorite;
  final int index;

  NewFavoriteValue({this.newFavorite, this.index})
      : super([newFavorite, index]);
}
