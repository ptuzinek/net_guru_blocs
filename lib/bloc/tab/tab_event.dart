part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  TabEvent([List props = const []]) : super(props);
}

class AnimationToNewPageEnded extends TabEvent {
  final AppTab newTab;

  AnimationToNewPageEnded({this.newTab}) : super([newTab]);

  @override
  String toString() => 'AnimationToNewPageEnded { newTab: $newTab }';
}

class UserSelectedTab extends TabEvent {
  final AppTab selectedTab;

  UserSelectedTab({this.selectedTab}) : super([selectedTab]);

  @override
  String toString() => 'UserSelectedTab { selected tab: $selectedTab }';
}

class UserScrolledToNewPage extends TabEvent {
  final AppTab currentTab;

  UserScrolledToNewPage({this.currentTab}) : super([currentTab]);

  @override
  String toString() => 'UserScrolledToNewPage { currentTab: $currentTab }';
}
