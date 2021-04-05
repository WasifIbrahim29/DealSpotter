import 'dart:convert';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deal_spotter/models/notification_model.dart';
import 'package:provider/provider.dart';

class NotificationTab extends StatefulWidget {
  NotificationTab({
    Key key,
  }) : super(key: key);

  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  void initState() {
    super.initState();
    noti = getNotificationTabList();
  }

  Future<int> noti;

  List<NotificationModel> myNotifications = [];

  Future<int> getNotificationTabList() async {
    myNotifications.clear();
    Provider.of<QueryProvider>(context, listen: false)
        .myFilteredNotifications
        .clear();

    Provider.of<QueryProvider>(context, listen: false).myNotifications.clear();
    var notificationUrl =
        'https://letitgo.shop/dealspotter/services/getNotifications?memberId=${globals.user.memberId}';

    var response = await http.get(Uri.parse(notificationUrl));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var status = data["status"];
      if (status == 1) {
        var notificationsList = data["notifications"];
        for (int i = 0; i < notificationsList.length; i++) {
          var notification = NotificationModel.fromMap(notificationsList[i]);
          myNotifications.add(notification);
        }
        Provider.of<QueryProvider>(context, listen: false)
            .addNotification(myNotifications);
      }
    }
    print(myNotifications);
    return 1;
  }

  Widget notificationTabWidget() {
    return Provider.of<QueryProvider>(context).myNotifications.length < 1
        ? Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off_outlined,
                  color: primaryColor,
                  size: 85,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No Notifications",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                )
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 1),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  Provider.of<QueryProvider>(context)
                                      .myFilteredNotifications[index]
                                      .type,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  Provider.of<QueryProvider>(context)
                                      .myFilteredNotifications[index]
                                      .description,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: Provider.of<QueryProvider>(context)
                        .myFilteredNotifications
                        .length,
                  ),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: noti,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? notificationTabWidget()
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
