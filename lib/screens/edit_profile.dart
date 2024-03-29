import 'dart:convert';
import 'dart:io';

import 'package:deal_spotter/appbar/appbar.dart';
import 'package:deal_spotter/components/blue_button.dart';
import 'package:deal_spotter/components/text_box.dart';
import 'package:deal_spotter/constants.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'package:deal_spotter/models/user_model.dart';
import 'package:deal_spotter/providers/query_provider.dart';
import 'package:deal_spotter/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File _image;
  String displayImage;
  final formKey = GlobalKey<FormState>();
  bool termsAndConditionsCheckBox = false;
  bool receiveMarketingMaterialCheckBox = false;
  UserModel user = UserModel();
  String fileName = "";
  ImagePicker imagePicker = ImagePicker();

  TextEditingController textEditingController = TextEditingController();
  final snackBarKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
      content: Text(
          'You have to check the terms and conditions checkbox to signup! '));

  final accountCreatedSnackbar =
      SnackBar(content: Text('You account have been created successfully.'));

  _imgFromCamera() async {
    final pickedFile = await imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print("image: $_image");
      fileName = _image.path.split('/').last;
      print("path: " + fileName);
    } else {
      print('No image selected.');
    }

    setState(() {
      returnImage();
    });
  }

  _imgFromGallery() async {
    print("in gallery");

    final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print("image: $_image");
      fileName = _image.path.split('/').last;
      print("path: " + fileName);
    } else {
      print('No image selected.');
    }

    setState(() {
      returnImage();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayImage =
        "https://letitgo.shop/dealspotter/upload/userImage/${globals.user.user_image}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      key: snackBarKey,
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
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: primaryColor,
                  child: globals.user.user_image != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: returnImage(),
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
                            labelText: "Name",
                            initialValue: globals.user.username,
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
                            labelText: "Surname",
                            initialValue: globals.user.surname,
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
                      labelText: "Address Line 1",
                      initialValue: globals.user.address1,
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
                      labelText: "Address Line 2",
                      initialValue: globals.user.address2,
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
                            labelText: "City",
                            initialValue: globals.user.city,
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
                            labelText: "Province",
                            initialValue: globals.user.state,
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
                            labelText: "Post Code",
                            initialValue: globals.user.post_code,
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
                            initialValue: globals.user.dob,
                            hint: "Date Of Birth",
                            labelText: "Date Of Birth",
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
                      labelText: "Contact No",
                      initialValue: globals.user.contact_no,
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
                          print("I am here");
                          print(_image);
                          Dio dio = new Dio();
                          print(globals.user.memberId);
                          FormData formData = FormData.fromMap({
                            'username': user.username,
                            'surname': user.surname,
                            'contact_no': user.contact_no,
                            'address1': user.address1,
                            'address2': user.address2,
                            'city': user.city,
                            'dob': user.dob,
                            'post_code': user.post_code,
                            'memberId': globals.user.memberId,
                            "user_image": await MultipartFile.fromFile(
                                _image.path,
                                filename: fileName),
                          });

                          try {
                            var response = await dio.post(
                                "https://letitgo.shop/dealspotter/services/updateProfile",
                                data: formData);

                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.statusMessage}');

                            if (response.statusCode == 200) {
                              var data = jsonDecode(response.data);
                              var status = data["status"];
                              print(status);
                              if (status == 1) {
                                var response = data["response"];
                                globals.user.city = response["city"];
                                globals.user.address1 = response["address1"];
                                globals.user.address2 = response["address2"];
                                globals.user.username = response["username"];
                                globals.user.user_image =
                                    response["user_image"];
                                print(globals.user.user_image);
                                globals.user.post_code = response["post_code"];
                                globals.user.state = response["state"];
                                globals.user.contact_no =
                                    response["contact_no"];
                                globals.user.dob = response["dob"];
                                Navigator.pop(
                                    context, "Profile updated successfully");
                              } else {
                                print(data["response"]);
                              }
                            }
                          } on DioError catch (e) {
                            print(e);
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
    );
  }

  Widget returnImage() {
    if (_image == null) {
      displayImage = globals.user.user_image;
      return Image.network(
        displayImage,
        width: 100,
        height: 100,
        fit: BoxFit.fitHeight,
      );
    } else {
      return Image.file(
        _image,
        width: 100,
        height: 100,
        fit: BoxFit.fitHeight,
      );
    }
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
