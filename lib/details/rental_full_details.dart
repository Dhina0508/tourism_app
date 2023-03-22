import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tourism/details/hotel_booking.dart';
import 'package:tourism/details/rental_booking.dart';
import 'package:url_launcher/url_launcher.dart';

class RentalFullDetails extends StatefulWidget {
  var img;
  var name;
  var place;
  var phno;
  var car_cost;
  var bike_cost;
  var rating;
  var address;
  var details;
  var email;
  var lat;
  var long;
  var time;
  RentalFullDetails({
    this.address,
    this.email,
    this.car_cost,
    this.bike_cost,
    this.time,
    this.lat,
    this.long,
    this.details,
    this.img,
    this.name,
    this.phno,
    this.place,
    this.rating,
  });
  @override
  State<RentalFullDetails> createState() => _RentalFullDetailsState();
}

class _RentalFullDetailsState extends State<RentalFullDetails> {
  static Future<void> openMAp(double lat, double long) async {
    String googlemapUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$long";

    if (await canLaunch(googlemapUrl)) {
      await launch(googlemapUrl);
    } else {
      throw "Could not Open the Map";
    }
  }

  Future addtofav() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionref =
        FirebaseFirestore.instance.collection("fav_places");
    return _collectionref
        .doc(currentUser!.email)
        .collection("places")
        .doc()
        .set({
      'name': widget.name,
      'rating': widget.rating,
      'img': widget.img,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Added to Fav!!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("fav_places")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("places")
                .where("name", isEqualTo: widget.name)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text("");
              }
              return IconButton(
                onPressed: () => snapshot.data.docs.length == 0
                    ? addtofav()
                    : SnackBar(
                        content: Text(
                          "Already Added ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                      ),
                icon: snapshot.data.docs.length == 0
                    ? Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.img,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.name,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Cinzel",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.place,
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "JosefinSans",
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 22,
                  ),
                  Text(widget.rating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Text(
                    "Open : ",
                    style: TextStyle(
                        color: Colors.green, fontFamily: "Josefinsans"),
                  ),
                  Text(widget.time),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 245, 115, 106),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      openMAp(
                          double.parse(widget.lat), double.parse(widget.long));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Directions",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      launch("tel:${widget.phno}");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Call",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Share.share("Image Url: " +
                          widget.img +
                          "  " +
                          "Name of the place: " +
                          widget.name +
                          "  " +
                          "Address: " +
                          widget.address +
                          "  " +
                          "Bike Cost per Day: " +
                          widget.bike_cost +
                          "  " +
                          "Car Cost per Day: " +
                          widget.car_cost +
                          "  " +
                          "Phone Number:  " +
                          widget.phno +
                          "  " +
                          "District: " +
                          widget.place);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 250, 134, 126))),
                  Text("  " + widget.address,
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text("Contact: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 250, 134, 126))),
                  Text(widget.phno,
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text("Bike Cost: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 250, 134, 126))),
                  Text("Rs: " + widget.bike_cost + " Per Day",
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text("Car Cost: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 250, 134, 126))),
                  Text("Rs: " + widget.car_cost + " Per Day",
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 250, 134, 126))),
                  Text("  " + widget.details,
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text("Overall Rating: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 250, 134, 126))),
                  Text(widget.rating,
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          backgroundColor: Color.fromARGB(255, 245, 115, 106)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RentalBooking(
                                      hotel_name: widget.name,
                                      hotel_email: widget.email,
                                    )));
                      },
                      child: Text(
                        "Book Now",
                        style: TextStyle(fontSize: 17),
                      )),
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
