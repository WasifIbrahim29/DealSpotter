import 'dart:async';
import 'dart:convert';

import 'package:deal_spotter/appbar/appbar.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/user_model.dart';
import 'package:deal_spotter/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  bool termsAndConditionsCheckBox = false;
  bool receiveMarketingMaterialCheckBox = false;
  bool showSpinner = false;
  TextEditingController dateOfBirthController = TextEditingController();
  final snackBarKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
      content: Text(
          'You have to check the terms and conditions checkbox to signup! '));

  void handleTimeout() {
    // callback function
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LandingScreen()),
        (route) => false);
  }

  static const timeout = Duration(seconds: 3);
  static const ms = Duration(milliseconds: 1);

  Timer startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return Timer(duration, (handleTimeout));
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        key: snackBarKey,
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.all(5),
              //   height: 80,
              //   alignment: Alignment.center,
              //   color: primaryColor,
              //   child: Image.asset(
              //     'images/icon.png',
              //     height: 100,
              //     width: 100,
              //   ),
              // ),
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
                                globals.user.username = value;
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
                                globals.user.surname = value;
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
                          globals.user.address1 = value;
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
                          globals.user.address2 = value;
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
                                globals.user.city = value;
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
                                globals.user.state = value;
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
                                globals.user.post_code = value;
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
                              dobController: dateOfBirthController,
                              validator: (value) {
                                print(value);
                                globals.user.dob = value;
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
                          globals.user.email = value;
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
                          globals.user.password = value;
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
                          globals.user.contact_no = value;
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
                              setState(() {
                                showSpinner = true;
                              });
                              globals.user.user_image = "";
                              var url =
                                  "https://letitgo.shop/dealspotter/services/signup?username=${globals.user.username}&surname=${globals.user.surname}&email=${globals.user.email}&password=${globals.user.password}&contact_no=${globals.user.contact_no}&address1=${globals.user.address1}&address2=${globals.user.address2}&city=${globals.user.city}&state=${globals.user.state}&dob=${globals.user.dob}&postCode=${globals.user.post_code}&deviceToken=${globals.user.deviceToken}";
                              //var body = jsonEncode(user.toJson());
                              //print(body);
                              var response = await http.post(Uri.parse(url));
                              print(
                                  'Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');

                              setState(() {
                                showSpinner = false;
                              });

                              if (response.statusCode == 200) {
                                var data = jsonDecode(response.body);
                                var status = data["status"];
                                var message = data["message"];
                                if (status == 0) {
                                  snackBarKey.currentState.showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  startTimeout();

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("memberId",
                                      data["memberId"].toString());

                                  prefs.setString(
                                      "email", globals.user.email);
                                  prefs.setString(
                                      "password", globals.user.password);

                                  globals.user.memberId =
                                      data["memberId"].toString();

                                  snackBarKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Your account have been created successfully.'),
                                  ));
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
