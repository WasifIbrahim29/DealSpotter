import 'dart:convert';

import 'package:deal_spotter/models/deal_alerts_model.dart';

class BrandModel extends DealALertsModel {
  String status;
  String dated;
  BrandModel({
    String id,
    String name,
    this.status,
    this.dated,
  }) : super(id: id, name: name);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand_name': name,
      'status': status,
      'dated': dated,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BrandModel(
      id: map['id'],
      name: map['brand_name'],
      status: map['status'],
      dated: map['dated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AlertsModel(id: $id, brand_name: $name, status: $status, dated: $dated)';
  }
}
