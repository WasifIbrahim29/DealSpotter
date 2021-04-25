import 'dart:convert';

import 'package:deal_spotter/models/deal_alerts_model.dart';

class CategoriesModel extends DealALertsModel {
  String parent_id;
  String status;
  String dated;
  String total_coupons;
  CategoriesModel({
    String id,
    String name,
    bool isSubscribed,
    this.parent_id,
    this.status,
    this.dated,
    this.total_coupons,
  }) : super(id: id, name: name);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parent_id': parent_id,
      'category_name': name,
      'status': status,
      'dated': dated,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoriesModel(
      id: map['id'],
      parent_id: map['parent_id'],
      name: map['category_name'],
      status: map['status'],
      dated: map['dated'],
      total_coupons: map['total_coupons'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Categories(id: $id, parent_id: $parent_id, category_name: $name, status: $status, dated: $dated)';
  }
}
