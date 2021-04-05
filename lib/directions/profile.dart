import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/profile_tabs/history.dart';
import 'package:deal_spotter/profile_tabs/notification.dart';
import 'package:deal_spotter/profile_tabs/saved.dart';
import 'package:deal_spotter/screens/edit_profile.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  int currentIndex;

  Profile({
    Key key,
    this.currentIndex,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final snackBarKey = GlobalKey<ScaffoldState>();
  String _image;
  int tabIndex = 0;

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
        length: 3,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
            TopSearchBar(
                directionIndex: widget.currentIndex, tabIndex: tabIndex),
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
                                  Icons.person,
                                  size: 60,
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
                    onTap: (index) {
                      setState(() {
                        tabIndex = index;
                      });
                    },
                    tabs: [
                      Tab(
                        child: Text(
                          'Notifications',
                          maxLines: 1,
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
                  NotificationTab(),
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
