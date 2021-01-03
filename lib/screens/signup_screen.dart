import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:deal_spotter/components/top_search_bar.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  bool termsAndConditionsCheckBox = false;
  bool receiveMarketingMaterialCheckBox = false;

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
                                return "Error";
                              }),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextBox(
                            hint: "Surname",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextBox(
                      hint: "Address Line 1",
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextBox(
                      hint: "Address Line 2",
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextBox(
                            hint: "City",
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextBox(
                            hint: "Province",
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
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextBox(
                            hint: "Date Of Birth",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextBox(
                      hint: "E-mail Address",
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextBox(
                      hint: "Contact No",
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
                      onPressed: () {
                        if (formKey.currentState.validate()) {}
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
