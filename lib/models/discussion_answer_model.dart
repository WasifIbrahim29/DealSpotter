import 'dart:convert';

class DiscussionAnswerModel {
  String id;
  String question_id;
  String answer_by;
  String answer;
  String datetime;
  String username;
  String surname;
  DiscussionAnswerModel({
    this.id,
    this.question_id,
    this.answer_by,
    this.answer,
    this.datetime,
    this.username,
    this.surname,
  });

  DiscussionAnswerModel copyWith({
    String id,
    String question_id,
    String answer_by,
    String answer,
    String datetime,
    String username,
    String surname,
  }) {
    return DiscussionAnswerModel(
      id: id ?? this.id,
      question_id: question_id ?? this.question_id,
      answer_by: answer_by ?? this.answer_by,
      answer: answer ?? this.answer,
      datetime: datetime ?? this.datetime,
      username: username ?? this.username,
      surname: surname ?? this.surname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question_id': question_id,
      'answer_by': answer_by,
      'answer': answer,
      'datetime': datetime,
      'username': username,
      'surname': surname,
    };
  }

  factory DiscussionAnswerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DiscussionAnswerModel(
      id: map['id'],
      question_id: map['question_id'],
      answer_by: map['answer_by'],
      answer: map['answer'],
      datetime: map['datetime'],
      username: map['username'],
      surname: map['surname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscussionAnswerModel.fromJson(String source) =>
      DiscussionAnswerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiscussionAnswerModel(id: $id, question_id: $question_id, answer_by: $answer_by, answer: $answer, datetime: $datetime, username: $username, surname: $surname)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscussionAnswerModel &&
        o.id == id &&
        o.question_id == question_id &&
        o.answer_by == answer_by &&
        o.answer == answer &&
        o.datetime == datetime &&
        o.username == username &&
        o.surname == surname;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question_id.hashCode ^
        answer_by.hashCode ^
        answer.hashCode ^
        datetime.hashCode ^
        username.hashCode ^
        surname.hashCode;
  }
}
