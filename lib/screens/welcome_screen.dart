import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/white_button.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/screens/login_screen.dart';
import 'package:deal_spotter/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final snackBarKey = GlobalKey<ScaffoldState>();

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
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome to',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 25,
                            fontWeight: FontWeight.w400),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          ' Deal Spotter',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 40),
                    child: Text(
                      'Create an account to create deal alerts, vote, comments, save your favorite deals and more',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  BlueButton(
                    title: 'Sign Up',
                    colour: Colors.white,
                    onPressed: () {
                      _navigateAndDisplaySelection(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' Or',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  WhiteButton(
                    title: 'Log In',
                    colour: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupScreen(),
      ),
    );
    print(result);

    snackBarKey.currentState.showSnackBar(SnackBar(content: Text("$result")));
  }
}
