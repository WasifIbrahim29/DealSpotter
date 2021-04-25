import 'dart:convert';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/white_button.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/models/user_model.dart';
import 'package:deal_spotter/screens/landing_screen.dart';
import 'package:deal_spotter/screens/login_screen.dart';
import 'package:deal_spotter/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final snackBarKey = GlobalKey<ScaffoldState>();

  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogin();
  }

  Future autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString("memberId");
    String email = prefs.getString("email");
    String password = prefs.getString("password");
    print("iddd: $memberId");
    globals.user.memberId = memberId;
    // email = 'wow1@gmail.com';
    // password = '12356';

    if (memberId != null && memberId != '@') {
      await login(email, password);
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
    print("wtf");
    return 1;
  }

  Future login(String email, String password) async {
    var url =
        "https://letitgo.shop/dealspotter/services/signin?email=$email&password=$password&deviceToken=${globals.user.deviceToken}";
    //var body = jsonEncode(user.toJson());
    //print(body);
    var response = await http.post(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body.toString());
        var message = data["message"];
        if (message != null) {
          snackBarKey.currentState
              .showSnackBar(SnackBar(content: Text(message)));
        } else {
          var user = data["response"];
          var newUser = UserModel.fromMap(user);
          globals.user = newUser;
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackBarKey,
      body: FutureBuilder(
          future: autoLogin(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? WelcomeScreenWidget()
                : Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget WelcomeScreenWidget() {
    return isLoggedIn == false
        ? Column(
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
          )
        : LandingScreen();
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupScreen(),
      ),
    );

    print(result);

    if (result != null) {
      snackBarKey.currentState.showSnackBar(SnackBar(content: Text("$result")));
    }
  }
}
