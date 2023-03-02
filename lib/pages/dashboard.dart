import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tourism/dash_board_four_pages/hotel.dart';
import 'package:tourism/details/hotel_full.dart';
import 'package:tourism/details/place_list.dart';
import 'package:tourism/helper/icons.dart';
import 'package:tourism/map/current_loc.dart';
import 'package:tourism/pages/Myprofile.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List home = [];
  List hotel = [];
  Future<List<QueryDocumentSnapshot<Object?>>> getdata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("tourism").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        home.add({
          "x": qn.docs[i]["id"],
          "name": qn.docs[i]["name"],
          "img": qn.docs[i]["img"]
        });
      }
    });
    return qn.docs;
  }

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
          "long": qn.docs[i]["long"]
        });
      }
    });
    return qn.docs;
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
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CurrentLocation()));
                          },
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CurrentLocation()));
                          },
                          child: Container(
                              child: Text(
                            "Tamilnadu, India",
                            style: TextStyle(fontSize: 15),
                          ))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyProfile()));
                            },
                            icon: Icon(Icons.person))),
                  )
                ],
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0),
              //   child: Text(
              //     "Explore the beautiful world !",
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20,
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15),
                child: Text(
                  "Best Places ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    for (int i = 0; i < home.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Stack(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaceList(
                                            value: home[i]["x"],
                                            name: home[i]["name"],
                                            img: home[i]["img"],
                                          )));
                            },
                            child: Container(
                              width: 250,
                              height: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  home[i]["img"],
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 190,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PlaceList(
                                                  value: home[i]["x"],
                                                  name: home[i]["name"],
                                                  img: home[i]["img"],
                                                )));
                                  },
                                  child: Container(
                                      width: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              home[i]["name"],
                                              style: TextStyle(
                                                  fontFamily: "Cinzel",
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Hotel()));
                        },
                        child: DashBoardIcon(icon: Icons.house_outlined)),
                    DashBoardIcon(icon: Icons.restaurant_menu_outlined),
                    DashBoardIcon(icon: Icons.directions_bike_outlined),
                    DashBoardIcon(
                      icon: Icons.flight,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "   Hotels",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    Text(
                      "Food",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    Text(
                      "Render",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    Text(
                      "Flight   ",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Popular Hotels",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemExtent: 100.0,
                  itemCount: hotel.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey, width: 0.7))),
                        child: ListTile(
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
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ) // icon-2
                                ],
                              ),
                            ),
                            // shape: RoundedRectangleBorder(
                            //   //<-- SEE HERE
                            //   side: BorderSide(width: 0.7, color: Colors.grey),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            leading: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 110,
                                minHeight: 150,
                                maxWidth: 110,
                                maxHeight: 264,
                              ),
                              child: Image.network(
                                hotel[i]["img"],
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Recommanded",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
