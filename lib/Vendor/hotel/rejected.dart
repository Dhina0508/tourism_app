import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourism/Vendor/hotel/accepted_cus_full.dart';

class RejectedList extends StatefulWidget {
  RejectedList({Key? key}) : super(key: key);

  @override
  State<RejectedList> createState() => _RejectedListState();
}

class _RejectedListState extends State<RejectedList> {
  List req = [];
  List req1 = [];

  getdata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("User_data").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        req.add({
          "Business_name": qn.docs[i]["Business_name"],
          "name": qn.docs[i]["Name"],
          "email": qn.docs[i]["email"]
        });
      }
    });

    return qn.docs;
  }

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
            "email": qn1.docs[i]["email"],
            "date": qn1.docs[i]["date"],
            "no_of_rooms": qn1.docs[i]["no_of_room"],
            "intime": qn1.docs[i]["intime"],
            "outtime": qn1.docs[i]["outtime"],
            "x": qn1.docs[i]["id"],
            "hotel_name": qn1.docs[i]["hotel_name"],
            "hotel_email": qn1.docs[i]["hotel_email"],
            "id_proof": qn1.docs[i]["id_proof"],
            "customer_name": qn1.docs[i]["name"],
            "phno": qn1.docs[i]["phno"],
            "id": qn1.docs[i]["id"],
            "user": qn1.docs[i]["user"]
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
    getdata();
    gethoteldata();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < req.length; i++)
      for (int j = 0; j < req1.length; j++)
        if (req1[j]["hotel_email"] ==
            FirebaseAuth.instance.currentUser!.email) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 241, 122, 113),
                title: Text(
                  req1[j]["hotel_name"],
                  style: TextStyle(fontFamily: "Cinzel", fontSize: 20),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: ListView.builder(
                  itemCount: req1.length,
                  itemBuilder: (_, i) {
                    if (req1[i]["user"] == "") {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerFullDetails2(
                                          date: req1[i]["date"],
                                          email: req1[i]["email"],
                                          id_proof: req1[i]["id_proof"],
                                          name: req1[i]["customer_name"],
                                          no_of_rooms: req1[i]["no_of_rooms"],
                                          phno: req1[i]["phno"],
                                          intime: req1[i]["intime"],
                                          outtime: req1[i]["outtime"],
                                          hotel_name: req1[i]["hotel_name"],
                                          id: req1[i]["id"],
                                          user: req1[i]["user"],
                                        )));
                          },
                          child: Container(
                            height: 120,
                            child: Card(
                              elevation: 3,
                              color: Colors.white,
                              // margin:
                              //     EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Customer name: ",
                                          style: TextStyle(
                                              fontFamily: "JosefinSans",
                                              color: Color.fromARGB(
                                                  255, 243, 122, 114),
                                              fontSize: 17),
                                        ),
                                        Text(
                                          req1[i]["customer_name"],
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Customer Phone Number: ",
                                          style: TextStyle(
                                              fontFamily: "JosefinSans",
                                              color: Color.fromARGB(
                                                  255, 243, 122, 114),
                                              fontSize: 17),
                                        ),
                                        Text(
                                          req1[i]["phno"],
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Requested Date: ",
                                          style: TextStyle(
                                              fontFamily: "JosefinSans",
                                              color: Color.fromARGB(
                                                  255, 243, 122, 114),
                                              fontSize: 17),
                                        ),
                                        Text(
                                          req1[i]["date"],
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }));
        }
    return Scaffold(body: Center(child: Text("No request Found!!")));
  }
}
