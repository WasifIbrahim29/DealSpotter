import 'package:deal_spotter/components/white_button.dart';
import 'package:deal_spotter/models/comment_model.dart';
import 'package:deal_spotter/models/discussion_answer_model.dart';
import 'package:deal_spotter/models/discussion_model.dart';
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

class SingleDiscussionWidget extends StatefulWidget {
  SingleDiscussionWidget({
    Key key,
    this.discussionId,
  });

  final String discussionId;

  @override
  _SingleDiscussionWidgetState createState() => _SingleDiscussionWidgetState();
}

class _SingleDiscussionWidgetState extends State<SingleDiscussionWidget> {
  String image;

  TextEditingController commentController = TextEditingController();

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

  DiscussionModel singleQuestion = DiscussionModel();
  List<DiscussionAnswerModel> myDiscussionAnswers = [];

  Future<List<DiscussionAnswerModel>> getSingleDiscussion() async {
    myDiscussionAnswers.clear();
    print(widget.discussionId);
    var singleDiscussionUrl =
        "https://letitgo.shop/dealspotter/services/viewSingleDiscussion?discussionId=${widget.discussionId}";
    var response = await http.get(singleDiscussionUrl);
    print(singleDiscussionUrl);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var status = data["status"];
      if (status == 1) {
        try {
          data = jsonDecode(response.body);
          var disc = data["response"];
          var single_question = disc["single_question"];
          singleQuestion = DiscussionModel.fromMap(single_question);
          print("singleQuestion: $singleQuestion");

          var discussion_answers = disc["discussion_answers"];

          for (int i = 0; i < discussion_answers.length; i++) {
            var discussionAnswer =
                DiscussionAnswerModel.fromMap(discussion_answers[i]);
            myDiscussionAnswers.add(discussionAnswer);
          }
          print(myDiscussionAnswers);
        } catch (e) {
          print(e);
        }
      }
    }
    //print("Comments length: ${myComments.length}");
    return myDiscussionAnswers;
  }

  Widget DiscussionWidget() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Qestion",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${singleQuestion.question}",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Answers",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            myDiscussionAnswers.length > 0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 20),
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(5),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myDiscussionAnswers[index].answer,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
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
                                                      BorderRadius.circular(
                                                          50)),
                                              width: 100,
                                              height: 100,
                                              child: Icon(
                                                Icons.supervised_user_circle,
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
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: myDiscussionAnswers.length,
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'No Discussion Found',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: commentController,
                    cursorColor: Colors.black,
                    decoration: kCommentDecoration,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlueButton(
                    onPressed: () async {
                      var replyUrl =
                          "https://letitgo.shop/dealspotter/services/addAnswer?question_id=${singleQuestion.id}&memberId=${globals.user.memberId}&answer=${commentController.text}";
                      var response = await http.post(replyUrl);
                      print(replyUrl);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      if (response.statusCode == 200) {
                        var data = jsonDecode(response.body);
                        var status = data["status"];
                        if (status == "success") {
                          setState(() {
                            commentController.text = "";
                            myDiscussionAnswers.clear();
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    print("here man");
    return Scaffold(
      body: FutureBuilder(
          future: getSingleDiscussion(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? DiscussionWidget()
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
