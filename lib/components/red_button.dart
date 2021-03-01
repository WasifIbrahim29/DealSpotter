import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';

class RedButton extends StatelessWidget {
  RedButton(
      {this.title,
      this.colour,
      @required this.onPressed,
      this.height,
      this.fontSize,
      this.maxLines});

  final Color colour;
  final String title;
  final Function onPressed;
  final double height;
  final double fontSize;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Colors.red,
      borderRadius: BorderRadius.circular(2.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: double.infinity,
        height: height != null ? height : 46,
        child: Text(
          title,
          maxLines: maxLines != null ? maxLines : 200,
          style: TextStyle(
            color: colour,
            fontWeight: FontWeight.w600,
            fontSize: fontSize != null ? fontSize : 16,
          ),
        ),
      ),
    );
  }
}
