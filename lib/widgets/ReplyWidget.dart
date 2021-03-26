import 'dart:convert';

import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/components/white_button.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/models/comment_model.dart';
import 'package:deal_spotter/models/deals_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:deal_spotter/screens/deals_desc.dart';
import 'package:deal_spotter/models/reply_model.dart';

import '../constants.dart';

class ReplyWidget extends StatefulWidget {
  ReplyWidget({Key key, @required this.context, this.commId, this.dealId});

  final BuildContext context;
  final String commId;
  final String dealId;

  @override
  _ReplyWidgetState createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  TextEditingController replyController = TextEditingController();
  String image;
  List<ReplyModel> myReplies = [];

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
  }

  Future<List<ReplyModel>> getReplies() async {
    myReplies.clear();
    print("here bro");
    var repliesUrl =
        "https://letitgo.shop/dealspotter/services/getCommentReply?commId=${widget.commId}";
    var response = await http.get(Uri.parse(repliesUrl));
    print(repliesUrl);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var status = data["status"];
      if (status == 1) {
        try {
          data = jsonDecode(response.body);
          var repliesList = data["replyData"];
          for (int i = 0; i < repliesList.length; i++) {
            var reply = ReplyModel.fromMap(repliesList[i]);
            myReplies.add(reply);
          }
        } catch (e) {
          print(e);
        }
      }
    }
    //print("Comments length: ${myComments.length}");
    myReplies = myReplies.reversed.toList();
    return myReplies;
  }

  @override
  Widget build(context) {
    print("here man");
    return Scaffold(
      body: FutureBuilder(
          future: getReplies(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? RepliesWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }

  @override
  Widget RepliesWidget(List<ReplyModel> myReplies) {
    print(myReplies.length);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[400],
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: replyController,
                    cursorColor: Colors.black,
                    decoration: kReplyDecoration,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlueButton(
                    onPressed: () async {
                      var replyUrl =
                          "https://letitgo.shop/dealspotter/services/savecommentReply?memberId=${globals.user.memberId}&dealId=${widget.dealId}&commId=${widget.commId}&comment=${replyController.text}";
                      var response = await http.post(Uri.parse(replyUrl));
                      print(replyUrl);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      if (response.statusCode == 200) {
                        var data = jsonDecode(response.body);
                        var status = data["status"];
                        if (status == "success") {
                          setState(() {
                            replyController.text = "";
                            myReplies.clear();
                          });
                        }
                      }
                    },
                    colour: Colors.white,
                    title: "Send",
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
              itemBuilder: (BuildContext ctxt, int index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: primaryColor,
                                child: image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
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
                                          Icons.supervised_user_circle,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                globals.user.username,
                                maxLines: 1,
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 8,
                      child: Card(
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
                              children: [
                                Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    myReplies[index].comment,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          myReplies[index].dated,
                                          maxLines: 1,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: myReplies.length,
            ),
          ],
        ),
      ),
    );
  }
}
