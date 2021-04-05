import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'deal_alerts_model.dart';

class StoresModel extends DealALertsModel {
  String store_img;
  String description;
  String about_store;
  String status;
  StoresModel({
    String id,
    String name,
    bool isSubscribed,
    this.store_img,
    this.description,
    this.about_store,
    this.status,
  }) : super(id: id, name: name, isSubscribed: isSubscribed);

  Map<String, dynamic> toMap() {
    return {
      'storeId': id,
      'title': name,
      'store_img': store_img,
      'description': description,
      'about_store': about_store,
      'status': status,
    };
  }

  factory StoresModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StoresModel(
      id: map['storeId'],
      name: map['title'],
      store_img: map['store_img'],
      description: map['description'],
      about_store: map['about_store'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoresModel.fromJson(String source) =>
      StoresModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StoresModel(storeId: $id, title: $name, store_img: $store_img, description: $description, about_store: $about_store, status: $status)';
  }
}
