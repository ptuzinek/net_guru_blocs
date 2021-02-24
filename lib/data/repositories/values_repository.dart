import 'dart:math';

import 'package:net_guru_blocs/data/data_providers/values_api.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';

class ValuesRepository {
  final ValuesDataApi valuesDataApi;
  final Random rnd = Random();

  ValuesRepository({this.valuesDataApi});

  ValueBase getValueWithTimestamp(ValueBase valueBase) {
    return valueBase.copyWith(timestamp: DateTime.now());
  }

  Future getLikedValue(ValueBase likedValue) async {
    if (likedValue.isFavorite) {
      likedValue = likedValue.copyWith(isFavorite: false);
      await updateValue(likedValue);
      return likedValue;
    } else {
      likedValue =
          likedValue.copyWith(isFavorite: true, timestamp: DateTime.now());

      await updateValue(likedValue);
      return likedValue;
    }
  }

  Future getRandomValue({int previousId}) async {
    final valuesList = await valuesDataApi.getAllValues();
    int nextIndex = rnd.nextInt(valuesList.length);

    while (valuesList[nextIndex].id == previousId) {
      nextIndex = rnd.nextInt(valuesList.length);
    }
    return valuesList[nextIndex];
  }

  Future getFavoritesList() async {
    final valuesList = await valuesDataApi.getAllValues();

    List<String> favoritesList = List();
    valuesList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    valuesList.forEach((element) {
      if (element.isFavorite) {
        favoritesList.add(element.valueText);
      }
    });
    return favoritesList;
  }

  Future getAllValues() => valuesDataApi.getAllValues();

  Future insertValue(ValueBase valueBase) =>
      valuesDataApi.insertValue(valueBase);

  Future updateValue(ValueBase valueBase) =>
      valuesDataApi.updateValue(valueBase);

  Future saveValues(List<ValueBase> valuesList) =>
      valuesDataApi.saveValues(valuesList);

  Future deleteValueById(int id) => valuesDataApi.deleteValue(id);

  Future deleteAllValues() => valuesDataApi.clearTable();
}
