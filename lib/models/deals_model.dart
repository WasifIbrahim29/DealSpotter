import 'dart:convert';

class DealsModel {
  String dealId;
  String deal_title;
  String deal_url;
  String deal_price;
  String deal_img;
  String deal_description;
  String storeId;
  String store_title;
  String store_img;
  bool is_saved = false;
  DealsModel({
    this.dealId,
    this.deal_title,
    this.deal_url,
    this.deal_price,
    this.deal_img,
    this.deal_description,
    this.storeId,
    this.store_title,
    this.store_img,
  });

  DealsModel copyWith({
    String dealId,
    String deal_title,
    String deal_url,
    String deal_price,
    String deal_img,
    String deal_description,
    String storeId,
    String store_title,
    String store_img,
  }) {
    return DealsModel(
      dealId: dealId ?? this.dealId,
      deal_title: deal_title ?? this.deal_title,
      deal_url: deal_url ?? this.deal_url,
      deal_price: deal_price ?? this.deal_price,
      deal_img: deal_img ?? this.deal_img,
      deal_description: deal_description ?? this.deal_description,
      storeId: storeId ?? this.storeId,
      store_title: store_title ?? this.store_title,
      store_img: store_img ?? this.store_img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dealId': dealId,
      'deal_title': deal_title,
      'deal_url': deal_url,
      'deal_price': deal_price,
      'deal_img': deal_img,
      'deal_description': deal_description,
      'storeId': storeId,
      'store_title': store_title,
      'store_img': store_img,
    };
  }

  factory DealsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DealsModel(
      dealId: map['dealId'],
      deal_title: map['deal_title'],
      deal_url: map['deal_url'],
      deal_price: map['deal_price'],
      deal_img: map['deal_img'],
      deal_description: map['deal_description'],
      storeId: map['storeId'],
      store_title: map['store_title'],
      store_img: map['store_img'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DealsModel.fromJson(String source) =>
      DealsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DealsModel(dealId: $dealId, deal_title: $deal_title, deal_url: $deal_url, deal_price: $deal_price, deal_img: $deal_img, deal_description: $deal_description, storeId: $storeId, store_title: $store_title, store_img: $store_img)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DealsModel &&
        o.dealId == dealId &&
        o.deal_title == deal_title &&
        o.deal_url == deal_url &&
        o.deal_price == deal_price &&
        o.deal_img == deal_img &&
        o.deal_description == deal_description &&
        o.storeId == storeId &&
        o.store_title == store_title &&
        o.store_img == store_img;
  }

  @override
  int get hashCode {
    return dealId.hashCode ^
        deal_title.hashCode ^
        deal_url.hashCode ^
        deal_price.hashCode ^
        deal_img.hashCode ^
        deal_description.hashCode ^
        storeId.hashCode ^
        store_title.hashCode ^
        store_img.hashCode;
  }
}
