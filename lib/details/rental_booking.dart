import 'package:animated_background/animated_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RentalBooking extends StatefulWidget {
  var hotel_name;
  var hotel_email;

  RentalBooking({this.hotel_name, this.hotel_email});
  @override
  State<RentalBooking> createState() => _RentalBookingState();
}

class _RentalBookingState extends State<RentalBooking>
    with TickerProviderStateMixin {
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController no_of_days = TextEditingController();

  TextEditingController phno = TextEditingController();
  TextEditingController id_proof = TextEditingController();

  final vehicle = [
    "Gear Bike",
    "Scooty",
    "Sedan car with AC",
    "Sedan car Without AC"
        "8 Seater with AC",
    "8 Seater Without AC "
  ];
  String? value;
  sendreq() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;

    final _CollectionReference =
        FirebaseFirestore.instance.collection("Rental_booking_Request").doc();
    return _CollectionReference.set({
      "id": _CollectionReference.id,
      "no_of_days": no_of_days.text,
      "date": _datecontroller.text,
      "vehicle": value,
      "shop_name": widget.hotel_name,
      "shop_email": widget.hotel_email,
      "email": FirebaseAuth.instance.currentUser!.email,
      "name": FirebaseAuth.instance.currentUser!.displayName.toString(),
      "phno": phno.text,
      "status": "Pending",
      "user": "vendor",
      "c_time": DateTime.now(),
      "id_proof": id_proof.text
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade400,
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Booking Details",
          style: TextStyle(
              fontFamily: "Cinzel", fontSize: 22, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(24, 252, 135, 38),
                ),
                height: 500,
                width: double.infinity,
                child: AnimatedBackground(
                  behaviour: RandomParticleBehaviour(
                      options: ParticleOptions(
                    spawnMaxRadius: 20,
                    spawnMinSpeed: 50,
                    particleCount: 10,
                    spawnMaxSpeed: 80,
                    minOpacity: 0.5,
                    maxOpacity: 0.7,
                    baseColor: Colors.white,
                  )),
                  vsync: this,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Select the type of Vehicle: ",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "JosefinSans"),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              dropdownColor: Colors.white,
                              hint: Text(
                                'Type of vehicle',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              value: value,
                              style: TextStyle(color: Colors.black),
                              iconSize: 16 * 2,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              items: vehicle.map(buildroomnumber).toList(),
                              onChanged: (value) => setState(() {
                                    this.value = value;
                                  })),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 20, left: 20),
                        child: TextField(
                          controller: _datecontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 248, 111, 111),
                            ),
                            labelText: 'Select Date',
                            labelStyle: TextStyle(color: Colors.black),
                          ),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Number of days Wanted",
                            prefixIcon: Icon(
                              Icons.hourglass_bottom,
                              color: Color.fromARGB(255, 248, 111, 111),
                            ),
                            label: Text(
                              "Enter no of days Wanted for your journey",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          controller: no_of_days,
                          cursorColor: Colors.red,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Enter your contact number",
                              label: Text(
                                "Mobile number",
                                style: TextStyle(color: Colors.black),
                              ),
                              prefixIcon: Icon(
                                Icons.call,
                                color: Color.fromARGB(255, 248, 111, 111),
                              )),
                          controller: phno,
                          cursorColor: Colors.red,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline_sharp,
                              color: Color.fromARGB(255, 248, 111, 111),
                            ),
                            hintText: "Enter Aadhar card number",
                            label: Text(
                              "Enter Id Proof",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          controller: id_proof,
                          cursorColor: Colors.red,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 45,
                  width: 140,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Color.fromARGB(255, 251, 115, 105)),
                      onPressed: () {
                        if (no_of_days.text != '' &&
                            _datecontroller != '' &&
                            phno.text != '' &&
                            id_proof.text != '' &&
                            value.toString() != '') {
                          sendreq();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Details cannot be empty"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Text('Book Now')))
            ],
          ),
        ),
      )),
    );
  }

  DropdownMenuItem<String> buildroomnumber(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ));
}
