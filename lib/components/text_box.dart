import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';

class TextBox extends StatelessWidget {
  TextBox({this.hint, this.validator});

  final String hint;
  final String Function(String) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      cursorColor: Colors.black,
      style: TextStyle(
        backgroundColor: Colors.white,
      ),
      textAlign: TextAlign.center,
      decoration: kTextFieldDecoration.copyWith(hintText: hint),
    );
  }
}
