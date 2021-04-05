import 'dart:convert';

import 'package:deal_spotter/models/saved_model.dart';

import 'history_model.dart';

class VoucherHistoryModel extends HistoryModel {
  String activityId;
  String memberId;
  String dealId;
  String type;
  String dated;
  String voucherId;
  String voucher_title;
  String voucher_code;
  String voucher_attachments;
  String voucher_description;
  VoucherHistoryModel({
    String voucher_title,
    this.activityId,
    this.memberId,
    this.dealId,
    this.type,
    this.dated,
    this.voucherId,
    this.voucher_code,
    this.voucher_attachments,
    this.voucher_description,
  }) : super(title: voucher_title);

  Map<String, dynamic> toMap() {
    return {
      'activityId': activityId,
      'memberId': memberId,
      'dealId': dealId,
      'type': type,
      'dated': dated,
      'voucherId': voucherId,
      'voucher_title': voucher_title,
      'voucher_code': voucher_code,
      'voucher_attachments': voucher_attachments,
      'voucher_description': voucher_description,
    };
  }

  factory VoucherHistoryModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VoucherHistoryModel(
      activityId: map['activityId'],
      memberId: map['memberId'],
      dealId: map['dealId'],
      type: map['type'],
      dated: map['dated'],
      voucherId: map['voucherId'],
      voucher_title: map['voucher_title'],
      voucher_code: map['voucher_code'],
      voucher_attachments: map['voucher_attachments'],
      voucher_description: map['voucher_description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VoucherHistoryModel.fromJson(String source) =>
      VoucherHistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VoucherHistoryModel(activityId: $activityId, memberId: $memberId, dealId: $dealId, type: $type, dated: $dated, voucherId: $voucherId, voucher_title: $voucher_title, voucher_code: $voucher_code, voucher_attachments: $voucher_attachments, voucher_description: $voucher_description)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VoucherHistoryModel &&
        o.activityId == activityId &&
        o.memberId == memberId &&
        o.dealId == dealId &&
        o.type == type &&
        o.dated == dated &&
        o.voucherId == voucherId &&
        o.voucher_title == voucher_title &&
        o.voucher_code == voucher_code &&
        o.voucher_attachments == voucher_attachments &&
        o.voucher_description == voucher_description;
  }

  @override
  int get hashCode {
    return activityId.hashCode ^
        memberId.hashCode ^
        dealId.hashCode ^
        type.hashCode ^
        dated.hashCode ^
        voucherId.hashCode ^
        voucher_title.hashCode ^
        voucher_code.hashCode ^
        voucher_attachments.hashCode ^
        voucher_description.hashCode;
  }
}
