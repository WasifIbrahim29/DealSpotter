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

class CommentWidget extends StatefulWidget {
  CommentWidget({
    Key key,
    @required this.commentController,
    @required this.widget,
    @required this.image,
    @required this.myComments,
    @required this.context,
    this.dealsModel,
  });

  final TextEditingController commentController;
  final DealsDesc widget;
  final String image;
  final BuildContext context;
  final List<CommentModel> myComments;
  final DealsModel dealsModel;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  Future<List<CommentModel>> getComments() async {
    widget.myComments.clear();
    var commentsUrl =
        "https://letitgo.shop/dealspotter/services/getComments?memberId=${globals.user.memberId}&dealId=${widget.widget.dealsModel.dealId}";
    var response = await http.get(commentsUrl);
    print(commentsUrl);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var status = data["status"];
      if (status == 1) {
        try {
          data = jsonDecode(response.body);
          var commentsList = data["forumData"];
          for (int i = 0; i < commentsList.length; i++) {
            var comment = CommentModel.fromMap(commentsList[i]);
            widget.myComments.add(comment);
          }
        } catch (e) {
          print(e);
        }
      }
    }
    //print("Comments length: ${myComments.length}");
    return widget.myComments;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.myComments.length);
    return Container(
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
                  controller: widget.commentController,
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
                    var commentsUrl =
                        "https://letitgo.shop/dealspotter/services/saveComment?memberId=${globals.user.memberId}&dealId=${widget.widget.dealsModel.dealId}&comment=${widget.commentController.text}";
                    var response = await http.post(commentsUrl);
                    print(commentsUrl);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');
                    if (response.statusCode == 200) {
                      var data = jsonDecode(response.body);
                      var status = data["status"];
                      if (status == 1) {
                        setState(() async {
                          widget.commentController.text = "";
                          widget.myComments.clear();
                          await getComments();
                          setState(() {});
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
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
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
                              child: widget.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        widget.image,
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
                                  widget.myComments[index].comment,
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
                                      child: WhiteButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext bx) {
                                              return SafeArea(
                                                child: ReplyWidget(
                                                  context: context,
                                                  commId: widget
                                                      .myComments[index].commId,
                                                  dealId: widget
                                                      .widget.dealsModel.dealId,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        title: "Reply",
                                        colour: Colors.black,
                                        height: 22,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.myComments[index].dated,
                                        maxLines: 1,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
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
            itemCount: widget.myComments.length,
          ),
        ],
      ),
    );
  }
}
