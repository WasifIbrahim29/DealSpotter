import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/profile_tabs/history.dart';
import 'package:deal_spotter/profile_tabs/saved.dart';
import 'package:deal_spotter/screens/edit_profile.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({
    Key key,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final snackBarKey = GlobalKey<ScaffoldState>();
  String _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (globals.user.user_image == "") {
      _image = null;
    } else {
      _image =
          "https://letitgo.shop/dealspotter/upload/userImage/${globals.user.user_image}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackBarKey,
      body: DefaultTabController(
        length: 4,
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
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: primaryColor,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  _image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.grey[800],
                                ),
                              ),
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
                              globals.user.username,
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
                                _navigateAndDisplaySelection(context);
                              },
                              elevation: 5,
                              color: Colors.white,
                              minWidth: 150,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  side: BorderSide(
                                      color: primaryColor, width: 2)),
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
                  SavedTab(),
                  HistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfileScreen()));

    if (result == "Profile updated successfully") {
      print(result);
      setState(() {
        _image = globals.user.user_image;
      });

      snackBarKey.currentState.showSnackBar(SnackBar(content: Text("$result")));
    }
  }
}
