import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {
  String label;
  Function(String) onSaved;
  TextEditingController controller;
  FutureBuilder Function(BuildContext) onTap;
  TextFeildWidget({this.label, this.onSaved, this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "$label",
        // border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter the $label';
        }
        return null;
      },
      onSaved: onSaved,
      focusNode: AlwaysDisabledFocusNode(),
      controller: controller,
      // onTap: () => onTap,
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
