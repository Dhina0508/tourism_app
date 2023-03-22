import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/place_details.dart';

class Hotel_Particular_Place_List extends StatefulWidget {
  var value;
  var name;
  Hotel_Particular_Place_List({this.value, this.name});

  @override
  State<Hotel_Particular_Place_List> createState() =>
      _Hotel_Particular_Place_ListState();
}

class _Hotel_Particular_Place_ListState
    extends State<Hotel_Particular_Place_List> {
  List hotel = [];
  //Future<List<QueryDocumentSnapshot<Object?>>>
  gethoteldata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("hotel").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        hotel.add({
          "name": qn.docs[i]["name"],
          "img": qn.docs[i]["img"],
          "address": qn.docs[i]["address"],
          "cost": qn.docs[i]["cost"],
          "details": qn.docs[i]["details"],
          "time": qn.docs[i]["time"],
          "phno": qn.docs[i]["phno"],
          "rating": qn.docs[i]["rating"],
          "place": qn.docs[i]["place"],
          "lat": qn.docs[i]["lat"],
          "long": qn.docs[i]["long"],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Hotels",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "JosefinSans",
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 251, 116, 106),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            hotel.length > 1
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: hotel.length,
                    itemBuilder: (context, i) {
                      if (hotel[i]["place"] == widget.name) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaceDetails(
                                            lat: hotel[i]["lat"],
                                            long: hotel[i]["long"],
                                            address: hotel[i]["address"],
                                            des: hotel[i]["details"],
                                            entry: hotel[i]["cost"],
                                            img: hotel[i]["img"],
                                            name: hotel[i]["name"],
                                            phno: hotel[i]["phno"],
                                            rating: hotel[i]["rating"],
                                            time: hotel[i]["time"],
                                          )));
                            },
                            child: Card(
                              elevation: 10,
                              child: Container(
                                height: 90,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  hotel[i]["img"],
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
                                                  hotel[i]["name"],
                                                ),
                                                Wrap(spacing: 2, children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                  Text(hotel[i]["rating"])
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
                    })
                : Column(
                    children: [
                      SizedBox(
                        height: 250,
                      ),
                      Center(
                        child: Text(
                          "Not yet uploaded",
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'Josefinsans'),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
