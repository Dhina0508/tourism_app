import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/auth/firebase_helper/firebase_service.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  TextEditingController _NameController = TextEditingController();

  senddata() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;

    final _CollectionReference = await FirebaseFirestore.instance
        .collection("User_data")
        .doc(_emailcontroller.text);
    return _CollectionReference.set({
      "Name": _NameController.text,
      "email": _emailcontroller.text,
      "about": user_type
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    }).then((value) async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(_NameController.text);
    });
  }

  bool _isHidden = true;
  var visible = "";
  String user_type = "user";

  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/welcome2.jpeg'), fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              )),
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Color.fromARGB(255, 246, 94, 94),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Register Here',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: _NameController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Enter Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Enter Login Id',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: _isHidden,
                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          suffixIcon: visible == ""
                              ? InkWell(
                                  onTap: () {
                                    _togglePasswordView();
                                    visible = "1";
                                  },
                                  child: Icon(
                                    Icons.visibility_off,
                                    size: 25,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    _togglePasswordView();
                                    visible = "";
                                  },
                                  child: Icon(
                                    Icons.visibility,
                                    size: 25,
                                  )),
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: _isHidden,
                      controller: _confirmpasswordcontroller,
                      decoration: InputDecoration(
                          suffixIcon: visible == ""
                              ? InkWell(
                                  onTap: () {
                                    _togglePasswordView();
                                    visible = "1";
                                  },
                                  child: Icon(
                                    Icons.visibility_off,
                                    size: 25,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    _togglePasswordView();
                                    visible = "";
                                  },
                                  child: Icon(
                                    Icons.visibility,
                                    size: 25,
                                  )),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Re-Enter Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: "user",
                                groupValue: user_type,
                                onChanged: (value) {
                                  setState(() {
                                    user_type = value.toString();
                                  });
                                }),
                            Text(
                              "User",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "JosefinSans",
                                  fontSize: 18),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: "vendor",
                                groupValue: user_type,
                                onChanged: (value) {
                                  setState(() {
                                    user_type = value.toString();
                                  });
                                }),
                            Text(
                              "Vendor",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "JosefinSans",
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Sign In',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 246, 94, 94),
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700)),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color.fromARGB(255, 246, 94, 94),
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                if (_passwordcontroller.text ==
                                    _confirmpasswordcontroller.text) {
                                  if (_emailcontroller.text.isNotEmpty &&
                                      _passwordcontroller.text.isNotEmpty) {
                                    service.createUser(
                                        _NameController,
                                        context,
                                        _emailcontroller.text.toString().trim(),
                                        _passwordcontroller.text);
                                    pref.setString(
                                        "email",
                                        _emailcontroller.text
                                            .toString()
                                            .trim());
                                    senddata();
                                  } else {
                                    service.errorBox(context,
                                        "Fields must not empty ,please provide valid email and password");
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "ERROR : Passwords should be Same"),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              icon: Icon(Icons.arrow_forward)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
