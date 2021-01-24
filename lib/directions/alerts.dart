import 'dart:core';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/browse_app_bars/stores_screen.dart';
import 'package:deal_spotter/directions/deals.dart';
import 'package:deal_spotter/components/white_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:deal_spotter/directions/profile.dart';
import 'package:deal_spotter/deals_app_bars/voucher_codes.dart';
import 'package:deal_spotter/models/deal_alerts_model.dart';
import 'package:deal_spotter/models/list_tiles_model.dart';
import 'package:deal_spotter/Bodies/AlertsBody.dart';

class Alerts extends StatelessWidget {
  const Alerts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopSearchBar(),
        Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: <Widget>[
              Text(
                'Create a Deal Alert',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Create a deal alert below, so you never miss the deals you care about the most',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  height: 45,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      backgroundColor: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                    decoration: kTextFieldDecoration.copyWith(
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Add keywords, Store, Category, Brand"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: BlueButton(
                  colour: Colors.white,
                  title: "Create",
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
        AlertsBody(),
      ],
    );
  }
}
