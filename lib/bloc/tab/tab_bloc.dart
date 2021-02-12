import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:net_guru_blocs/data/models/app_tab.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(NewPageState(newTab: AppTab.valueAnimation));

  @override
  void onTransition(Transition<TabEvent, TabState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<TabState> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is UserSelectedTab) {
      yield NewTabSelectionState(selectedTab: event.selectedTab);
    } else if (event is UserScrolledToNewPage) {
      yield NewPageState(newTab: event.currentTab);
    } else if (event is AnimationToNewPageEnded) {
      yield NewPageState(newTab: event.newTab);
    }
  }
}
