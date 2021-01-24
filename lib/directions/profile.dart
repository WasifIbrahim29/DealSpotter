import 'dart:core';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/directions/deals.dart';
import 'package:deal_spotter/components/white_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:deal_spotter/screens/edit_profile.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          TopSearchBar(),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 140,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Login Name',
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "10 reputation points",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.assignment,
                                size: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "L1: Learner",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen()));
                            },
                            elevation: 5,
                            color: Colors.white,
                            minWidth: 150,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side:
                                    BorderSide(color: primaryColor, width: 2)),
                            height: 30.0,
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 12, top: 12),
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  indicatorWeight: 2,
                  labelColor: primaryColor,
                  unselectedLabelColor: Colors.black,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                      child: Text(
                        'Notifications',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: AutoSizeText(
                        'Message',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: AutoSizeText(
                        'Activity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: AutoSizeText(
                        'Saved',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: AutoSizeText(
                        'History',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.notifications_off,
                      size: 100,
                      color: primaryColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'No Notifications',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You haven\'t received any notifications yet',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
