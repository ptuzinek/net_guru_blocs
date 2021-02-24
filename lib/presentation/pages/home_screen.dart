import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/bloc/tab/tab_bloc.dart';
import 'package:net_guru_blocs/data/models/app_tab.dart';
import 'package:net_guru_blocs/presentation/pages/values_screen.dart';
import 'package:net_guru_blocs/presentation/widgets/bottom_tabs.dart';
import 'package:net_guru_blocs/presentation/widgets/floating_button.dart';
import 'add_screen.dart';
import 'favorites_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(PageController());
}

class _HomePageState extends State<HomePage> {
  TabBloc tabBloc;
  final PageController controller;

  _HomePageState(this.controller);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ValuesBloc>(context).add(AppStarted());
    tabBloc = BlocProvider.of<TabBloc>(context);
  }

  @override
  void dispose() {
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
            } else if (state is UserScrollState) {
              activeTab = state.currentTab;
            } else if (state is NewPageState) {
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
                appBar: AppBar(
                  actions: [
                    Hero(
                      tag: 'netguru',
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: Image.asset('images/netguru_icon.png')),
                      ),
                    ),
                  ],
                  // centerTitle: true,
                  title: Text('Netguru values'),
                ),
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
                    FocusScope.of(context).unfocus();
                    if (state is NewPageState) {
                      tabBloc.add(UserScrolledToNewPage(
                          currentTab: AppTab.values[index]));
                    }
                  },
                  children: [
                    ValuesScreen(),
                    AddScreen(),
                    FavoritesScreen(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
