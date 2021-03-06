import 'dart:convert';

import 'package:deal_spotter/deals_app_bars/latest_deals.dart';
import 'package:deal_spotter/directions/deals.dart';
import 'package:deal_spotter/models/stores_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StoresScreen extends StatefulWidget {
  const StoresScreen({
    Key key,
  }) : super(key: key);

  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  List<StoresModel> myStores = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<StoresModel>> getStores() async {
    myStores.clear();
    var url = "https://letitgo.shop/dealspotter/services/getStores";
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var storesList = data["storesList"];
      for (int i = 0; i < storesList.length; i++) {
        var store = StoresModel.fromMap(storesList[i]);
        myStores.add(store);
      }
      return myStores;
    }
  }

  Widget StoreWidget(List<StoresModel> stores) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Deals(
                        storeId: myStores[index].storeId,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Image.network(
                            'https://letitgo.shop/dealspotter/upload/stores/${myStores[index].store_img}',
                            scale: 0.5),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        flex: 4,
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            Text(
                              myStores[index].title,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "10 Coupons",
                              textAlign: TextAlign.center,
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
        itemCount: myStores.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getStores(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? StoreWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
