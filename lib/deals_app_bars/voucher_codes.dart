import 'dart:convert';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/list_tiles_model.dart';
import 'package:deal_spotter/models/voucher_codes_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoucherCodes extends StatefulWidget {
  String storeId;
  VoucherCodes({
    Key key,
    this.storeId,
  }) : super(key: key);

  @override
  _VoucherCodesState createState() => _VoucherCodesState();
}

class _VoucherCodesState extends State<VoucherCodes> {
  List<VoucherCodesModel> myVoucherCodes = [];

  Future<List<VoucherCodesModel>> getVoucherCodes() async {
    myVoucherCodes.clear();
    var url;
    if (widget.storeId != null) {
      url =
          "https://letitgo.shop/dealspotter/services/getVouchers?storeId=${widget.storeId}";
    } else {
      url = "https://letitgo.shop/dealspotter/services/getVouchers";
    }

    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var voucherCodesList = data["voucherCodes"];
      for (int i = 0; i < voucherCodesList.length; i++) {
        var store = VoucherCodesModel.fromMap(voucherCodesList[i]);
        myVoucherCodes.add(store);
        myVoucherCodes.add(store);
        myVoucherCodes.add(store);
      }
      return myVoucherCodes;
    }
  }

  Widget voucherCodesWidget(List<VoucherCodesModel> voucherCodes) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        itemBuilder: (BuildContext ctxt, int index) {
          String title = ListTilesModel.listTile[index].title;
          String subtitle = ListTilesModel.listTile[index].subtitle;
          print(title);
          print(subtitle);
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        myVoucherCodes[index].voucher_code,
                        style: TextStyle(color: primaryColor, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: ListTile(
                hoverColor: primaryColor,
                leading: Image(
                  image: NetworkImage(
                      'https://letitgo.shop/dealspotter/upload/vouchers/${myVoucherCodes[index].voucher_img}',
                      scale: 0.5),
                ),
                title: Text(
                  myVoucherCodes[index].voucher_title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                // subtitle: Text(myVoucherCodes[index].voucher_description),
              ),
            ),
          );
        },
        itemCount: myVoucherCodes.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getVoucherCodes(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? voucherCodesWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
