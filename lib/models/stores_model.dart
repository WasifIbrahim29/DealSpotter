import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StoresModel {
  String storeId;
  String title;
  String store_img;
  String description;
  String about_store;
  String status;
  StoresModel({
    this.storeId,
    this.title,
    this.store_img,
    this.description,
    this.about_store,
    this.status,
  });

  StoresModel copyWith({
    String storeId,
    String title,
    String store_img,
    String description,
    String about_store,
    String status,
  }) {
    return StoresModel(
      storeId: storeId ?? this.storeId,
      title: title ?? this.title,
      store_img: store_img ?? this.store_img,
      description: description ?? this.description,
      about_store: about_store ?? this.about_store,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'title': title,
      'store_img': store_img,
      'description': description,
      'about_store': about_store,
      'status': status,
    };
  }

  factory StoresModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StoresModel(
      storeId: map['storeId'],
      title: map['title'],
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
    return 'StoresModel(storeId: $storeId, title: $title, store_img: $store_img, description: $description, about_store: $about_store, status: $status)';
  }
}
