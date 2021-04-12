import 'dart:convert';

import 'package:deal_spotter/directions/deals.dart';
import 'package:deal_spotter/models/categories_model.dart';
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    Key key,
  }) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoriesModel> myCategories = [];
  Future<List<CategoriesModel>> categories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
  }

  Future<List<CategoriesModel>> getCategories() async {
    myCategories.clear();
    Provider.of<QueryProvider>(context, listen: false)
        .myFilteredCategories
        .clear();
    Provider.of<QueryProvider>(context, listen: false).myCategories.clear();
    var url = "https://letitgo.shop/dealspotter/services/getCategories";
    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var categoriesList = data["categoryList"];
      for (int i = 0; i < categoriesList.length; i++) {
        var category = CategoriesModel.fromMap(categoriesList[i]);
        myCategories.add(category);
      }
      Provider.of<QueryProvider>(context, listen: false)
          .addCategory(myCategories);

      return myCategories;
    }
  }

  Widget StoreWidget(List<CategoriesModel> stores) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Deals(
                    categoryId: Provider.of<QueryProvider>(context)
                        .myFilteredCategories[index]
                        .id,
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
                  padding: EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Image(
                          image: NetworkImage(
                              'https://letitgo.shop/dealspotter/upload/stores/1610893152.png',
                              scale: 0.2),
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Expanded(
                        flex: 4,
                        child: Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            Text(
                              Provider.of<QueryProvider>(context)
                                  .myFilteredCategories[index]
                                  .name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
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
                )),
          );
        },
        itemCount:
            Provider.of<QueryProvider>(context).myFilteredCategories.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: categories,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? StoreWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
