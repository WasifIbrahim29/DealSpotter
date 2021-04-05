import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DealALertsModel {
  String name;
  String id;
  bool isSubscribed;
  DealALertsModel(
      {@required this.name, @required this.id, @required this.isSubscribed});
}
