import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/hotel_full.dart';
import 'package:tourism/details/place_details.dart';
import 'package:tourism/details/rental_full_details.dart';

class RentalList extends StatefulWidget {
  var value;
  var name;
  RentalList({this.value, this.name});
  @override
  State<RentalList> createState() => _RentalListState();
}

class _RentalListState extends State<RentalList> {
  List rental = [];
  // Future<List<QueryDocumentSnapshot<Object?>>>
  getplacedata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("rental").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        rental.add({
          "name": qn.docs[i]["name"],
          "img": qn.docs[i]["img"],
          "x": qn.docs[i]["id"],
          "address": qn.docs[i]["address"],
          "bikeRent": qn.docs[i]["bikeRent"],
          "carRent": qn.docs[i]["carRent"],
          "des": qn.docs[i]["des"],
          "lat": qn.docs[i]["lat"],
          "long": qn.docs[i]["long"],
          "phno": qn.docs[i]["phno"],
          "place": qn.docs[i]["place"],
          "rating": qn.docs[i]["rating"],
          "time": qn.docs[i]["time"],
          "email": qn.docs[i]["email"]
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    getplacedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                print(widget.name);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Rental Shops",
            style: TextStyle(fontFamily: "Cinzel", color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: rental.length,
            itemBuilder: (context, i) {
              if (rental[i]["place"] == widget.name) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentalFullDetails(
                                    address: rental[i]["address"],
                                    bike_cost: rental[i]["bikeRent"],
                                    car_cost: rental[i]["carRent"],
                                    details: rental[i]["des"],
                                    email: rental[i]["email"],
                                    img: rental[i]["img"],
                                    lat: rental[i]["lat"],
                                    long: rental[i]["long"],
                                    name: rental[i]["name"],
                                    phno: rental[i]["phno"],
                                    place: rental[i]["place"],
                                    rating: rental[i]["rating"],
                                    time: rental[i]["time"],
                                  )));
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 100,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          rental[i]["img"],
                                        ),
                                        fit: BoxFit.cover)),
                              )),
                              Expanded(
                                  child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          rental[i]["name"],
                                          style: TextStyle(
                                              fontFamily: "JosefinSans",
                                              fontSize: 17),
                                        ),
                                        Wrap(spacing: 2, children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          Text(rental[i]["rating"])
                                        ]),
                                      ]),
                                ),
                              )),
                            ]),
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
