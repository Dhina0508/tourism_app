import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RentalCustomerFullDetails extends StatefulWidget {
  var name;
  var phno;
  var date;
  var id_proof;
  var vehicle;
  var no_of_days;

  var shop_name;
  var email;
  var id;
  RentalCustomerFullDetails({
    this.date,
    this.email,
    this.id_proof,
    this.vehicle,
    this.name,
    this.no_of_days,
    this.phno,
    this.shop_name,
    this.id,
  });
  @override
  State<RentalCustomerFullDetails> createState() =>
      _RentalCustomerFullDetailsState();
}

class _RentalCustomerFullDetailsState extends State<RentalCustomerFullDetails> {
  AcceptRequest(@required id) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Rental_booking_Request");
    return _CollectionReference.doc(id)
        .update({"status": "Accepted", "user": "user"}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }

  RemoveRequest(@required id) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _CollectionReference =
        FirebaseFirestore.instance.collection("Rental_booking_Request");
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
            widget.shop_name,
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
                      widget.no_of_days + " days",
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
                  "Requested Vehicle: ",
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
                      widget.vehicle,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          AcceptRequest(widget.id);
                        },
                        child: Row(
                          children: [Icon(Icons.done_all), Text("Accept")],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          RemoveRequest(widget.id);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.not_interested_outlined),
                            Text("Reject")
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
