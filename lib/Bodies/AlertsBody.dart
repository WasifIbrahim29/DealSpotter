import 'dart:convert';
import 'dart:core';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/alerts_model.dart';
import 'package:deal_spotter/models/deal_alerts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlertsBody extends StatefulWidget {
  const AlertsBody({
    Key key,
  }) : super(key: key);

  @override
  _AlertsBodyState createState() => _AlertsBodyState();
}

class _AlertsBodyState extends State<AlertsBody> {
  List<AlertsModel> myAlerts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<AlertsModel>> getAlerts() async {
    print("alerts here");
    myAlerts.clear();
    var url = "https://letitgo.shop/dealspotter/services/getBrands";
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var alertsList = data["brandsList"];
      for (int i = 0; i < alertsList.length; i++) {
        var store = AlertsModel.fromMap(alertsList[i]);
        myAlerts.add(store);
        myAlerts.add(store);
        myAlerts.add(store);
        myAlerts.add(store);
        myAlerts.add(store);
        myAlerts.add(store);
      }
    }
    return myAlerts;
  }

  Widget AlertsWidget(List<AlertsModel> alerts) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 0),
        child: GridView.builder(
          itemBuilder: (BuildContext ctxt, int index) {
            return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            myAlerts[index].brand_name,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Icon(
                            DealALertsModel.dealAlert[index].icon,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Add',
                      style: TextStyle(color: primaryColor, fontSize: 12),
                    ),
                  ],
                ));
          },
          itemCount: myAlerts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAlerts(),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? AlertsWidget(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }
}
