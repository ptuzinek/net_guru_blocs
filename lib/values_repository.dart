import 'dart:math';

import 'model/value_base.dart';

class ValuesRepository {
  final List<ValueBase> localValuesList = [
    ValueBase(
        valueText: '1 Exceed clients\' and colleagues\' expectations',
        isFavorite: false),
    ValueBase(
        valueText:
            '2 Take ownership and question the status quo in a constructive manner',
        isFavorite: false),
    ValueBase(
        valueText:
            '3 Be brave, curious and experiment. Learn from all successes and failures',
        isFavorite: false),
    ValueBase(
        valueText: '4 Act in a way that makes all of us proud',
        isFavorite: false),
    ValueBase(
        valueText:
            '5 Build an inclusive, transparent and socially responsible culture',
        isFavorite: false),
    ValueBase(
        valueText: '6 Be ambitious, grow yourself and the people around you',
        isFavorite: false),
    ValueBase(
        valueText: '7 Recognize excellence and engagement', isFavorite: false),
  ];

  final List<String> localFavoritesList = List();
  int index;
  Random rnd = Random();

  ValuesRepository() {
    index = rnd.nextInt(localValuesList.length);
  }

  int getNextIndex() {
    int nextIndex = rnd.nextInt(localValuesList.length);
    while (nextIndex == index) {
      nextIndex = rnd.nextInt(localValuesList.length);
    }
    return nextIndex;
  }

  List<ValueBase> getValuesList() {
    return localValuesList;
  }

  List<ValueBase> addToValuesList(ValueBase newValue) {
    localValuesList.add(newValue);
    return localValuesList;
  }

  List<String> addToFavoritesList(String newValue) {
    localFavoritesList.add(newValue);

    return localFavoritesList;
  }
}
