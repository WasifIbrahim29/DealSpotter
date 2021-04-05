import 'dart:convert';

import 'package:deal_spotter/models/saved_model.dart';

class DealsSavedModel extends SavedModel {
  String id;
  String memberId;
  String dealId;
  String dated;
  String deal_url;
  String deal_price;
  String deal_attachments;
  String deal_description;
  String type;
  DealsSavedModel({
    String title,
    this.id,
    this.memberId,
    this.dealId,
    this.dated,
    this.type,
    this.deal_url,
    this.deal_price,
    this.deal_attachments,
    this.deal_description,
  }) : super(title: title);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberId': memberId,
      'dealId': dealId,
      'type': type,
      'dated': dated,
      'title': title,
      'deal_url': deal_url,
      'deal_price': deal_price,
      'deal_attachments': deal_attachments,
      'deal_description': deal_description,
    };
  }

  factory DealsSavedModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DealsSavedModel(
      id: map['id'],
      memberId: map['memberId'],
      dealId: map['dealId'],
      type: map['type'],
      dated: map['dated'],
      title: map['deal_title'],
      deal_url: map['deal_url'],
      deal_price: map['deal_price'],
      deal_attachments: map['deal_attachments'],
      deal_description: map['deal_description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DealsSavedModel.fromJson(String source) =>
      DealsSavedModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DealsSavedModel(id: $id, memberId: $memberId, dealId: $dealId, type: $type, dated: $dated, deal_title: $title, deal_url: $deal_url, deal_price: $deal_price, deal_attachments: $deal_attachments, deal_description: $deal_description)';
  }
}
