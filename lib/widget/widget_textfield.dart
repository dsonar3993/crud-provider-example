import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final String labelText;
  final Function onSaved;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  WidgetTextField(
      {@required this.labelText,
      @required this.onSaved,
      @required this.textEditingController,
      @required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.textEditingController,
      focusNode: this.focusNode,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
