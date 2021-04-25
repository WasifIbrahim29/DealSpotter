import 'dart:convert';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/deals_model.dart';
import 'package:deal_spotter/models/deals_saved_model.dart';
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:deal_spotter/screens/deals_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:provider/provider.dart';

class LatestDeals extends StatefulWidget {
  String storeId;
  String categoryId;
  LatestDeals({
    Key key,
    this.storeId,
    this.categoryId,
  });

  @override
  _LatestDealsState createState() => _LatestDealsState();
}

class _LatestDealsState extends State<LatestDeals> {
  List<DealsModel> myDeals = [];
  Future<List<DealsModel>> deals;
  MaterialColor iconColor;
  bool colorFlag = false;
  List savedIds = [];

  List<DealsSavedModel> mySavedDeals = [];

  @override
  void initState() {
    super.initState();
    getBothDeals();
  }

  void getBothDeals() async {
    await getSavedDealsList();
    print("golden boi");
    setState(() {
      deals = getDeals();
    });
  }

  Future<int> getSavedDealsList() async {
    mySavedDeals.clear();

    var dealsUrl =
        'https://letitgo.shop/dealspotter/services/getSavedDeals?memberId=${globals.user.memberId}';

    var response = await http.get(Uri.parse(dealsUrl));
    print("memberid ${globals.user.memberId}");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == 1) {
        var latestDealsList = data["savedDeals"];
        for (int i = 0; i < latestDealsList.length; i++) {
          var deal = DealsSavedModel.fromMap(latestDealsList[i]);
          savedIds.add(deal.dealId);
          mySavedDeals.add(deal);
        }
      }
    }

    print("SavedDeals: $mySavedDeals");
    return 1;
  }

  Future<List<DealsModel>> getDeals() async {
    myDeals.clear();
    Provider.of<QueryProvider>(context, listen: false)
        .myFilteredLatestDeals
        .clear();
    Provider.of<QueryProvider>(context, listen: false).myLatestDeals.clear();
    var url;
    print("shit man");
    if (widget.storeId != null) {
      url =
          "https://letitgo.shop/dealspotter/services/getDeals?storeId=${widget.storeId}";
    } else if (widget.categoryId != null) {
      url =
          "https://letitgo.shop/dealspotter/services/getDeals?categoryId=${widget.categoryId}";
    } else {
      url = "https://letitgo.shop/dealspotter/services/getDeals";
    }

    print("url: $url");

    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == 1) {
        var dealsList = data["dealsList"];
        for (int i = 0; i < dealsList.length; i++) {
          var deal = DealsModel.fromMap(dealsList[i]);
          if (savedIds.contains(deal.dealId)) {
            deal.is_saved = true;
          }
          myDeals.add(deal);
        }
        Provider.of<QueryProvider>(context, listen: false)
            .addLatestDeal(myDeals);
        return myDeals;
      } else {
        return myDeals;
      }
    }
  }

  Widget DealWidget(List<DealsModel> deals) {
    return Provider.of<QueryProvider>(context).myFilteredLatestDeals.length < 1
        ? Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No deal found",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                )
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 5),
            child: ListView.builder(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
              itemBuilder: (BuildContext ctxt, int index) {
                return GestureDetector(
                  key: GlobalKey(),
                  onTap: () async {
                    var saveHistoryUrl =
                        "https://letitgo.shop/dealspotter/services/updateViews?memberId=${globals.user.memberId}&dealId=${myDeals[index].dealId}&type=deal";
                    var response = await http.post(Uri.parse(saveHistoryUrl));
                    print(saveHistoryUrl);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');
                    if (response.statusCode == 200) {
                      var data = jsonDecode(response.body);
                      var status = data["status"];
                      if (status == 1) {
                        print("Deal added into history successfully!");
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DealsDesc(
                          dealsModel: myDeals[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
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
                              child: Image(
                                image: NetworkImage(
                                    'https://letitgo.shop/dealspotter/upload/deals/${myDeals[index].deal_img}',
                                    scale: 0.5),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                Provider.of<QueryProvider>(context)
                                    .myFilteredLatestDeals[index]
                                    .deal_title,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  onTap: () async {
                                    if (myDeals[index].is_saved == true) {
                                      var removeDeal =
                                          "https://letitgo.shop/dealspotter/services/removeFavourite?memberId=${globals.user.memberId}&dealId=${myDeals[index].dealId}&type=deal";
                                      var response = await http
                                          .post(Uri.parse(removeDeal));
                                      print(removeDeal);
                                      print(
                                          'Response status: ${response.statusCode}');
                                      print('Response body: ${response.body}');
                                      if (response.statusCode == 200) {
                                        var data = jsonDecode(response.body);
                                        var status = data["status"];
                                        if (status == "success") {
                                          setState(() {
                                            myDeals[index].is_saved = false;
                                          });
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Deal removed from favourites successfully."),
                                          ));
                                          print(
                                              "Deal removed from favourite successfully.");
                                        }
                                      }
                                    } else {
                                      var saveDeal =
                                          "https://letitgo.shop/dealspotter/services/saveHistory?memberId=${globals.user.memberId}&dealId=${myDeals[index].dealId}&type=deal";
                                      var response =
                                          await http.post(Uri.parse(saveDeal));
                                      print(saveDeal);
                                      print(
                                          'Response status: ${response.statusCode}');
                                      print('Response body: ${response.body}');
                                      if (response.statusCode == 200) {
                                        var data = jsonDecode(response.body);
                                        var status = data["status"];
                                        if (status == "success") {
                                          setState(() {
                                            myDeals[index].is_saved = true;
                                          });
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Deal added to favourites successfully."),
                                          ));
                                          print("Deal saved");
                                        }
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: myDeals[index].is_saved == true
                                        ? Colors.red
                                        : Colors.grey,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: Provider.of<QueryProvider>(context)
                  .myFilteredLatestDeals
                  .length,
            ),
          );
  }

  MaterialColor dealAlreadySaved(String dealId) {
    print("I am here again");
    for (DealsSavedModel deal in mySavedDeals) {
      if (deal.dealId == dealId) {
        return Colors.red;
      }
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: deals,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? DealWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
