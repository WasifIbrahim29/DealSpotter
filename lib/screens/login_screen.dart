import 'package:deal_spotter/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/models/user.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loggedIn = false;
  final formKey = GlobalKey<FormState>();
  User user = new User();

  final snackBarKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('Invalid Credentials!'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: snackBarKey,
        body: Column(
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
                            user.email = value;
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
                            user.password = value;
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
                                color: !loggedIn ? Colors.black : primaryColor,
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
                              var url =
                                  "https://letitgo.shop/dealspotter/services/signin?email=${user.email}&password=${user.password}";
                              //var body = jsonEncode(user.toJson());
                              //print(body);
                              var response = await http.post(url);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');
                              if (response.statusCode == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LandingScreen()),
                                );
                              } else {
                                snackBarKey.currentState.showSnackBar(snackBar);
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
    );
  }
}
