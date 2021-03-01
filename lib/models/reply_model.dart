import 'dart:convert';

class ReplyModel {
  String commId;
  String memberId;
  String forum_type;
  String forumId;
  String comment;
  String prevId;
  String liked;
  String dated;
  String username;
  String email;
  ReplyModel({
    this.commId,
    this.memberId,
    this.forum_type,
    this.forumId,
    this.comment,
    this.prevId,
    this.liked,
    this.dated,
    this.username,
    this.email,
  });

  ReplyModel copyWith({
    String commId,
    String memberId,
    String forum_type,
    String forumId,
    String comment,
    String prevId,
    String liked,
    String dated,
    String username,
    String email,
  }) {
    return ReplyModel(
      commId: commId ?? this.commId,
      memberId: memberId ?? this.memberId,
      forum_type: forum_type ?? this.forum_type,
      forumId: forumId ?? this.forumId,
      comment: comment ?? this.comment,
      prevId: prevId ?? this.prevId,
      liked: liked ?? this.liked,
      dated: dated ?? this.dated,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commId': commId,
      'memberId': memberId,
      'forum_type': forum_type,
      'forumId': forumId,
      'comment': comment,
      'prevId': prevId,
      'liked': liked,
      'dated': dated,
      'username': username,
      'email': email,
    };
  }

  factory ReplyModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReplyModel(
      commId: map['commId'],
      memberId: map['memberId'],
      forum_type: map['forum_type'],
      forumId: map['forumId'],
      comment: map['comment'],
      prevId: map['prevId'],
      liked: map['liked'],
      dated: map['dated'],
      username: map['username'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReplyModel.fromJson(String source) =>
      ReplyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReplyModel(commId: $commId, memberId: $memberId, forum_type: $forum_type, forumId: $forumId, comment: $comment, prevId: $prevId, liked: $liked, dated: $dated, username: $username, email: $email)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReplyModel &&
        o.commId == commId &&
        o.memberId == memberId &&
        o.forum_type == forum_type &&
        o.forumId == forumId &&
        o.comment == comment &&
        o.prevId == prevId &&
        o.liked == liked &&
        o.dated == dated &&
        o.username == username &&
        o.email == email;
  }

  @override
  int get hashCode {
    return commId.hashCode ^
        memberId.hashCode ^
        forum_type.hashCode ^
        forumId.hashCode ^
        comment.hashCode ^
        prevId.hashCode ^
        liked.hashCode ^
        dated.hashCode ^
        username.hashCode ^
        email.hashCode;
  }
}
