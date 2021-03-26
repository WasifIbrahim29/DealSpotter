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
  String user_image = "";
  String deviceToken;
  String roleId;
  String is_account_approved;
  String member_status;
  String dated;
  String is_notify;
  UserModel(
      {this.memberId,
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
      this.deviceToken,
      this.roleId,
      this.is_account_approved,
      this.member_status,
      this.dated,
      this.is_notify});

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
      'deviceToken': deviceToken,
      "roleId": roleId,
      "is_account_approved": is_account_approved,
      "member_status": member_status,
      "dated": dated,
      "is_notify": is_notify
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
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
      deviceToken: map['deviceToken'],
      roleId: map['roleId'],
      is_account_approved: map['is_account_approved'],
      member_status: map['member_status'],
      dated: map['dated'],
      is_notify: map['is_notify'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(memberId: $memberId, username: $username, surname: $surname, email: $email, password: $password, contact_no: $contact_no, address1: $address1, address2: $address2, city: $city, state: $state, post_code: $post_code, dob: $dob, user_image: $user_image, deviceToken: $deviceToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.memberId == memberId &&
        other.username == username &&
        other.surname == surname &&
        other.email == email &&
        other.password == password &&
        other.contact_no == contact_no &&
        other.address1 == address1 &&
        other.address2 == address2 &&
        other.city == city &&
        other.state == state &&
        other.post_code == post_code &&
        other.dob == dob &&
        other.user_image == user_image &&
        other.deviceToken == deviceToken;
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
        user_image.hashCode ^
        deviceToken.hashCode;
  }
}
