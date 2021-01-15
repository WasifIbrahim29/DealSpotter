import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';

class TextBox extends StatefulWidget {
  TextBox({this.hint, this.validator, this.obscureText});

  final String hint;
  final String Function(String) validator;
  final bool obscureText;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      cursorColor: Colors.black,
      obscureText: widget.obscureText == true ? true : false,
      style: TextStyle(
        backgroundColor: Colors.white,
      ),
      textAlign: TextAlign.center,
      decoration: kTextFieldDecoration.copyWith(hintText: widget.hint),
    );
  }
}
