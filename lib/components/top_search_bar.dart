import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';

class TopSearchBar extends StatelessWidget {
  const TopSearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.ac_unit,
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: TextField(
                style: TextStyle(
                  backgroundColor: Colors.white,
                ),
                textAlign: TextAlign.start,
                decoration: kSearchBarDecoration.copyWith(hintText: 'Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
