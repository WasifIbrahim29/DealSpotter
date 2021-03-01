import 'dart:convert';

class CommentModel {
  String commId;
  String comment;
  String liked;
  String dated;
  String username;
  String surname;
  CommentModel({
    this.commId,
    this.comment,
    this.liked,
    this.dated,
    this.username,
    this.surname,
  });

  CommentModel copyWith({
    String commId,
    String comment,
    String liked,
    String dated,
    String username,
    String surname,
  }) {
    return CommentModel(
      commId: commId ?? this.commId,
      comment: comment ?? this.comment,
      liked: liked ?? this.liked,
      dated: dated ?? this.dated,
      username: username ?? this.username,
      surname: surname ?? this.surname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commId': commId,
      'comment': comment,
      'liked': liked,
      'dated': dated,
      'username': username,
      'surname': surname,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CommentModel(
      commId: map['commId'],
      comment: map['comment'],
      liked: map['liked'],
      dated: map['dated'],
      username: map['username'],
      surname: map['surname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(commId: $commId, comment: $comment, liked: $liked, dated: $dated, username: $username, surname: $surname)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CommentModel &&
        o.commId == commId &&
        o.comment == comment &&
        o.liked == liked &&
        o.dated == dated &&
        o.username == username &&
        o.surname == surname;
  }

  @override
  int get hashCode {
    return commId.hashCode ^
        comment.hashCode ^
        liked.hashCode ^
        dated.hashCode ^
        username.hashCode ^
        surname.hashCode;
  }
}
