import 'dart:convert';

import 'package:deal_spotter/directions/deals.dart';
import 'package:deal_spotter/directions/discussion.dart';
import 'package:deal_spotter/models/discussion_model.dart';
import 'package:deal_spotter/models/stores_model.dart';
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:deal_spotter/widgets/SingleDiscussionWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/constants.dart';
import 'package:provider/provider.dart';

class NewDiscussionScreen extends StatefulWidget {
  const NewDiscussionScreen({
    Key key,
  }) : super(key: key);

  @override
  _NewDiscussionScreenState createState() => _NewDiscussionScreenState();
}

class _NewDiscussionScreenState extends State<NewDiscussionScreen> {
  String image;
  List<DiscussionModel> myDiscussions = [];
  Future<int> noti;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (globals.user.user_image == "") {
      print(globals.user.user_image);
      image = null;
    } else {
      image =
          "https://letitgo.shop/dealspotter/upload/userImage/${globals.user.user_image}";
    }
    noti = getNewDiscussions();
  }

  Future<int> getNewDiscussions() async {
    myDiscussions.clear();
    Provider.of<QueryProvider>(context, listen: false)
        .myFilteredNewDiscussion
        .clear();
    Provider.of<QueryProvider>(context, listen: false).myNewDiscussion.clear();
    print("wtf");
    var url = "https://letitgo.shop/dealspotter/services/listAllDiscussion";
    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var discussion = data["response"];
      var newDiscussions = discussion["new_discussions"];
      for (int i = 0; i < newDiscussions.length; i++) {
        var disc = DiscussionModel.fromMap(newDiscussions[i]);
        myDiscussions.add(disc);
      }
      Provider.of<QueryProvider>(context, listen: false)
          .addNewDiscussion(myDiscussions);
      print(myDiscussions);
      return 1;
    }
  }

  Widget DiscussionWidget() {
    return Provider.of<QueryProvider>(context).myNewDiscussion.length > 0
        ? Container(
            margin: EdgeInsets.only(top: 5),
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              itemBuilder: (BuildContext ctxt, int index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bx) {
                        return SafeArea(
                          child: SingleDiscussionWidget(
                            discussionId: Provider.of<QueryProvider>(context)
                                .myFilteredNewDiscussion[index]
                                .id,
                          ),
                        );
                      },
                    );
                  },
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Provider.of<QueryProvider>(context)
                                    .myFilteredNewDiscussion[index]
                                    .subject,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  Provider.of<QueryProvider>(context)
                                      .myFilteredNewDiscussion[index]
                                      .question,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: primaryColor,
                                    child: image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              image,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: 100,
                                            height: 100,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    globals.user.username,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                );
              },
              itemCount: Provider.of<QueryProvider>(context)
                  .myFilteredNewDiscussion
                  .length,
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    'No New Discussions',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
                ? DiscussionWidget()
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
