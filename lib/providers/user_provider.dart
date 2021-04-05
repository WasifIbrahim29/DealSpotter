import 'dart:io';

import 'package:flutter/material.dart';
import 'package:deal_spotter/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  var user = UserModel();
  String query;

  void changeQuery(query) {
    this.query = query;
    notifyListeners();
  }
}
