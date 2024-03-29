import 'dart:core';

import 'package:deal_spotter/browse_app_bars/categories_screen.dart';
import 'package:deal_spotter/browse_app_bars/stores_screen.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/deals_app_bars/forum.dart';
import 'package:flutter/material.dart';

class ForumDirection extends StatelessWidget {
  int currentIndex;
  int tabIndex;

  ForumDirection({
    Key key,
    this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopSearchBar(
          directionIndex: currentIndex,
        ),
        Expanded(child: Forum()),
      ],
    );
  }
}
