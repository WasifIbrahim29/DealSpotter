import 'dart:convert';

class NotificationModel {
  String messageTitle;
  String notificationAlert;

  NotificationModel({
    this.messageTitle,
    this.notificationAlert,
  });

  NotificationModel copyWith({
    String messageTitle,
    String notificationAlert,
  }) {
    return NotificationModel(
      messageTitle: messageTitle ?? this.messageTitle,
      notificationAlert: notificationAlert ?? this.notificationAlert,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messageTitle': messageTitle,
      'notificationAlert': notificationAlert,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      messageTitle: map['messageTitle'],
      notificationAlert: map['notificationAlert'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Notification(messageTitle: $messageTitle, notificationAlert: $notificationAlert)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.messageTitle == messageTitle &&
        other.notificationAlert == notificationAlert;
  }

  @override
  int get hashCode => messageTitle.hashCode ^ notificationAlert.hashCode;
}
