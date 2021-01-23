import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class ValuesRepository {
  final SharedPreferences preferences;
  int index;
  Random rnd = Random();
  List<String> localFavoritesList = List();
  List<String> localValuesList = [
    '1 Exceed clients\' and colleagues\' expectations',
    '2 Take ownership and question the status quo in a constructive manner',
    '3 Be brave, curious and experiment. Learn from all successes and failures',
    '4 Act in a way that makes all of us proud',
    '5 Build an inclusive, transparent and socially responsible culture',
    '6 Be ambitious, grow yourself and the people around you',
    '7 Recognize excellence and engagement',
  ];

  ValuesRepository({this.preferences}) {
    index = rnd.nextInt(localValuesList.length);
    localValuesList = getValuesListFromSP();
    localFavoritesList = getFavoriteListFromSP();
  }

  List<String> getValuesListFromSP() {
    return preferences.getStringList('valuesList') ?? localValuesList;
  }

  saveValuesListToSP(List<String> newValuesList) {
    preferences.setStringList('valuesList', newValuesList);
  }

  List<String> getFavoriteListFromSP() {
    return preferences.getStringList('favoritesList') ?? localFavoritesList;
  }

  saveFavoriteListToSP(List<String> newFavoritesList) {
    preferences.setStringList('favoritesList', newFavoritesList);
  }

  int getNextIndex() {
    int nextIndex = rnd.nextInt(localValuesList.length);
    while (nextIndex == index) {
      nextIndex = rnd.nextInt(localValuesList.length);
    }
    return nextIndex;
  }

  List<String> addToValuesList(String newValue) {
    localValuesList.add(newValue);
    saveValuesListToSP(localValuesList);
    return localValuesList;
  }

  List<String> addToFavoritesList(String newValue) {
    if (!localFavoritesList.contains(newValue)) {
      localFavoritesList.add(newValue);
      saveFavoriteListToSP(localFavoritesList);
    }
    return localFavoritesList;
  }
}
