import 'dart:core';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/directions/deals.dart';
import 'package:deal_spotter/components/white_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:deal_spotter/directions/profile.dart';
import 'package:deal_spotter/directions/browse.dart';
import 'package:deal_spotter/directions/alerts.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      Deals(),
      Browse(),
      Text('Forum'),
      Alerts(),
      Profile(),
    ];

    return SafeArea(
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: kDestinationItems,
        ),
      ),
    );
  }
}
