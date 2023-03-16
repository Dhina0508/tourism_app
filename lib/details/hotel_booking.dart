import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelBooking extends StatefulWidget {
  var hotel_name;

  HotelBooking({this.hotel_name});
  @override
  State<HotelBooking> createState() => _HotelBookingState();
}

class _HotelBookingState extends State<HotelBooking> {
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController time = TextEditingController();

  final rooms = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  String? value;
  sendreq() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;

    final _CollectionReference =
        FirebaseFirestore.instance.collection("Hotel_booking_Request").doc();
    return _CollectionReference.set({
      "id": _CollectionReference.id,
      "time": time.text,
      "date": _datecontroller.text,
      "no_of_room": value,
      "hotel_email": widget.hotel_name,
      "email": FirebaseAuth.instance.currentUser!.email
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Request has been Sent"),
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.of(context).pop();
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey, width: 1)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  hint: Text(
                    'Select Number of Rooms',
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                  value: value,
                  style: TextStyle(color: Colors.black),
                  iconSize: 16 * 2,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: rooms.map(buildroomnumber).toList(),
                  onChanged: (value) => setState(() {
                        this.value = value;
                      })),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8, top: 20, left: 8),
            child: TextField(
              controller: _datecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    color: Colors.redAccent[200],
                    size: 40,
                  ),
                  labelText: 'Select Date'),
              onTap: () async {
                DateTime? picketdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2090));
                if (picketdate != null) {
                  setState(() {
                    _datecontroller.text =
                        DateFormat('dd-MM-yyyy').format(picketdate);
                  });
                }
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: "Enter Time",
                label: Text("Enter Time"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            controller: time,
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 222, 81, 70)),
              onPressed: () {
                sendreq();
              },
              child: Text('Book')),
        ],
      )),
    );
  }

  DropdownMenuItem<String> buildroomnumber(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
}
