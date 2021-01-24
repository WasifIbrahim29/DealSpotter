import 'dart:convert';

class CategoriesModel {
  String id;
  String parent_id;
  String category_name;
  String status;
  String dated;
  CategoriesModel({
    this.id,
    this.parent_id,
    this.category_name,
    this.status,
    this.dated,
  });

  CategoriesModel copyWith({
    String id,
    String parent_id,
    String category_name,
    String status,
    String dated,
  }) {
    return CategoriesModel(
      id: id ?? this.id,
      parent_id: parent_id ?? this.parent_id,
      category_name: category_name ?? this.category_name,
      status: status ?? this.status,
      dated: dated ?? this.dated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parent_id': parent_id,
      'category_name': category_name,
      'status': status,
      'dated': dated,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoriesModel(
      id: map['id'],
      parent_id: map['parent_id'],
      category_name: map['category_name'],
      status: map['status'],
      dated: map['dated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Categories(id: $id, parent_id: $parent_id, category_name: $category_name, status: $status, dated: $dated)';
  }
}
