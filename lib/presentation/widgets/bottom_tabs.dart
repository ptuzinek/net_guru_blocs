import 'package:flutter/material.dart';
import 'package:net_guru_blocs/data/models/app_tab.dart';

class BottomTabs extends StatelessWidget {
  final AppTab activeTab;
  final BuildContext context;
  final Function onValuesPress;
  final Function onFavoritesPress;

  BottomTabs({
    this.context,
    this.onValuesPress,
    this.onFavoritesPress,
    this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Theme.of(context).primaryColor,
      notchMargin: 8.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 12.0),
            child: MaterialButton(
              key: const Key('values_screen'),
              onPressed: onValuesPress,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.format_quote,
                    color: activeTab == AppTab.valueAnimation
                        ? Colors.white
                        : Colors.black,
                  ),
                  Text(
                    'Values',
                    style: TextStyle(
                      color: activeTab == AppTab.valueAnimation
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 12.0),
            child: MaterialButton(
              key: const Key('favorites_screen'),
              onPressed: onFavoritesPress,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.list,
                    color: activeTab == AppTab.favoritesList
                        ? Colors.white
                        : Colors.black,
                  ),
                  Text(
                    'Favorites',
                    style: TextStyle(
                      color: activeTab == AppTab.favoritesList
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
