part of 'values_bloc.dart';

abstract class ValuesState extends Equatable {
  ValuesState([List props = const []]) : super(props);
}

class ValuesStateLoading extends ValuesState {
  @override
  String toString() => 'ValuesStateLoading';
}

class ValuesUpdateSuccess extends ValuesState {
  final List<String> valuesList;
  final List<String> favoritesList;
  final int index;

  ValuesUpdateSuccess({this.valuesList, this.favoritesList, this.index})
      : super([valuesList, favoritesList, index]);

  @override
  String toString() => 'ValuesUpdateSuccess {index: $index , '
      'valuesQuantity: ${valuesList.length}, '
      'favoritesQuantity: ${favoritesList.length}';
}
