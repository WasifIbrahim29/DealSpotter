import 'dart:convert';

import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  bool termsAndConditionsCheckBox = false;
  bool receiveMarketingMaterialCheckBox = false;
  var user = UserModel();
  final snackBarKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
      content: Text(
          'You have to check the terms and conditions checkbox to signup! '));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: snackBarKey,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(25),
                alignment: Alignment.center,
                color: primaryColor,
                child: Icon(
                  Icons.flight,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 25, right: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: TextBox(
                              hint: "Name",
                              validator: (value) {
                                print(value);
                                if (value == "") {
                                  return "This field is Mandatory!";
                                }
                                user.username = value;
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextBox(
                              hint: "Surname",
                              validator: (value) {
                                print(value);
                                if (value == "") {
                                  return "This field is Mandatory!";
                                }
                                user.surname = value;
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextBox(
                        hint: "Address Line 1",
                        validator: (value) {
                          print(value);
                          if (value == "") {
                            return "This field is Mandatory!";
                          }
                          user.address1 = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextBox(
                        hint: "Address Line 2",
                        validator: (value) {
                          print(value);
                          if (value == "") {
                            return "This field is Mandatory!";
                          }
                          user.address2 = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextBox(
                              hint: "City",
                              validator: (value) {
                                print(value);
                                if (value == "") {
                                  return "This field is Mandatory!";
                                }
                                user.city = value;
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextBox(
                              hint: "Province",
                              validator: (value) {
                                print(value);
                                if (value == "") {
                                  return "This field is Mandatory!";
                                }
                                user.state = value;
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextBox(
                              hint: "Post Code",
                              validator: (value) {
                                print(value);
                                if (value == "") {
                                  return "This field is Mandatory!";
                                }
                                user.post_code = value;
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextBox(
                              hint: "Date Of Birth",
                              validator: (value) {
                                print(value);
                                if (value == "") {
                                  return "This field is Mandatory!";
                                }
                                user.dob = value;
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextBox(
                        hint: "E-mail Address",
                        validator: (value) {
                          print(value);
                          if (value == "") {
                            return "This field is Mandatory!";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "This is not a valid email";
                          }
                          user.email = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextBox(
                        hint: "Password",
                        obscureText: true,
                        validator: (value) {
                          print(value);
                          if (value == "") {
                            return "This field is Mandatory!";
                          }
                          user.password = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextBox(
                        hint: "Contact No",
                        validator: (value) {
                          print(value);
                          if (value == "") {
                            return "This field is Mandatory!";
                          }
                          user.contact_no = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Icon(
                              !termsAndConditionsCheckBox
                                  ? Icons.check_box_outline_blank
                                  : Icons.check_box,
                              color: !termsAndConditionsCheckBox
                                  ? Colors.black
                                  : primaryColor,
                            ),
                            onTap: () {
                              setState(() {
                                termsAndConditionsCheckBox =
                                    !termsAndConditionsCheckBox;
                              });
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Agree to terms and conditions'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Icon(
                              !receiveMarketingMaterialCheckBox
                                  ? Icons.check_box_outline_blank
                                  : Icons.check_box,
                              color: !receiveMarketingMaterialCheckBox
                                  ? Colors.black
                                  : primaryColor,
                            ),
                            onTap: () {
                              setState(() {
                                receiveMarketingMaterialCheckBox =
                                    !receiveMarketingMaterialCheckBox;
                              });
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Agree to receive marketing material'),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      BlueButton(
                        title: 'Submit',
                        colour: Colors.black,
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            if (termsAndConditionsCheckBox) {
                              var url =
                                  "https://letitgo.shop/dealspotter/services/signup?username=${user.username}&surname=${user.surname}&email=${user.email}&password=${user.password}&contact_no=${user.contact_no}&address1=${user.address1}&address2=${user.address2}&city=${user.city}&state=${user.state}&dob=${user.dob}&postCode=${user.post_code}";
                              //var body = jsonEncode(user.toJson());
                              //print(body);
                              var response = await http.post(url);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');

                              if (response.statusCode == 200) {
                                var data = jsonDecode(response.body);
                                var status = data["status"];
                                var message = data["message"];
                                if (status == 0) {
                                  snackBarKey.currentState.showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  Navigator.pop(context,
                                      "Your account have been created successfully.");
                                }
                              }
                            } else {
                              snackBarKey.currentState.showSnackBar(snackBar);
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
