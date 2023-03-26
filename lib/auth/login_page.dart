import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/auth/forgot.dart';
import 'package:tourism/auth/register_page.dart';
import 'package:tourism/auth/firebase_helper/firebase_service.dart';
import 'package:tourism/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  var visible = "";

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    // print(
    //   "the current width is" + MediaQuery.of(context).size.width.toString());
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'images/welcome2.jpeg',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(255, 246, 94, 94),
                                      width: 2))),
                          child: Text(
                            'Xenosights',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cinzel",
                                fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Enter Login Id',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, right: 20, left: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: passwordcontroller,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(color: Colors.black),
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
                            prefixIcon: Icon(
                              Icons.keyboard,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Container(
                        width: 120,
                        height: 35,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 246, 94, 94),
                            ),
                            // color: Color.fromRGBO(205, 189, 223, 1),
                            onPressed: () async {
                              setState(() {});
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              if (emailcontroller.text.isNotEmpty &&
                                  passwordcontroller.text.isNotEmpty) {
                                service.loginUser(
                                    context,
                                    emailcontroller.text.trim(),
                                    passwordcontroller.text);
                                pref.setString(
                                    "email", emailcontroller.text.trim());
                              } else {
                                service.errorBox(context,
                                    "Fields must not empty ,please provide valid email and password");
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Container(
                              alignment: Alignment.bottomLeft,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GetEmail()));
                                  },
                                  child: Text(
                                    " Forgot Password ?",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Container(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()));
                                  },
                                  child: Text(
                                    "Don't have an Account?   ",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
