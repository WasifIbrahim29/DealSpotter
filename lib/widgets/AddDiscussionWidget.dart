import 'package:deal_spotter/components/white_button.dart';
import 'package:deal_spotter/models/comment_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/deals_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:deal_spotter/widgets/ReplyWidget.dart';
import 'package:deal_spotter/screens/deals_desc.dart';

class DiscussionWidget extends StatefulWidget {
  DiscussionWidget({
    Key key,
  });

  @override
  _DiscussionWidgetState createState() => _DiscussionWidgetState();
}

class _DiscussionWidgetState extends State<DiscussionWidget> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    "Add New Discussion",
                    maxLines: 1,
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Subject',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: subjectController,
                            cursorColor: Colors.black,
                            decoration: kCommentDecoration.copyWith(
                                hintText:
                                    "Enter Title/Subject of Your Question"),
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Question',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: questionController,
                            cursorColor: Colors.black,
                            decoration: kCommentDecoration.copyWith(
                                hintText:
                                    "Explain detail brief of your quesiton"),
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          BlueButton(
                            onPressed: () async {
                              var discussionUrl =
                                  "https://letitgo.shop/dealspotter/services/addDiscussion?memberId=${globals.user.memberId}&subject=${subjectController.text}&question=${questionController.text}";
                              var response =
                                  await http.post(Uri.parse(discussionUrl));
                              print(discussionUrl);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');
                              if (response.statusCode == 200) {
                                print("discussion added");
                              }

                              Navigator.pop(context);
                            },
                            colour: Colors.white,
                            title: "Submit",
                            fontSize: 20,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
