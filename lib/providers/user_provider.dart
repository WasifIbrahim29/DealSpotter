import 'dart:io';

import 'package:flutter/material.dart';
import 'package:deal_spotter/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  var user = UserModel();
  String username;
  File image;
  List<Notification> notifications = [];
}
