import 'dart:convert';

import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/models/deals_history_model.dart';
import 'package:deal_spotter/models/deals_saved_model.dart';
import 'package:deal_spotter/models/history_model.dart';
import 'package:deal_spotter/models/saved_model.dart';
import 'package:deal_spotter/models/vouchers_history_model.dart';
import 'package:deal_spotter/models/vouchers_saved_model.dart';
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HistoryTab extends StatefulWidget {
  String storeId;
  HistoryTab({
    Key key,
    this.storeId,
  }) : super(key: key);

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  List<VoucherHistoryModel> myVoucherCodes = [];
  List<DealsHistoryModel> myLatestDeals = [];
  List<HistoryModel> historyModels = [];
  Future<int> noti;

  @override
  void initState() {
    super.initState();
    noti = getHistoryTabList();
  }

  Future<int> getHistoryTabList() async {
    historyModels.clear();
    Provider.of<QueryProvider>(context, listen: false)
        .myFilteredHistory
        .clear();
    Provider.of<QueryProvider>(context, listen: false).myHistory.clear();

    var dealsUrl =
        'https://letitgo.shop/dealspotter/services/getDealsHistory?memberId=${globals.user.memberId}';

    var response = await http.get(Uri.parse(dealsUrl));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == 1) {
        var latestDealsList = data["dealsList"];
        for (int i = 0; i < latestDealsList.length; i++) {
          var deal = DealsHistoryModel.fromMap(latestDealsList[i]);
          historyModels.add(deal);
        }
      }
    }

    var vouchersUrl =
        'https://letitgo.shop/dealspotter/services/getVouchersHistory?memberId=${globals.user.memberId}';

    response = await http.get(Uri.parse(vouchersUrl));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status"] == 1) {
        var voucherCodesList = data["vouchersList"];
        for (int i = 0; i < voucherCodesList.length; i++) {
          var voucher = VoucherHistoryModel.fromMap(voucherCodesList[i]);
          print(voucher);
          historyModels.add(voucher);
        }
      }
    }

    if (historyModels.length > 0) {
      Provider.of<QueryProvider>(context, listen: false)
          .addHistory(historyModels);
    }

    print("exiting");
    return 1;
  }

  Widget historyTabWidget() {
    return historyModels.length < 1
        ? Container(
            padding: EdgeInsets.all(20),
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
                          .myFilteredHistory[index] is VoucherHistoryModel;
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
                                            ? 'https://letitgo.shop/dealspotter/upload/vouchers/${(Provider.of<QueryProvider>(context).myFilteredHistory[index] as VoucherHistoryModel).voucher_attachments}'
                                            : 'https://letitgo.shop/dealspotter/upload/deals/${(Provider.of<QueryProvider>(context).myFilteredHistory[index] as DealsHistoryModel).deal_attachments}',
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
                                                .myFilteredHistory[index])
                                            .title
                                        : (Provider.of<QueryProvider>(context)
                                                .myFilteredHistory[index])
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
                        .myFilteredHistory
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
                ? historyTabWidget()
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
