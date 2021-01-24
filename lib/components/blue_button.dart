import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';

class BlueButton extends StatelessWidget {
  BlueButton({this.title, this.colour, @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: primaryColor,
      borderRadius: BorderRadius.circular(2.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: double.infinity,
        height: 46.0,
        child: Text(
          title,
          style: TextStyle(
            color: colour,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
