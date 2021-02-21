import 'package:flutter_test/flutter_test.dart';
import 'package:net_guru_blocs/bloc/tab/tab_bloc.dart';
import 'package:net_guru_blocs/data/models/app_tab.dart';

void main() {
  TabBloc tabBloc;

  setUp(() {
    tabBloc = TabBloc();
  });

  tearDown(() {
    tabBloc.close();
  });

  group('TabBloc', () {
    test(
        'the initial state for the TabBloc is NewPageState with AppTab.valueAnimation',
        () {
      expect(tabBloc.state, NewPageState(newTab: AppTab.valueAnimation));
    });

    test('after closing TabBloc does not emit any states', () {
      expectLater(tabBloc, emits(emitsDone));

      tabBloc.close();
    });

    test(
        'WHEN user select the tab'
        'THEN TabBloc emits NewTabSelectionState with selected tab', () {
      AppTab selectedTab = AppTab.addValue;

      expectLater(
          tabBloc,
          emitsInOrder([
            NewTabSelectionState(selectedTab: selectedTab),
          ]));

      tabBloc.add(UserSelectedTab(selectedTab: selectedTab));
    });

    test(
        'WHEN user select the tab'
        'AND animation to new page ends'
        'THEN TabBloc emits NewTabSelectionState and NewPageState', () {
      AppTab selectedTab = AppTab.addValue;

      expectLater(
          tabBloc,
          emitsInOrder([
            NewTabSelectionState(selectedTab: selectedTab),
            NewPageState(newTab: selectedTab),
          ]));

      tabBloc.add(UserSelectedTab(selectedTab: selectedTab));
      tabBloc.add(AnimationToNewPageEnded(newTab: selectedTab));
    });

    test(
        'WHEN user scrolls to new page'
        'THEN TabBloc emits NewPageState with new tab', () {
      AppTab newTab = AppTab.addValue;

      expectLater(
          tabBloc,
          emitsInOrder([
            NewPageState(newTab: newTab),
          ]));

      tabBloc.add(UserScrolledToNewPage(currentTab: newTab));
    });

    test(
        'WHEN user clicks on the current tab'
        'THEN TabBloc does not emit any new state', () {
      AppTab currentTab = AppTab.valueAnimation;

      expectLater(tabBloc, emitsInOrder([]));

      tabBloc.add(UserSelectedTab(selectedTab: currentTab));
    });

    test(
        'WHEN user selects a tab'
        'AND user clicks on the current tab'
        'AND user scrolls to new page'
        'THEN TabBloc emits NewPageState with new tab', () {
      AppTab selectedTab = AppTab.addValue;
      AppTab newTab = AppTab.valueAnimation;

      expectLater(
          tabBloc,
          emitsInOrder([
            NewTabSelectionState(selectedTab: selectedTab),
            NewPageState(newTab: selectedTab),
            NewPageState(newTab: newTab),
          ]));

      tabBloc.add(UserSelectedTab(selectedTab: selectedTab));
      tabBloc.add(AnimationToNewPageEnded(newTab: selectedTab));
      tabBloc.add(UserSelectedTab(selectedTab: selectedTab));
      tabBloc.add(UserScrolledToNewPage(currentTab: newTab));
    });
  });
}
