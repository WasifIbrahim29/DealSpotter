import 'package:deal_spotter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:deal_spotter/components/top_search_bar.dart';
import 'package:deal_spotter/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File _image;
  final formKey = GlobalKey<FormState>();
  bool termsAndConditionsCheckBox = false;
  bool receiveMarketingMaterialCheckBox = false;
  User user = User();

  TextEditingController textEditingController = TextEditingController();
  final snackBarKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
      content: Text(
          'You have to check the terms and conditions checkbox to signup! '));

  final accountCreatedSnackbar =
      SnackBar(content: Text('You account have been created successfully.'));

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context).user;
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
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: primaryColor,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Edit Profile',
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
                              initialValue: provider.username,
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
                              initialValue: provider.surname,
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
                        initialValue: provider.address1,
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
                        initialValue: provider.address2,
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
                              initialValue: provider.city,
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
                              initialValue: provider.state,
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
                              initialValue: provider.post_code,
                              validator: (value) {
                                print(value);
                                if (value == "") {
                                  return "This field is Mandatory!";
                                }
                                user.postCode = value;
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextBox(
                              initialValue: provider.dob,
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
                        hint: "Contact No",
                        initialValue: provider.contact_no,
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
                        height: 15,
                      ),
                      BlueButton(
                        title: 'Submit',
                        colour: Colors.black,
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            if (termsAndConditionsCheckBox) {
                              var url =
                                  "https://letitgo.shop/dealspotter/services/signup?username=${user.username}&surname=${user.surname}&email=${user.email}&password=${user.password}&contact_no=${user.contact_no}&address1=${user.address1}&address2=${user.address2}&city=${user.city}&state=${user.state}&dob=${user.dob}&postCode=${user.postCode}";
                              //var body = jsonEncode(user.toJson());
                              //print(body);
                              var response = await http.post(url);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');

                              snackBarKey.currentState
                                  .showSnackBar(accountCreatedSnackbar);

                              Navigator.pop(context);
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
