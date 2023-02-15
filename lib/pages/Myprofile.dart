import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    CollectionReference users =
        FirebaseFirestore.instance.collection("User_data");
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile",
            style: TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontFamily: "josefinSans",
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.email).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                return SafeArea(
                    child: Stack(children: [
                  Center(
                    child: Image.asset(
                      "images/man.png",
                      fit: BoxFit.cover,
                      color: Colors.white70.withOpacity(0.05),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: 50,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 70,
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            "${data["Name"]}",
                            style:
                                TextStyle(fontSize: 20, fontFamily: "Cinzel"),
                          ),
                          Spacer()
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Login Id : ",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 250,
                            child: Center(
                              child: Card(
                                elevation: 5,
                                shadowColor: Color.fromARGB(255, 247, 112, 102),
                                child: Text(
                                  "${data["email"]}",
                                  style: TextStyle(
                                    fontFamily: "JosefinSans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        endIndent: 20,
                        indent: 20,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text("Favourite"),
                        leading: Icon(Icons.favorite),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text("Visited Places"),
                        leading: Icon(Icons.location_city_rounded),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text("Settings"),
                        leading: Icon(Icons.settings),
                      ),
                      SizedBox(
                        height: 20,
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
                      ),
                    ],
                  ),
                ]));
              }
              return Center(
                child: Text("Loading..."),
              );
            }));
  }
}
