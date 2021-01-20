import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/components/add_value_text_field.dart';
import 'package:net_guru_blocs/model/value_base.dart';

// Stateful - TextField

class AddScreen extends StatefulWidget {
  AddScreen({@required this.bloc});
  final ValuesBloc bloc;

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController textEditingController = TextEditingController();
  String newValue = '';

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void addNewValueToList(String newValue) {
    if (newValue.length > 0) {
      textEditingController.clear();
      widget.bloc.add(AddedNewValue(newValue: newValue));
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            AddValueTextField(
              onChanged: (value) => newValue = value,
              controller: textEditingController,
            ),
            FlatButton(
              onPressed: () => addNewValueToList(newValue),
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
