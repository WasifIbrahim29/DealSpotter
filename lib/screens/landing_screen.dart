import 'dart:core';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/deals_app_bars/forum.dart';
import 'package:deal_spotter/directions/ForumDirection.dart';
import 'package:deal_spotter/directions/alerts.dart';
import 'package:deal_spotter/directions/browse.dart';
import 'package:deal_spotter/directions/deals.dart';
import 'package:deal_spotter/directions/discussion.dart';
import 'package:deal_spotter/directions/profile.dart';
import 'package:flutter/material.dart';

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
      ForumDirection(),
      Alerts(),
      Profile(),
      Discussion(),
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
