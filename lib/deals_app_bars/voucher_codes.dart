import 'package:flutter/material.dart';
import 'package:deal_spotter/models/list_tiles_model.dart';

class VoucherCodes extends StatelessWidget {
  const VoucherCodes({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        itemBuilder: (BuildContext ctxt, int index) {
          String title = ListTilesModel.listTile[index].title;
          String subtitle = ListTilesModel.listTile[index].subtitle;
          print(title);
          print(subtitle);
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: ListTile(
              leading: Icon(ListTilesModel.listTile[index].leading),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          );
        },
        itemCount: ListTilesModel.listTile.length,
      ),
    );
  }
}
