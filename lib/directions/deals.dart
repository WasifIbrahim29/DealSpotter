import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/deals_app_bars/forum.dart';
import 'package:deal_spotter/deals_app_bars/latest_deals.dart';
import 'package:deal_spotter/deals_app_bars/voucher_codes.dart';
import 'package:flutter/material.dart';

class Deals extends StatefulWidget {
  String storeId;
  int currentIndex;
  String categoryId;

  Deals({
    Key key,
    this.storeId,
    this.currentIndex,
    this.categoryId,
  }) : super(key: key);

  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            children: <Widget>[
              TopSearchBar(
                  directionIndex: widget.currentIndex, tabIndex: tabIndex),
              Container(
                height: 30,
                color: primaryColor,
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  indicatorWeight: 4,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.white,
                  onTap: (index) {
                    print("tabIndex: $tabIndex");
                    setState(() {
                      tabIndex = index;
                    });
                  },
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
                    VoucherCodes(
                      storeId: widget.storeId,
                      categoryId: widget.categoryId,
                    ),
                    LatestDeals(
                      storeId: widget.storeId,
                      categoryId: widget.categoryId,
                    ),
                    Forum(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
