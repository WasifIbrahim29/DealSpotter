import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';

class WhiteButton extends StatelessWidget {
  WhiteButton({this.title, this.colour, @required this.onPressed, this.height});

  final Color colour;
  final String title;
  final Function onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      color: Colors.white,
      onPressed: onPressed,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: primaryColor, width: 2)),
      height: height != null ? height : 46,
      child: Text(
        title,
        style: TextStyle(
          color: colour,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}
