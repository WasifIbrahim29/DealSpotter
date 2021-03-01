import 'dart:convert';

import 'package:deal_spotter/models/saved_model.dart';

class VoucherSavedModel extends SavedModel {
  String id;
  String memberId;
  String dealId;
  String type;
  String dated;
  String voucherId;
  String voucher_title;
  String voucher_code;
  String voucher_attachments;
  String voucher_description;
  VoucherSavedModel({
    this.id,
    this.memberId,
    this.dealId,
    this.type,
    this.dated,
    this.voucherId,
    this.voucher_title,
    this.voucher_code,
    this.voucher_attachments,
    this.voucher_description,
  });

  VoucherSavedModel copyWith({
    String id,
    String memberId,
    String dealId,
    String type,
    String dated,
    String voucherId,
    String voucher_title,
    String voucher_code,
    String voucher_attachments,
    String voucher_description,
  }) {
    return VoucherSavedModel(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      dealId: dealId ?? this.dealId,
      type: type ?? this.type,
      dated: dated ?? this.dated,
      voucherId: voucherId ?? this.voucherId,
      voucher_title: voucher_title ?? this.voucher_title,
      voucher_code: voucher_code ?? this.voucher_code,
      voucher_attachments: voucher_attachments ?? this.voucher_attachments,
      voucher_description: voucher_description ?? this.voucher_description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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

  factory VoucherSavedModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VoucherSavedModel(
      id: map['id'],
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

  factory VoucherSavedModel.fromJson(String source) =>
      VoucherSavedModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VoucherSavedModel(id: $id, memberId: $memberId, dealId: $dealId, type: $type, dated: $dated, voucherId: $voucherId, voucher_title: $voucher_title, voucher_code: $voucher_code, voucher_attachments: $voucher_attachments, voucher_description: $voucher_description)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VoucherSavedModel &&
        o.id == id &&
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
    return id.hashCode ^
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
