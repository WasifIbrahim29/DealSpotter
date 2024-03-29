import 'dart:convert';

import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/models/comment_model.dart';
import 'package:deal_spotter/models/deals_model.dart';
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:deal_spotter/screens/deals_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

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
  Future<List<DealsModel>> deals;

  @override
  void initState() {
    super.initState();
    deals = getDeals();
  }

  Future<List<DealsModel>> getDeals() async {
    myDeals.clear();
    Provider.of<QueryProvider>(context, listen: false).myFilteredForums.clear();
    Provider.of<QueryProvider>(context, listen: false).myForums.clear();
    myComments.clear();
    var dealsUrl = "https://letitgo.shop/dealspotter/services/getDeals";
    var response = await http.get(Uri.parse(dealsUrl));
    print('Response status: ${response.statusCode}');
    print('Response bxxody: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var dealsList = data["dealsList"];
      for (int i = 0; i < dealsList.length; i++) {
        var deal = DealsModel.fromMap(dealsList[i]);
        myDeals.add(deal);
      }
      Provider.of<QueryProvider>(context, listen: false).addForum(myDeals);
    }

    for (int i = 0; i < myDeals.length; i++) {
      var commentsUrl =
          "https://letitgo.shop/dealspotter/services/getComments?memberId=${globals.user.memberId}&dealId=${myDeals[i].dealId}";
      print(commentsUrl);
      response = await http.get(Uri.parse(commentsUrl));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var status = data["status"];
        if (status == 1) {
          var comments = data["forumData"];
          print("myComments: $myComments");
          myComments.add(comments.length);
        } else {
          myComments.add(0);
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
                                'https://letitgo.shop/dealspotter/upload/deals/${Provider.of<QueryProvider>(context).myFilteredForums[index].deal_img}',
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
                            Provider.of<QueryProvider>(context)
                                .myFilteredForums[index]
                                .deal_title,
                            maxLines: 1,
                            style: TextStyle(color: primaryColor, fontSize: 20),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Html(
                              data: Provider.of<QueryProvider>(context)
                                  .myFilteredForums[index]
                                  .deal_description),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DealsDesc(
                                      dealsModel:
                                          Provider.of<QueryProvider>(context)
                                              .myFilteredForums[index],
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
                                  '\$${Provider.of<QueryProvider>(context).myFilteredForums[index].deal_price}',
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
                                            dealsModel:
                                                Provider.of<QueryProvider>(
                                                        context)
                                                    .myFilteredForums[index],
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
        itemCount: Provider.of<QueryProvider>(context).myFilteredForums.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: deals,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? ForumWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
