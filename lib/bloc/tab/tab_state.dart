part of 'tab_bloc.dart';

abstract class TabState extends Equatable {
  TabState([List props = const []]) : super(props);
}

class UserScrollState extends TabState {
  final AppTab currentTab;

  UserScrollState({this.currentTab}) : super([currentTab]);

  @override
  String toString() => 'UserScrollState { current tab: $currentTab }';
}

class NewTabSelectionState extends TabState {
  final AppTab selectedTab;

  NewTabSelectionState({this.selectedTab}) : super([selectedTab]);

  @override
  String toString() => 'NewTabSelectionState { selected tab: $selectedTab }';
}

class NewPageState extends TabState {
  final AppTab newTab;

  NewPageState({this.newTab}) : super([newTab]);

  @override
  String toString() => 'NewPageState { new tab: $newTab }';
}
