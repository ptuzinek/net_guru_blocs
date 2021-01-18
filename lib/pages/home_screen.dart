import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_guru_blocs/bloc/favorites/favorites_bloc.dart';
import 'package:net_guru_blocs/bloc/tab/tab_bloc.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/components/bottom_tabs.dart';
import 'package:net_guru_blocs/components/floating_button.dart';
import 'package:net_guru_blocs/model/app_tab.dart';
import 'package:net_guru_blocs/pages/values_screen.dart';
import 'add_screen.dart';
import 'favorites_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(PageController());
}

class _HomePageState extends State<HomePage> {
  ValuesBloc valuesBloc;
  FavoritesBloc favoritesBloc;
  TabBloc tabBloc;
  final PageController controller;

  _HomePageState(this.controller);

  @override
  void initState() {
    super.initState();
    valuesBloc = BlocProvider.of<ValuesBloc>(context);
    favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    tabBloc = BlocProvider.of<TabBloc>(context);
  }

  @override
  void dispose() {
    valuesBloc.close();
    favoritesBloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TabBloc, TabState>(
      cubit: tabBloc,
      listener: (context, state) {
        if (state is NewTabSelectionState) {
          final selectedTab = state.selectedTab;
          if (selectedTab == AppTab.valueAnimation) {
            controller.animateToPage(0,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          }
          if (selectedTab == AppTab.addValue) {
            controller.animateToPage(1,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          }
          if (selectedTab == AppTab.favoritesList) {
            controller.animateToPage(2,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          }
        }
      },
      child: BlocBuilder<TabBloc, TabState>(
          cubit: tabBloc,
          builder: (context, state) {
            AppTab activeTab;
            if (state is NewTabSelectionState) {
              activeTab = state.selectedTab;
            }
            if (state is UserScrollState) {
              activeTab = state.currentTab;
            }
            if (state is NewPageState) {
              activeTab = state.newTab;
            }
            return NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  // RESET THE STATE
                  // To unblock the state update caused by scrolling to new page
                  // to be sure that the right tab is active when the scroll ends
                  tabBloc.add(AnimationToNewPageEnded(
                      newTab: AppTab.values[controller.page.round()]));
                }
                return true;
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingButton(
                  activeTab: activeTab,
                  onPressed: () => tabBloc
                      .add(UserSelectedTab(selectedTab: AppTab.addValue)),
                ),
                bottomNavigationBar: BottomTabs(
                  activeTab: activeTab,
                  onValuesPress: () => tabBloc
                      .add(UserSelectedTab(selectedTab: AppTab.valueAnimation)),
                  onFavoritesPress: () => tabBloc
                      .add(UserSelectedTab(selectedTab: AppTab.favoritesList)),
                ),
                body: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    if (state is NewPageState) {
                      tabBloc.add(UserScrolledToNewPage(
                          currentTab: AppTab.values[index]));
                    }
                  },
                  children: [
                    ValuesScreen(
                      bloc: valuesBloc,
                    ),
                    AddScreen(
                      bloc: valuesBloc,
                    ),
                    FavoritesScreen(
                      bloc: favoritesBloc,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
