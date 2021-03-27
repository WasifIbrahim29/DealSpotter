import 'package:flutter/material.dart';

const primaryColor = Color(0xFF59c1df);

final mainNavigatorKey = GlobalKey<NavigatorState>();
final subNavigatorKey = GlobalKey<NavigatorState>();

const kSearchBarDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontSize: 18),
  filled: true,
  suffixIcon: Icon(
    Icons.search,
    size: 30,
    color: primaryColor,
    textDirection: TextDirection.rtl,
  ),
  fillColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontSize: 15),
  filled: true,
  isDense: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
);

const kCommentDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 15),
  filled: true,
  isDense: true,
  enabled: true,
  hintText: "Add a comment",
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
);

const kReplyDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 15),
  filled: true,
  isDense: true,
  enabled: true,
  hintText: "Add a reply",
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  ),
);

const kDestinationItems = [
  BottomNavigationBarItem(
    icon: Icon(
      Icons.home,
    ),
    title: Text(
      'Deals',
    ),
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.business,
    ),
    title: Text(
      'Browse',
    ),
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.account_circle,
    ),
    title: Text(
      'Forums',
    ),
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.school,
    ),
    title: Text(
      'Alerts',
    ),
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.flag,
    ),
    title: Text(
      'Profile',
    ),
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.view_list,
    ),
    title: Text(
      'Discussion',
    ),
  ),
];
