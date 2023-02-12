import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/firebase_helper/firebase_service.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("dhina"), Text("dhina0508@gmail.com")],
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                onTap: () async {
                  service.signOut(context);
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.remove("email");
                },
                title: Text("Sign Out"),
                leading: Icon(Icons.logout),
              )
            ],
          ),
        ),
      ),
    );
  }
}
