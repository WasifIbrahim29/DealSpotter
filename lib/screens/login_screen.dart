import 'dart:convert';

import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/models/user_model.dart';
import 'package:deal_spotter/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loggedIn = false;
  final formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool showSpinner = false;

  final snackBarKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('Invalid Credentials!'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          key: snackBarKey,
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                height: 80,
                alignment: Alignment.center,
                color: primaryColor,
                child: Image.asset(
                  'images/icon.png',
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 60, top: 25, right: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextBox(
                            hint: "E-mail",
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
                              email = value;
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextBox(
                            hint: "Password",
                            obscureText: true,
                            validator: (value) {
                              print(value);
                              if (value == "") {
                                return "This field is Mandatory!";
                              }
                              password = value;
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                child: Icon(
                                  !loggedIn
                                      ? Icons.check_box_outline_blank
                                      : Icons.check_box,
                                  color:
                                      !loggedIn ? Colors.black : primaryColor,
                                ),
                                onTap: () {
                                  setState(() {
                                    loggedIn = !loggedIn;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Keep me logged in'),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          BlueButton(
                            title: 'Submit',
                            colour: Colors.black,
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                var url =
                                    "https://letitgo.shop/dealspotter/services/signin?email=$email&password=$password";
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
                                  try {
                                    print(response.body.toString());
                                    var data =
                                        json.decode(response.body.toString());
                                    var message = data["message"];
                                    if (message != null) {
                                      snackBarKey.currentState.showSnackBar(
                                          SnackBar(content: Text(message)));
                                    } else {
                                      var user = data["response"];
                                      var newUser = UserModel.fromMap(user);
                                      globals.user = newUser;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LandingScreen()),
                                      );
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  snackBarKey.currentState
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
