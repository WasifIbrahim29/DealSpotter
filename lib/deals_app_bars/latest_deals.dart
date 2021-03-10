import 'dart:convert';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/deals_model.dart';
import 'package:deal_spotter/screens/deals_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deal_spotter/globals/globals.dart' as globals;

class LatestDeals extends StatefulWidget {
  const LatestDeals({
    Key key,
  }) : super(key: key);

  @override
  _LatestDealsState createState() => _LatestDealsState();
}

class _LatestDealsState extends State<LatestDeals> {
  List<DealsModel> myDeals = [];

  Future<List<DealsModel>> getDeals() async {
    myDeals.clear();
    var url = "https://letitgo.shop/dealspotter/services/getDeals";
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response bxxody: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var dealsList = data["dealsList"];
      for (int i = 0; i < dealsList.length; i++) {
        var deal = DealsModel.fromMap(dealsList[i]);
        myDeals.add(deal);
      }
      return myDeals;
    }
  }

  Widget DealWidget(List<DealsModel> deals) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            key: GlobalKey(),
            onTap: () async {
              var saveHistoryUrl =
                  "https://letitgo.shop/dealspotter/services/updateViews?memberId=${globals.user.memberId}&dealId=${myDeals[index].dealId}&type=deal";
              var response = await http.post(saveHistoryUrl);
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
                          myDeals[index].deal_title,
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
                            var saveVoucherCode =
                                "https://letitgo.shop/dealspotter/services/saveHistory?memberId=${globals.user.memberId}&dealId=${myDeals[index].dealId}&type=deal";
                            var response = await http.post(saveVoucherCode);
                            print(saveVoucherCode);
                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            if (response.statusCode == 200) {
                              var data = jsonDecode(response.body);
                              var status = data["status"];
                              if (status == "success") {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Deal Saved"),
                                ));
                                print("Deal saved");
                              }
                            }
                          },
                          child: Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
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
                ? DealWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
