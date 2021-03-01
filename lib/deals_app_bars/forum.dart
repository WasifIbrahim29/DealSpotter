import 'dart:convert';

import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/models/comment_model.dart';
import 'package:deal_spotter/models/deals_model.dart';
import 'package:deal_spotter/screens/deals_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

class Forum extends StatefulWidget {
  const Forum({
    Key key,
  }) : super(key: key);

  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  List<DealsModel> myDeals = [];
  List<int> myComments = [];

  Future<List<DealsModel>> getDeals() async {
    myDeals.clear();
    myComments.clear();
    var dealsUrl = "https://letitgo.shop/dealspotter/services/getDeals";
    var response = await http.get(dealsUrl);
    print('Response status: ${response.statusCode}');
    print('Response bxxody: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var dealsList = data["dealsList"];
      for (int i = 0; i < dealsList.length; i++) {
        var deal = DealsModel.fromMap(dealsList[i]);
        myDeals.add(deal);
      }
    }

    for (int i = 0; i < myDeals.length; i++) {
      var commentsUrl =
          "https://letitgo.shop/dealspotter/services/getComments?memberId=${globals.user.memberId}&dealId=${myDeals[i].dealId}";
      response = await http.get(commentsUrl);
      print('Response status: ${response.statusCode}');
      print('Response bxxody: ${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var status = data["status"];
        if (status == 1) {
          data = jsonDecode(response.body);
          var comments = data["forumData"];
          print(myComments);
          myComments.add(comments.length);
        }
      }
    }

    return myDeals;
  }

  Widget ForumWidget(List<DealsModel> deals) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://letitgo.shop/dealspotter/upload/deals/${myDeals[index].deal_img}',
                                scale: 0.5),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.comment,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${myComments[index]} comments",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myDeals[index].deal_title,
                            maxLines: 1,
                            style: TextStyle(color: primaryColor, fontSize: 20),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Html(
                            data: myDeals[index]
                                    .deal_description
                                    .substring(28, 70) +
                                "...",
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DealsDesc(
                                      dealsModel: myDeals[index],
                                    ),
                                  ));
                            },
                            child: Text(
                              'See more',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.blue[600], fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '\$${myDeals[index].deal_price}',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: BlueButton(
                                  height: 3,
                                  fontSize: 11,
                                  maxLines: 1,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DealsDesc(
                                            dealsModel: myDeals[index],
                                          ),
                                        ));
                                  },
                                  title: "See Deal",
                                  colour: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: myDeals.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getDeals(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? ForumWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
