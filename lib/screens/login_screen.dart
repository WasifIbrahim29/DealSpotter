import 'package:deal_spotter/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:deal_spotter/components/top_search_bar.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    hint: "Name",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextBox(
                    hint: "E-mail",
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LandingScreen()),
                      );
                    },
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
