import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:net_guru_blocs/bloc/values/values_bloc.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:net_guru_blocs/presentation/widgets/add_value_text_field.dart';

// Stateful - TextField

class AddScreen extends StatefulWidget {
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

  void addNewValueToList(ValueBase newValue) {
    if (newValue.valueText.length > 0) {
      textEditingController.clear();
      BlocProvider.of<ValuesBloc>(context)
          .add(AddedNewValue(newValue: newValue));
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
      child: BlocListener<ValuesBloc, ValuesState>(
        listener: (context, state) {
          if (state is ValueAddSuccess) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Added new Value',
                key: const Key('SnackBarText'),
              ),
            ));
          }
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
                onPressed: () => addNewValueToList(ValueBase(
                  valueText: newValue,
                  isFavorite: false,
                )),
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
