import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class User {
  // User(
  //     this.username,
  //     this.surname,
  //     this.email,
  //     this.password,
  //     this.contact_no,
  //     this.address1,
  //     this.address2,
  //     this.city,
  //     this.state,
  //     this.postCode,
  //     this.dob);

  String username;
  String surname;
  String email;
  String password;
  String contact_no;
  String address1;
  String address2;
  String city;
  String state;
  String postCode;
  String dob;

  Map<String, dynamic> toJson() => {
        'username': username,
        'surname': surname,
        'email': email,
        'password': password,
        'contact_no': contact_no,
        'address1': address1,
        'address2': address2,
        'city': city,
        'state': state,
        'postCode': postCode,
        'dob': dob,
      };
}
