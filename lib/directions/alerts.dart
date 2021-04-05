import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/brand_model.dart';
import 'package:deal_spotter/models/categories_model.dart';
import 'package:deal_spotter/models/deal_alerts_model.dart';
import 'package:deal_spotter/models/stores_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deal_spotter/globals/globals.dart' as globals;

class Alerts extends StatefulWidget {
  Alerts({
    Key key,
  }) : super(key: key);

  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  TextEditingController searchController = TextEditingController();
  List<DealALertsModel> myAlerts = [];
  List<DealALertsModel> filteredMyAlerts = [];
  Future<List<DealALertsModel>> alertInitialization;

  Future<List<DealALertsModel>> getAlerts() async {
    print("alerts here");
    myAlerts.clear();
    var url = "https://letitgo.shop/dealspotter/services/getBrands";
    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var brandsList = data["brandsList"];
      for (int i = 0; i < brandsList.length; i++) {
        var brand = BrandModel.fromMap(brandsList[i]);
        var url =
            "https://letitgo.shop/dealspotter/services/updateAlertSubscription?memberId=${globals.user.memberId}&subscriptionId=${brand.id}&subscriptionType=brand&subscribed_status=1";
        var response = await http.get(Uri.parse(url));
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data["status"] == "success") {
            brand.isSubscribed = true;
          } else {
            brand.isSubscribed = false;
          }
        }
        myAlerts.add(brand);
        filteredMyAlerts.add(brand);
      }
    }

    url = "https://letitgo.shop/dealspotter/services/getStores";
    response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var storesList = data["storesList"];
      for (int i = 0; i < storesList.length; i++) {
        var store = StoresModel.fromMap(storesList[i]);
        var url =
            "https://letitgo.shop/dealspotter/services/updateAlertSubscription?memberId=${globals.user.memberId}&subscriptionId=${store.id}&subscriptionType=brand&subscribed_status=1";
        var response = await http.get(Uri.parse(url));
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data["status"] == "success") {
            store.isSubscribed = true;
          } else {
            store.isSubscribed = false;
          }
        }
        myAlerts.add(store);
        filteredMyAlerts.add(store);
      }
    }

    url = "https://letitgo.shop/dealspotter/services/getCategories";
    response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var categoriesList = data["categoryList"];
      for (int i = 0; i < categoriesList.length; i++) {
        var category = CategoriesModel.fromMap(categoriesList[i]);
        var url =
            "https://letitgo.shop/dealspotter/services/updateAlertSubscription?memberId=${globals.user.memberId}&subscriptionId=${category.id}&subscriptionType=brand&subscribed_status=1";
        var response = await http.get(Uri.parse(url));
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data["status"] == "success") {
            category.isSubscribed = true;
          } else {
            category.isSubscribed = false;
          }
        }
        myAlerts.add(category);
        filteredMyAlerts.add(category);
      }
    }
    print(myAlerts);
    return myAlerts;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alertInitialization = getAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          height: 80,
          alignment: Alignment.center,
          color: primaryColor,
          child: Image.asset(
            'images/icon.png',
            height: 100,
            width: 100,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
          child: Column(
            children: <Widget>[
              Text(
                'Create a Deal Alert',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Create a deal alert below, so you never miss the deals you care about the most',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  height: 45,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (text) {
                      filteredMyAlerts.clear();
                      myAlerts.forEach((element) {
                        if (element.name
                            .toLowerCase()
                            .contains(text.toLowerCase())) {
                          filteredMyAlerts.add(element);
                        }
                      });

                      setState(() {});
                    },
                    cursorColor: Colors.black,
                    style: TextStyle(
                      backgroundColor: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                    controller: searchController,
                    decoration: kTextFieldDecoration.copyWith(
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: "Add keywords, Store, Category, Brand"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: BlueButton(
                  colour: Colors.white,
                  title: "Create",
                  onPressed: () async {
                    filteredMyAlerts.clear();
                    myAlerts.forEach((element) {
                      if (element.name.contains(searchController.text)) {
                        filteredMyAlerts.add(element);
                      }
                    });

                    setState(() {});
                  },
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: alertInitialization,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? alertsWidget()
                : Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  Widget alertsWidget() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 0),
        child: GridView.builder(
          itemBuilder: (BuildContext ctxt, int index) {
            return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 13,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Text(
                                filteredMyAlerts[index].name,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Icon(
                                Icons.accessibility_new,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () async {
                          String type = checkType(index);

                          if (filteredMyAlerts[index].isSubscribed) {
                            var removeSub =
                                "https://letitgo.shop/dealspotter/services/updateAlertSubscription?memberId=${globals.user.memberId}&subscriptionId=${filteredMyAlerts[index].id}&subscriptionType=$type&subscribed_status=0";
                            var response =
                                await http.post(Uri.parse(removeSub));
                            print(removeSub);
                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            if (response.statusCode == 200) {
                              var data = jsonDecode(response.body);
                              var status = data["status"];
                              if (status == "success") {
                                final snackBar = SnackBar(
                                    content: Text(
                                        'Your alert subscription updates successfully!'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              setState(() {
                                filteredMyAlerts[index].isSubscribed = false;
                              });
                            }
                          } else {
                            var subscribeAgain =
                                "https://letitgo.shop/dealspotter/services/updateAlertSubscription?memberId=${globals.user.memberId}&subscriptionId=${filteredMyAlerts[index].id}&subscriptionType=$type&subscribed_status=0";
                            var response =
                                await http.post(Uri.parse(subscribeAgain));
                            print(subscribeAgain);
                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            if (response.statusCode == 200) {
                              var data = jsonDecode(response.body);
                              var status = data["status"];
                              if (status == "error") {
                                var subscribeUrl =
                                    "https://letitgo.shop/dealspotter/services/subscribeToAlerts?memberId=${globals.user.memberId}&subscriptionId=${filteredMyAlerts[index].id}&subscriptionType=$type";
                                var response =
                                    await http.post(Uri.parse(subscribeUrl));
                                print(subscribeUrl);
                                print(
                                    'Response status: ${response.statusCode}');
                                print('Response body: ${response.body}');
                                if (response.statusCode == 200) {
                                  var data = jsonDecode(response.body);
                                  var status = data["status"];
                                  if (status == "success") {
                                    final snackBar = SnackBar(
                                        content: Text(
                                            'You have been subscribed successfully!'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    final snackBar = SnackBar(
                                        content: Text(
                                            'You have already been subscribed.'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  setState(() {
                                    filteredMyAlerts[index].isSubscribed =
                                        false;
                                  });
                                }
                              } else {
                                final snackBar = SnackBar(
                                    content: Text(
                                        'Your alert subscription updates successfully!'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                setState(() {
                                  filteredMyAlerts[index].isSubscribed = true;
                                });
                              }
                            }
                          }
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(
                                    filteredMyAlerts[index].isSubscribed
                                        ? 'Remove'
                                        : 'Add',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
          itemCount: filteredMyAlerts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 10),
        ),
      ),
    );
  }

  String checkType(index) {
    bool isBrand = filteredMyAlerts[index] is BrandModel;
    bool isCategory = filteredMyAlerts[index] is CategoriesModel;

    if (isBrand) {
      return "Brand";
    } else if (isCategory) {
      return "Category";
    } else {
      return "Store";
    }
  }
}
