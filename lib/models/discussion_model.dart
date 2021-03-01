import 'dart:convert';

class DiscussionModel {
  String id;
  String memberId;
  String subject;
  String question;
  String status;
  String views;
  String datetime;
  DiscussionModel({
    this.id,
    this.memberId,
    this.subject,
    this.question,
    this.status,
    this.views,
    this.datetime,
  });

  DiscussionModel copyWith({
    String id,
    String memberId,
    String subject,
    String question,
    String status,
    String views,
    String datetime,
  }) {
    return DiscussionModel(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      subject: subject ?? this.subject,
      question: question ?? this.question,
      status: status ?? this.status,
      views: views ?? this.views,
      datetime: datetime ?? this.datetime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberId': memberId,
      'subject': subject,
      'question': question,
      'status': status,
      'views': views,
      'datetime': datetime,
    };
  }

  factory DiscussionModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DiscussionModel(
      id: map['id'],
      memberId: map['memberId'],
      subject: map['subject'],
      question: map['question'],
      status: map['status'],
      views: map['views'],
      datetime: map['datetime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscussionModel.fromJson(String source) =>
      DiscussionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Discussion(id: $id, memberId: $memberId, subject: $subject, question: $question, status: $status, views: $views, datetime: $datetime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscussionModel &&
        o.id == id &&
        o.memberId == memberId &&
        o.subject == subject &&
        o.question == question &&
        o.status == status &&
        o.views == views &&
        o.datetime == datetime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        memberId.hashCode ^
        subject.hashCode ^
        question.hashCode ^
        status.hashCode ^
        views.hashCode ^
        datetime.hashCode;
  }
}
