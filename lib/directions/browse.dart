import 'dart:core';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/browse_app_bars/stores.dart';
import 'package:deal_spotter/directions/deals.dart';
import 'package:deal_spotter/components/white_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:deal_spotter/directions/profile.dart';
import 'package:deal_spotter/deals_app_bars/voucher_codes.dart';

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
                Stores(),
                Icon(Icons.directions_transit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
