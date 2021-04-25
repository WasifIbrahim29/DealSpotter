import 'dart:convert';

class VoucherCodesModel {
  String voucherId;
  String voucher_title;
  String voucher_code;
  String voucher_img;
  String voucher_description;
  String storeId;
  String store_title;
  String store_img;
  bool is_saved = false;
  VoucherCodesModel({
    String title,
    this.voucherId,
    this.voucher_title,
    this.voucher_code,
    this.voucher_img,
    this.voucher_description,
    this.storeId,
    this.store_title,
    this.store_img,
  });

  VoucherCodesModel copyWith({
    String voucherId,
    String voucher_title,
    String voucher_code,
    String voucher_img,
    String voucher_description,
    String storeId,
    String store_title,
    String store_img,
  }) {
    return VoucherCodesModel(
      voucherId: voucherId ?? this.voucherId,
      voucher_title: voucher_title ?? this.voucher_title,
      voucher_code: voucher_code ?? this.voucher_code,
      voucher_img: voucher_img ?? this.voucher_img,
      voucher_description: voucher_description ?? this.voucher_description,
      storeId: storeId ?? this.storeId,
      store_title: store_title ?? this.store_title,
      store_img: store_img ?? this.store_img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'voucherId': voucherId,
      'voucher_title': voucher_title,
      'voucher_code': voucher_code,
      'voucher_img': voucher_img,
      'voucher_description': voucher_description,
      'storeId': storeId,
      'store_title': store_title,
      'store_img': store_img,
    };
  }

  factory VoucherCodesModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VoucherCodesModel(
      voucherId: map['voucherId'],
      voucher_title: map['voucher_title'],
      voucher_code: map['voucher_code'],
      voucher_img: map['voucher_img'],
      voucher_description: map['voucher_description'],
      storeId: map['storeId'],
      store_title: map['store_title'],
      store_img: map['store_img'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VoucherCodesModel.fromJson(String source) =>
      VoucherCodesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VoucherCodesModel(voucherId: $voucherId, voucher_title: $voucher_title, voucher_code: $voucher_code, voucher_img: $voucher_img, voucher_description: $voucher_description, storeId: $storeId, store_title: $store_title, store_img: $store_img)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VoucherCodesModel &&
        o.voucherId == voucherId &&
        o.voucher_title == voucher_title &&
        o.voucher_code == voucher_code &&
        o.voucher_img == voucher_img &&
        o.voucher_description == voucher_description &&
        o.storeId == storeId &&
        o.store_title == store_title &&
        o.store_img == store_img;
  }

  @override
  int get hashCode {
    return voucherId.hashCode ^
        voucher_title.hashCode ^
        voucher_code.hashCode ^
        voucher_img.hashCode ^
        voucher_description.hashCode ^
        storeId.hashCode ^
        store_title.hashCode ^
        store_img.hashCode;
  }
}
