import 'package:deal_spotter/providers/query_provider.dart';
import 'package:deal_spotter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:provider/provider.dart';

class TopSearchBar extends StatelessWidget {
  TopSearchBar({
    this.tabIndex,
    this.directionIndex,
  });

  final int directionIndex;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    print("directionIndex: $directionIndex");
    print("tabIndex: $tabIndex");
    return Container(
      color: primaryColor,
      height: 100,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
        child: Row(
          children: <Widget>[
            Image.asset(
              'images/icon.png',
              height: 100,
              width: 100,
            ),
            SizedBox(
              width: 1,
            ),
            Expanded(
              child: TextField(
                onChanged: (query) {
                  print("query: $query");
                  if (directionIndex == 0 && tabIndex == 0) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeVouchers(query);
                  } else if (directionIndex == 0 && tabIndex == 1) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeLatestDeal(query);
                  } else if ((directionIndex == 0 && tabIndex == 2) ||
                      (directionIndex == 2)) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeForum(query);
                  } else if (directionIndex == 1 && tabIndex == 0) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeStore(query);
                  } else if (directionIndex == 1 && tabIndex == 1) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeCategory(query);
                  } else if (directionIndex == 4 && tabIndex == 0) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeNotification(query);
                  } else if (directionIndex == 4 && tabIndex == 1) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeSaved(query);
                  } else if (directionIndex == 4 && tabIndex == 2) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeHistory(query);
                  } else if (directionIndex == 5 && tabIndex == 0) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeNewDiscussion(query);
                  } else if (directionIndex == 5 && tabIndex == 1) {
                    Provider.of<QueryProvider>(context, listen: false)
                        .changeOldDiscussion(query);
                  }
                },
                style: TextStyle(
                  backgroundColor: Colors.white,
                ),
                textAlign: TextAlign.start,
                decoration: kSearchBarDecoration.copyWith(hintText: 'Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
