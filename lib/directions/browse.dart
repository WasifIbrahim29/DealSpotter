import 'dart:core';

import 'package:deal_spotter/browse_app_bars/categories_screen.dart';
import 'package:deal_spotter/browse_app_bars/stores_screen.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/constants.dart';
import 'package:flutter/material.dart';

class Browse extends StatelessWidget {
  const Browse({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          TopSearchBar(),
          SizedBox(
            height: 5,
            child: Container(
              color: Colors.white,
            ),
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: TabBar(
              labelPadding: EdgeInsets.zero,
              indicatorWeight: 4,
              labelColor: Colors.black,
              indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: primaryColor,
              tabs: [
                Tab(
                  child: Text(
                    'Stores',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                StoresScreen(),
                CategoriesScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
