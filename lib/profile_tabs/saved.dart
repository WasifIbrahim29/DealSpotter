import 'dart:convert';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/models/deals_saved_model.dart';
import 'package:deal_spotter/models/saved_model.dart';
import 'package:deal_spotter/models/vouchers_saved_model.dart';
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SavedTab extends StatefulWidget {
  String storeId;
  SavedTab({
    Key key,
    this.storeId,
  }) : super(key: key);

  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  @override
  void initState() {
    super.initState();
    myVoucherCodes.clear();
    myLatestDeals.clear();
    noti = getSavedTabList();
  }

  Future<int> noti;

  List<VoucherSavedModel> myVoucherCodes = [];
  List<DealsSavedModel> myLatestDeals = [];
  List<SavedModel> savedModels = [];

  Future<int> getSavedTabList() async {
    savedModels.clear();
    Provider.of<QueryProvider>(context, listen: false).myFilteredSaved.clear();
    Provider.of<QueryProvider>(context, listen: false).mySaved.clear();
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
          savedModels.add(deal);
        }
      }
    }

    var vouchersUrl =
        'https://letitgo.shop/dealspotter/services/getSavedVouchers?memberId=${globals.user.memberId}';

    response = await http.get(Uri.parse(vouchersUrl));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == 1) {
        var voucherCodesList = data["savedVouchers"];
        for (int i = 0; i < voucherCodesList.length; i++) {
          var voucher = VoucherSavedModel.fromMap(voucherCodesList[i]);
          savedModels.add(voucher);
        }
      }
    }

    if (savedModels.length > 0) {
      Provider.of<QueryProvider>(context, listen: false).addSaved(savedModels);
    }

    print("SavedModels: $savedModels");
    return 1;
  }

  Widget savedTabWidget() {
    return savedModels.length < 1
        ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.announcement_rounded,
                  color: primaryColor,
                  size: 85,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                )
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 1),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                    itemBuilder: (BuildContext ctxt, int index) {
                      bool isVoucher = Provider.of<QueryProvider>(context)
                          .myFilteredSaved[index] is VoucherSavedModel;
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
                                  flex: 2,
                                  child: Image(
                                    image: NetworkImage(
                                        isVoucher
                                            ? 'https://letitgo.shop/dealspotter/upload/vouchers/${(Provider.of<QueryProvider>(context).myFilteredSaved[index] as VoucherSavedModel).voucher_attachments}'
                                            : 'https://letitgo.shop/dealspotter/upload/deals/${(Provider.of<QueryProvider>(context).myFilteredSaved[index] as DealsSavedModel).deal_attachments}',
                                        scale: 0.8),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    isVoucher
                                        ? (Provider.of<QueryProvider>(context)
                                                .myFilteredSaved[index])
                                            .title
                                        : (Provider.of<QueryProvider>(context)
                                                .myFilteredSaved[index])
                                            .title,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: Provider.of<QueryProvider>(context)
                        .myFilteredSaved
                        .length,
                  ),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: noti,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? savedTabWidget()
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
