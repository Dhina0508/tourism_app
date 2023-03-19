import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerFullDetails2 extends StatefulWidget {
  var name;
  var phno;
  var date;
  var id_proof;
  var intime;
  var outtime;
  var no_of_rooms;
  var hotel_name;
  var email;
  var user;
  var id;
  CustomerFullDetails2(
      {this.date,
      this.email,
      this.id_proof,
      this.intime,
      this.user,
      this.name,
      this.no_of_rooms,
      this.phno,
      this.hotel_name,
      this.id,
      this.outtime});
  @override
  State<CustomerFullDetails2> createState() => _CustomerFullDetails2State();
}

class _CustomerFullDetails2State extends State<CustomerFullDetails2> {
  RemoveRequest(@required id) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Hotel_booking_Request");
    return _CollectionReference.doc(id)
        .update({"status": "Rejected", "user": ""}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.hotel_name,
            style: TextStyle(fontFamily: "Cinzel", fontSize: 20),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color.fromARGB(255, 241, 122, 113),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Customer Name: ",
                  style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 243, 122, 114),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Customer Phone Number: ",
                  style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 243, 122, 114),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.phno,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No of room Requested: ",
                  style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 243, 122, 114),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.no_of_rooms + " Rooms",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Requested Date: ",
                  style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 243, 122, 114),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Requested Check InTime: ",
                  style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 243, 122, 114),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.intime,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Requested Check OutTime: ",
                  style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 243, 122, 114),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outtime,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Customer Email Id: ",
                  style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 243, 122, 114),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.email,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Customer Id Proof: ",
                  style: TextStyle(
                      fontFamily: "JosefinSans",
                      color: Color.fromARGB(255, 243, 122, 114),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.id_proof,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                widget.user == "user"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                RemoveRequest(widget.id);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.remove_circle_outline),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Cancel")
                                ],
                              ))
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ));
  }
}
