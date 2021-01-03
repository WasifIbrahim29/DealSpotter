import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListTilesModel {
  IconData leading;
  String title;
  String subtitle;

  ListTilesModel({this.leading, this.title, this.subtitle});

  static List<ListTilesModel> listTile = [
    ListTilesModel(
      leading: Icons.directions_walk,
      title: "Amazon",
      subtitle: "10 Coupons",
    ),
    ListTilesModel(
      leading: Icons.phone,
      title: "Lowe's",
      subtitle: "10 Coupons",
    ),
    ListTilesModel(
      leading: Icons.phone,
      title: "Macy's",
      subtitle: "10 Coupons",
    ),
    ListTilesModel(
      leading: Icons.phone,
      title: "Ebay",
      subtitle: "10 Coupons",
    ),
    ListTilesModel(
      leading: Icons.phone,
      title: "Ali Baba",
      subtitle: "10 Coupons",
    ),
    ListTilesModel(
      leading: Icons.phone,
      title: "Facebook",
      subtitle: "10 Coupons",
    ),
    ListTilesModel(
      leading: Icons.phone,
      title: "Apple",
      subtitle: "10 Coupons",
    ),
    ListTilesModel(
      leading: Icons.phone,
      title: "Huawie",
      subtitle: "10 Coupons",
    ),
    ListTilesModel(
      leading: Icons.phone,
      title: "Samsung",
      subtitle: "10 Coupons",
    ),
  ];
}
