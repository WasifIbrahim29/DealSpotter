import 'dart:convert';

class UserModel {
  String memberId;
  String username;
  String surname;
  String email;
  String password;
  String contact_no;
  String address1;
  String address2;
  String city;
  String state;
  String post_code;
  String dob;
  String user_image;
  UserModel({
    this.memberId,
    this.username,
    this.surname,
    this.email,
    this.password,
    this.contact_no,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.post_code,
    this.dob,
    this.user_image,
  });

  UserModel copyWith({
    String memberId,
    String username,
    String surname,
    String email,
    String password,
    String contact_no,
    String address1,
    String address2,
    String city,
    String state,
    String post_code,
    String dob,
    String user_image,
  }) {
    return UserModel(
      memberId: memberId ?? this.memberId,
      username: username ?? this.username,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      contact_no: contact_no ?? this.contact_no,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      post_code: post_code ?? this.post_code,
      dob: dob ?? this.dob,
      user_image: user_image ?? this.user_image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memberId': memberId,
      'username': username,
      'surname': surname,
      'email': email,
      'password': password,
      'contact_no': contact_no,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'post_code': post_code,
      'dob': dob,
      'user_image': user_image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      memberId: map['memberId'],
      username: map['username'],
      surname: map['surname'],
      email: map['email'],
      password: map['password'],
      contact_no: map['contact_no'],
      address1: map['address1'],
      address2: map['address2'],
      city: map['city'],
      state: map['state'],
      post_code: map['post_code'],
      dob: map['dob'],
      user_image: map['user_image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(memberId: $memberId, username: $username, surname: $surname, email: $email, password: $password, contact_no: $contact_no, address1: $address1, address2: $address2, city: $city, state: $state, post_code: $post_code, dob: $dob, user_image: $user_image)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.memberId == memberId &&
        o.username == username &&
        o.surname == surname &&
        o.email == email &&
        o.password == password &&
        o.contact_no == contact_no &&
        o.address1 == address1 &&
        o.address2 == address2 &&
        o.city == city &&
        o.state == state &&
        o.post_code == post_code &&
        o.dob == dob &&
        o.user_image == user_image;
  }

  @override
  int get hashCode {
    return memberId.hashCode ^
        username.hashCode ^
        surname.hashCode ^
        email.hashCode ^
        password.hashCode ^
        contact_no.hashCode ^
        address1.hashCode ^
        address2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        post_code.hashCode ^
        dob.hashCode ^
        user_image.hashCode;
  }
}
