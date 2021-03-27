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
      height: 100,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
        child: Row(
          children: <Widget>[
            Image.asset(
              'images/icon.png',
              height: 100,
              width: 100,
            ),
            SizedBox(
              width: 1,
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
