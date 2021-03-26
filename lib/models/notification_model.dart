import 'dart:convert';

class NotificationModel {
  String notificationId;
  String memberId;
  String type;
  String description;
  String dated;
  NotificationModel({
    this.notificationId,
    this.memberId,
    this.type,
    this.description,
    this.dated,
  });

  NotificationModel copyWith({
    String notificationId,
    String memberId,
    String type,
    String description,
    String dated,
  }) {
    return NotificationModel(
      notificationId: notificationId ?? this.notificationId,
      memberId: memberId ?? this.memberId,
      type: type ?? this.type,
      description: description ?? this.description,
      dated: dated ?? this.dated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'memberId': memberId,
      'type': type,
      'description': description,
      'dated': dated,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      notificationId: map['notificationId'],
      memberId: map['memberId'],
      type: map['type'],
      description: map['description'],
      dated: map['dated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(notificationId: $notificationId, memberId: $memberId, type: $type, description: $description, dated: $dated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.notificationId == notificationId &&
        other.memberId == memberId &&
        other.type == type &&
        other.description == description &&
        other.dated == dated;
  }

  @override
  int get hashCode {
    return notificationId.hashCode ^
        memberId.hashCode ^
        type.hashCode ^
        description.hashCode ^
        dated.hashCode;
  }
}
