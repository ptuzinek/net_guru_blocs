import 'package:flutter/material.dart';
import 'package:net_guru_blocs/model/app_tab.dart';

class FloatingButton extends StatelessWidget {
  final AppTab activeTab;
  final Function onPressed;

  FloatingButton({this.activeTab, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 12,
      backgroundColor: Colors.lightGreenAccent,
      child: Icon(
        Icons.add,
        size: 30,
        color: activeTab == AppTab.addValue ? Colors.white : Colors.black,
      ),
      onPressed: onPressed,
    );
  }
}
