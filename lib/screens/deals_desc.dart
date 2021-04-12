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
import 'package:deal_spotter/widgets/CommentWidget.dart';

class DealsDesc extends StatefulWidget {
  DealsModel dealsModel;

  DealsDesc({this.dealsModel});

  @override
  _DealsDescState createState() => _DealsDescState();
}

class _DealsDescState extends State<DealsDesc> {
  final snackBarKey = GlobalKey<ScaffoldState>();

  final snackBar = SnackBar(content: Text('Invalid Credentials!'));
  TextEditingController commentController = new TextEditingController();

  List<CommentModel> myComments = [];
  String image;

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

    print("deals id : ${widget.dealsModel.dealId}");
    print("deals desc : ${widget.dealsModel.deal_description}");
  }

  Future<List<CommentModel>> getComments() async {
    myComments.clear();
    var commentsUrl =
        "https://letitgo.shop/dealspotter/services/getComments?memberId=${globals.user.memberId}&dealId=${widget.dealsModel.dealId}";
    var response = await http.get(Uri.parse(commentsUrl));
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
            myComments.add(comment);
          }
        } catch (e) {
          print(e);
        }
      }
    }
    //print("Comments length: ${myComments.length}");
    return myComments;
  }

  Widget DealAndCommentsWidget(List<CommentModel> comments) {
    print("Comments length: ${comments.length}");
    return SafeArea(
      child: Scaffold(
        key: snackBarKey,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TopSearchBar(),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(13),
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://letitgo.shop/dealspotter/upload/deals/${widget.dealsModel.deal_img}',
                            scale: 1.8,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${widget.dealsModel.deal_price}\$",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.dealsModel.deal_title,
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                          Html(
                            data: "${widget.dealsModel.deal_description}",
                            onLinkTap: (url) async {
                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                );
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlueButton(
                            title: 'Get Deal',
                            colour: Colors.white,
                            onPressed: () {
                              _launchURL(widget.dealsModel.deal_url);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CommentWidget(
                commentController: commentController,
                widget: widget,
                image: image,
                context: context,
                myComments: comments,
                dealsModel: widget.dealsModel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getComments(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? DealAndCommentsWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
