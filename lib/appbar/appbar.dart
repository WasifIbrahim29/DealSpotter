import 'package:deal_spotter/constants.dart';
import 'package:flutter/material.dart';

class MyAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight+20);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      alignment: Alignment.center,
      child: Image.asset(
        'images/icon.png',
        height: 100,
        width: 100,
      ),
    );
  }
}
