part of 'values_bloc.dart';

abstract class ValuesState extends Equatable {
  ValuesState([List props = const []]) : super(props);
}

class ValuesStateLoading extends ValuesState {
  @override
  String toString() => 'ValuesStateLoading';
}

class ValuesUpdateSuccess extends ValuesState {
  final List<ValueBase> valuesList;
  final int index;

  ValuesUpdateSuccess(this.valuesList, this.index) : super([valuesList]);

  @override
  String toString() =>
      'ValuesUpdateSuccess {index: $index , valuesQuantity: ${valuesList.length}}';
}

class IconChangedSuccess extends ValuesState {
  final List<String> favoritesList;

  IconChangedSuccess({this.favoritesList}) : super([favoritesList]);

  @override
  String toString() => 'IconChangedSuccess { likedValueList: $favoritesList}';
}
