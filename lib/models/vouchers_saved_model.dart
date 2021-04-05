import 'dart:convert';

import 'package:deal_spotter/models/saved_model.dart';

class VoucherSavedModel extends SavedModel {
  String id;
  String memberId;
  String dealId;
  String type;
  String dated;
  String voucherId;
  String voucher_code;
  String voucher_attachments;
  String voucher_description;
  VoucherSavedModel({
    String title,
    this.id,
    this.memberId,
    this.dealId,
    this.type,
    this.dated,
    this.voucherId,
    this.voucher_code,
    this.voucher_attachments,
    this.voucher_description,
  }) : super(title: title);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberId': memberId,
      'dealId': dealId,
      'type': type,
      'dated': dated,
      'voucherId': voucherId,
      'title': title,
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
      title: map['voucher_title'],
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
    return 'VoucherSavedModel(id: $id, memberId: $memberId, dealId: $dealId, type: $type, dated: $dated, voucherId: $voucherId, voucher_title: $title, voucher_code: $voucher_code, voucher_attachments: $voucher_attachments, voucher_description: $voucher_description)';
  }
}
