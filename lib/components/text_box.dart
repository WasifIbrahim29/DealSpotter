import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:intl/intl.dart';

class TextBox extends StatefulWidget {
  TextBox(
      {this.hint,
      this.validator,
      this.obscureText,
      this.initialValue,
      this.dobController,
      this.labelText});

  final String hint;
  final String Function(String) validator;
  final bool obscureText;
  final String initialValue;
  final String labelText;
  final TextEditingController dobController;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    print("picked: $picked");
    if (picked != null && picked != selectedDate)
      setState(() {
        print("selectedDate: $picked");
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      validator: widget.validator,
      cursorColor: Colors.black,
      onTap: () async {
        if (widget.hint == "Date Of Birth") {
          await _selectDate(context);
          print(selectedDate);
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          widget.dobController.text = formattedDate;
        }
      },
      obscureText: widget.obscureText == true ? true : false,
      style: TextStyle(
        backgroundColor: Colors.white,
      ),
      textAlign: TextAlign.center,
      controller: widget.dobController,
      decoration: kTextFieldDecoration.copyWith(
          hintText: widget.hint, labelText: widget.labelText),
    );
  }
}
