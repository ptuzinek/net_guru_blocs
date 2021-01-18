import 'package:flutter/material.dart';
import 'package:net_guru_blocs/model/app_tab.dart';

class FloatingButton extends StatelessWidget {
  final AppTab activeTab;
  final Function onPressed;

  FloatingButton({this.activeTab, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        color: activeTab == AppTab.addValue ? Colors.white : Colors.black,
      ),
      onPressed: onPressed,
    );
  }
}
