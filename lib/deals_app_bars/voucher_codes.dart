import 'dart:convert';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/list_tiles_model.dart';
import 'package:deal_spotter/models/voucher_codes_model.dart';
import 'package:deal_spotter/models/vouchers_saved_model.dart';
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:deal_spotter/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:provider/provider.dart';

class VoucherCodes extends StatefulWidget {
  String storeId;
  String categoryId;
  VoucherCodes({
    Key key,
    this.storeId,
    this.categoryId,
  }) : super(key: key);

  @override
  _VoucherCodesState createState() => _VoucherCodesState();
}

class _VoucherCodesState extends State<VoucherCodes> {
  List<VoucherCodesModel> myVoucherCodes = [];
  List<VoucherSavedModel> mySavedVouchers = [];
  MaterialColor iconColor;
  Future<List<VoucherCodesModel>> voucherCodes;
  List savedVoucherIds = [];

  Future<List<VoucherSavedModel>> savedVouchers;

  Future<int> getSavedVouchersList() async {
    mySavedVouchers.clear();

    var vouchersUrl =
        'https://letitgo.shop/dealspotter/services/getSavedVouchers?memberId=${globals.user.memberId}';

    var response = await http.get(Uri.parse(vouchersUrl));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == 1) {
        var voucherCodesList = data["savedVouchers"];
        for (int i = 0; i < voucherCodesList.length; i++) {
          var voucher = VoucherSavedModel.fromMap(voucherCodesList[i]);
          savedVoucherIds.add(voucher.voucherId);
          mySavedVouchers.add(voucher);
        }
      }
    }
    print("SavedVouchers: $savedVouchers");
    return 1;
  }

  @override
  void initState() {
    super.initState();
    iconColor = Colors.grey;
    getBothVouchers();
  }

  void getBothVouchers() async {
    await getSavedVouchersList();
    setState(() {
      voucherCodes = getVoucherCodes();
    });
  }

  Future<List<VoucherCodesModel>> getVoucherCodes() async {
    myVoucherCodes.clear();
    Provider.of<QueryProvider>(context, listen: false)
        .myFilteredVouchers
        .clear();
    Provider.of<QueryProvider>(context, listen: false).myVouchers.clear();
    var url;
    if (widget.storeId != null) {
      url =
          "https://letitgo.shop/dealspotter/services/getVouchers?storeId=${widget.storeId}";
    } else if (widget.categoryId != null) {
      url =
          "https://letitgo.shop/dealspotter/services/getVouchers?categoryId=${widget.categoryId}";
    } else {
      url = "https://letitgo.shop/dealspotter/services/getVouchers";
    }

    print("url: $url");

    print(url);
    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == 1) {
        var voucherCodesList = data["voucherCodes"];
        for (int i = 0; i < voucherCodesList.length; i++) {
          var voucher = VoucherCodesModel.fromMap(voucherCodesList[i]);
          if (savedVoucherIds.contains(voucher.voucherId)) {
            voucher.is_saved = true;
          }
          myVoucherCodes.add(voucher);
        }
        print("up");
        print("up: $myVoucherCodes");
        Provider.of<QueryProvider>(context, listen: false)
            .addVoucher(myVoucherCodes);
        print(
            "Provider.of<QueryProvider>(context).myVouchers: ${Provider.of<QueryProvider>(context, listen: false).myVouchers}");
        return myVoucherCodes;
      } else {
        return myVoucherCodes;
      }
    }
  }

  Widget voucherCodesWidget(List<VoucherCodesModel> voucherCodes) {
    return Provider.of<QueryProvider>(context).myFilteredVouchers.length < 1
        ? Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No voucher code found",
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
                        "https://letitgo.shop/dealspotter/services/updateViews?memberId=${globals.user.memberId}&dealId=${myVoucherCodes[index].voucherId}&type=voucher";
                    var response = await http.post(Uri.parse(saveHistoryUrl));
                    print(saveHistoryUrl);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');
                    if (response.statusCode == 200) {
                      var data = jsonDecode(response.body);
                      var status = data["status"];
                      if (status == 1) {
                        print("Voucher added into history successfully!");
                      }
                    }
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
                              style:
                                  TextStyle(color: primaryColor, fontSize: 20),
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
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Image(
                                image: NetworkImage(
                                    'https://letitgo.shop/dealspotter/upload/vouchers/${myVoucherCodes[index].voucher_img}',
                                    scale: 1),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                myVoucherCodes[index].voucher_title,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () async {
                                  if (myVoucherCodes[index].is_saved) {
                                    var unsaveVoucherCode =
                                        "https://letitgo.shop/dealspotter/services/removeFavourite?memberId=${globals.user.memberId}&dealId=${myVoucherCodes[index].voucherId}&type=voucher";
                                    var response = await http
                                        .post(Uri.parse(unsaveVoucherCode));
                                    print(unsaveVoucherCode);
                                    print(
                                        'Response status: ${response.statusCode}');
                                    print('Response body: ${response.body}');
                                    if (response.statusCode == 200) {
                                      var data = jsonDecode(response.body);
                                      var status = data["status"];
                                      if (status == "success") {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Voucher Code removed from favourites successfully."),
                                        ));
                                        print("Voucher code removed");
                                        setState(() {
                                          myVoucherCodes[index].is_saved =
                                              false;
                                        });
                                      }
                                    }
                                  } else {
                                    var saveVoucherCode =
                                        "https://letitgo.shop/dealspotter/services/saveHistory?memberId=${globals.user.memberId}&dealId=${myVoucherCodes[index].voucherId}&type=voucher";
                                    var response = await http
                                        .post(Uri.parse(saveVoucherCode));
                                    print(saveVoucherCode);
                                    print(
                                        'Response status: ${response.statusCode}');
                                    print('Response body: ${response.body}');
                                    if (response.statusCode == 200) {
                                      var data = jsonDecode(response.body);
                                      var status = data["status"];
                                      if (status == "success") {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Voucher Code added to favourites successfully."),
                                        ));
                                        print("Voucher code saved");
                                        setState(() {
                                          myVoucherCodes[index].is_saved = true;
                                        });
                                      }
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: myVoucherCodes[index].is_saved == true
                                      ? Colors.red
                                      : Colors.grey,
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
              itemCount:
                  Provider.of<QueryProvider>(context).myFilteredVouchers.length,
            ),
          );
  }

  MaterialColor voucherAlreadySaved(String voucherId) {
    print("I am here again");
    for (VoucherSavedModel voucher in mySavedVouchers) {
      if (voucher.voucherId == voucherId) {
        return Colors.red;
      }
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: voucherCodes,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? voucherCodesWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
