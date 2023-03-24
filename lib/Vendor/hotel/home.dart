import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/Vendor/hotel/accepted.dart';
import 'package:tourism/Vendor/hotel/rejected.dart';
import 'package:tourism/Vendor/hotel/vendor_dashboard.dart';
import 'package:tourism/auth/firebase_helper/firebase_service.dart';

class VendorHome extends StatefulWidget {
  VendorHome({Key? key}) : super(key: key);

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  List req1 = [];
  gethoteldata() async {
    QuerySnapshot qn1 = await FirebaseFirestore.instance
        .collection("Hotel_booking_Request")
        .where("hotel_email",
            isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    setState(() {
      for (int i = 0; i < qn1.docs.length; i++) {
        if (qn1.docs[i]["hotel_email"] ==
            FirebaseAuth.instance.currentUser!.email) {
          req1.add({
            "hotel_name": qn1.docs[i]["hotel_name"],
            "hotel_email": qn1.docs[i]["hotel_email"]
          });
        }
      }
    });
    return qn1.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gethoteldata();
  }

  @override
  Widget build(BuildContext context) {
    Service service = Service();
    for (int j = 0; j < req1.length; j++)
      if (req1[j]["hotel_email"] == FirebaseAuth.instance.currentUser!.email) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () async {
                    service.signOut(context);
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove("email");
                  },
                  icon: Icon(Icons.logout))
            ],
            backgroundColor: Color.fromARGB(255, 241, 122, 113),
            title: Text(
              req1[j]["hotel_name"],
              style: TextStyle(fontFamily: "Cinzel", fontSize: 20),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Vendor()));
                  },
                  child: Container(
                    color: Color.fromARGB(156, 250, 137, 129),
                    height: 70,
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      color: Color.fromARGB(156, 250, 137, 129),
                      child: Center(
                        child: Text(
                          "New Request",
                          style: TextStyle(
                              fontFamily: "JosefinSans",
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AcceptedReq()));
                  },
                  child: Container(
                    color: Color.fromARGB(156, 250, 137, 129),
                    height: 70,
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      color: Color.fromARGB(156, 250, 137, 129),
                      child: Center(
                        child: Text(
                          "Accepted List",
                          style: TextStyle(
                              fontFamily: "JosefinSans",
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RejectedList()));
                  },
                  child: Container(
                    color: Color.fromARGB(156, 250, 137, 129),
                    height: 70,
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      color: Color.fromARGB(156, 250, 137, 129),
                      child: Center(
                        child: Text(
                          "Rejected List",
                          style: TextStyle(
                              fontFamily: "JosefinSans",
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    ));
  }
}
