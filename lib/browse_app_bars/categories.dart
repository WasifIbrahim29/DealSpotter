import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deal_spotter/models/list_tiles_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        ListTilesModel.listTile[index].leading,
                        size: 40,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Text(
                            ListTilesModel.listTile[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            ListTilesModel.listTile[index].subtitle,
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
                        size: 50,
                      ),
                    )
                  ],
                ),
              ));
        },
        itemCount: ListTilesModel.listTile.length,
      ),
    );
  }
}

// child: ListTile(
// leading: Icon(
// ListTilesModel.listTile[index].leading,
// size: 50,
// ),
// title: Text(
// ListTilesModel.listTile[index].title,
// style:
// TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
// ),
// subtitle: Text(
// ListTilesModel.listTile[index].subtitle,
// style: TextStyle(
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
