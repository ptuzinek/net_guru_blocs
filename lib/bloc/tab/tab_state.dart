part of 'tab_bloc.dart';

abstract class TabState extends Equatable {
  TabState([List props = const []]) : super(props);
}

class UserScrollState extends TabState {
  final AppTab currentTab;

  UserScrollState({this.currentTab}) : super([currentTab]);
}

class NewTabSelectionState extends TabState {
  final AppTab selectedTab;

  NewTabSelectionState({this.selectedTab}) : super([selectedTab]);

  @override
  String toString() => 'ChangeTabState: $selectedTab';
}

class NewPageState extends TabState {
  final AppTab newTab;

  NewPageState({this.newTab}) : super([newTab]);

  @override
  String toString() => 'NewPageState: $newTab';
}
