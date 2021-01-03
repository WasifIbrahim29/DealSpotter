import 'dart:core';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/deals_app_bars/voucher_codes.dart';
import 'package:deal_spotter/deals_app_bars/latest_deals.dart';
import 'package:deal_spotter/directions/deals.dart';

class Deals extends StatelessWidget {
  const Deals({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          TopSearchBar(),
          Container(
            height: 30,
            color: primaryColor,
            child: TabBar(
              labelPadding: EdgeInsets.zero,
              indicatorWeight: 4,
              indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: AutoSizeText(
                    'Voucher Codes',
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    'Latest Deals',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    'Forum',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 11,
            color: primaryColor,
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                VoucherCodes(),
                LatestDeals(),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
