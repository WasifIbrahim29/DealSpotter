import 'dart:convert';

class AlertsModel {
  String id;
  String brand_name;
  String status;
  String dated;
  AlertsModel({
    this.id,
    this.brand_name,
    this.status,
    this.dated,
  });

  AlertsModel copyWith({
    String id,
    String brand_name,
    String status,
    String dated,
  }) {
    return AlertsModel(
      id: id ?? this.id,
      brand_name: brand_name ?? this.brand_name,
      status: status ?? this.status,
      dated: dated ?? this.dated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand_name': brand_name,
      'status': status,
      'dated': dated,
    };
  }

  factory AlertsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AlertsModel(
      id: map['id'],
      brand_name: map['brand_name'],
      status: map['status'],
      dated: map['dated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AlertsModel.fromJson(String source) =>
      AlertsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AlertsModel(id: $id, brand_name: $brand_name, status: $status, dated: $dated)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AlertsModel &&
        o.id == id &&
        o.brand_name == brand_name &&
        o.status == status &&
        o.dated == dated;
  }

  @override
  int get hashCode {
    return id.hashCode ^ brand_name.hashCode ^ status.hashCode ^ dated.hashCode;
  }
}
