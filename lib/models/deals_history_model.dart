import 'dart:convert';

import 'package:deal_spotter/models/saved_model.dart';

import 'history_model.dart';

class DealsHistoryModel extends HistoryModel {
  String id;
  String memberId;
  String dealId;
  String type;
  String dated;
  String deal_title;
  String deal_url;
  String deal_price;
  String deal_attachments;
  String deal_description;
  DealsHistoryModel({
    this.id,
    this.memberId,
    this.dealId,
    this.type,
    this.dated,
    this.deal_title,
    this.deal_url,
    this.deal_price,
    this.deal_attachments,
    this.deal_description,
  });

  DealsHistoryModel copyWith({
    String id,
    String memberId,
    String dealId,
    String type,
    String dated,
    String deal_title,
    String deal_url,
    String deal_price,
    String deal_attachments,
    String deal_description,
  }) {
    return DealsHistoryModel(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      dealId: dealId ?? this.dealId,
      type: type ?? this.type,
      dated: dated ?? this.dated,
      deal_title: deal_title ?? this.deal_title,
      deal_url: deal_url ?? this.deal_url,
      deal_price: deal_price ?? this.deal_price,
      deal_attachments: deal_attachments ?? this.deal_attachments,
      deal_description: deal_description ?? this.deal_description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberId': memberId,
      'dealId': dealId,
      'type': type,
      'dated': dated,
      'deal_title': deal_title,
      'deal_url': deal_url,
      'deal_price': deal_price,
      'deal_attachments': deal_attachments,
      'deal_description': deal_description,
    };
  }

  factory DealsHistoryModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DealsHistoryModel(
      id: map['id'],
      memberId: map['memberId'],
      dealId: map['dealId'],
      type: map['type'],
      dated: map['dated'],
      deal_title: map['deal_title'],
      deal_url: map['deal_url'],
      deal_price: map['deal_price'],
      deal_attachments: map['deal_attachments'],
      deal_description: map['deal_description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DealsHistoryModel.fromJson(String source) =>
      DealsHistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DealsHistoryModel(id: $id, memberId: $memberId, dealId: $dealId, type: $type, dated: $dated, deal_title: $deal_title, deal_url: $deal_url, deal_price: $deal_price, deal_attachments: $deal_attachments, deal_description: $deal_description)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DealsHistoryModel &&
        o.id == id &&
        o.memberId == memberId &&
        o.dealId == dealId &&
        o.type == type &&
        o.dated == dated &&
        o.deal_title == deal_title &&
        o.deal_url == deal_url &&
        o.deal_price == deal_price &&
        o.deal_attachments == deal_attachments &&
        o.deal_description == deal_description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        memberId.hashCode ^
        dealId.hashCode ^
        type.hashCode ^
        dated.hashCode ^
        deal_title.hashCode ^
        deal_url.hashCode ^
        deal_price.hashCode ^
        deal_attachments.hashCode ^
        deal_description.hashCode;
  }
}
