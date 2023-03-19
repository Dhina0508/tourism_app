import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/details/hotel_full.dart';

class Hotel extends StatefulWidget {
  @override
  State<Hotel> createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  List hotel = [];
  Future<List<QueryDocumentSnapshot<Object?>>> gethoteldata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("hotel").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        hotel.add({
          "name": qn.docs[i]["name"],
          "img": qn.docs[i]["img"],
          "place": qn.docs[i]["place"],
          "rating": qn.docs[i]["rating"],
          "address": qn.docs[i]["address"],
          "cost": qn.docs[i]["cost"],
          "details": qn.docs[i]["details"],
          "phno": qn.docs[i]["phno"],
          "lat": qn.docs[i]["lat"],
          "long": qn.docs[i]["long"],
          "hotel_email": qn.docs[i]["email"]
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    gethoteldata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          centerTitle: true,
          title: Text(
            "Hotels",
            style: TextStyle(fontFamily: "JosefinSans", color: Colors.black),
          )),
      body: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemExtent: 100,
          itemCount: hotel.length,
          itemBuilder: (context, i) {
            return ListTile(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HotelFullDetails(
                              address: hotel[i]["address"],
                              cost: hotel[i]["cost"],
                              details: hotel[i]["details"],
                              img: hotel[i]["img"],
                              name: hotel[i]["name"],
                              phno: hotel[i]["phno"],
                              place: hotel[i]["place"],
                              rating: hotel[i]["rating"],
                              lat: hotel[i]["lat"],
                              long: hotel[i]["long"],
                              hotel_email: hotel[i]["hotel_email"],
                            )));
              },
              title: Text(
                hotel[i]["name"],
              ),
              subtitle: Text(hotel[i]["place"]),
              trailing: Container(
                child: Wrap(
                  spacing: 2, // space between two icons
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ), // icon-1
                    Text(
                      hotel[i]["rating"],
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ) // icon-2
                  ],
                ),
              ),
              leading: SizedBox(
                height: 250,
                width: 130,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: 250,
                      maxWidth: 200,
                      minHeight: 100,
                      minWidth: 100),
                  child: Image.network(
                    hotel[i]["img"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
