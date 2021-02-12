import 'package:flutter/material.dart';

class AddValueTextField extends StatefulWidget {
  AddValueTextField({
    @required this.onChanged,
    @required this.controller,
  });

  final Function onChanged;
  final TextEditingController controller;

  @override
  _AddValueTextFieldState createState() => _AddValueTextFieldState();
}

class _AddValueTextFieldState extends State<AddValueTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.multiline,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            hintText: 'Add new value here..',
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 4.0),
            )),
      ),
    );
  }
}
