import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:tourism/pages/search.dart';

import '../dash_board_four_pages/photography.dart';
import '../myprofile/Myprofile.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List home = [];
  List hotel = [];
  //Future<List<QueryDocumentSnapshot<Object?>>>
  getdata() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection("tourism")
        .orderBy("name", descending: false)
        .where("about", isEqualTo: null)
        .get();
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

  gethoteldata() async {
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

  var _DotPosition = 0;
  var _FireStoreInstance = FirebaseFirestore.instance;
  List<String> _SlidingImages = [];

  FetchSlidingImages() async {
    QuerySnapshot qn =
        await _FireStoreInstance.collection("loginpage_photos").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _SlidingImages.add(qn.docs[i]["img"]);
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    FetchSlidingImages();
    gethoteldata();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection("User_data");
    return Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.email).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                return SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          CarouselSlider(
                            items: _SlidingImages.map((item) => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 249, 152, 145)
                                          .withOpacity(0.15),
                                      image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.white.withOpacity(0.25),
                                            BlendMode.modulate),
                                        image: NetworkImage(
                                          item,
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                )).toList(),
                            options: CarouselOptions(
                                autoPlay: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 900),
                                viewportFraction: 1,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                onPageChanged:
                                    (val, carouselPageChangedReason) {
                                  _DotPosition = val;
                                }),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CurrentLocation()));
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
                                                      builder: (context) =>
                                                          CurrentLocation()));
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
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyProfile()));
                                              },
                                              icon: Icon(Icons.person))),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text("Welcome,",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "${data["Name"]}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.redAccent,
                                            fontFamily: "Cinzel"),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Search()));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.search,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Search place...",
                                            style: TextStyle(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 20,
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
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 15),
                          child: Text(
                            "BEST PLACES ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                      builder: (context) =>
                                                          PlaceList(
                                                            value: home[i]["x"],
                                                            name: home[i]
                                                                ["name"],
                                                            img: home[i]["img"],
                                                          )));
                                            },
                                            child: Container(
                                                width: 250,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        home[i]["name"],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Cinzel",
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Hotel()));
                                  },
                                  child: DashBoardIcon(
                                    icon: Icons.house_outlined,
                                    text: "Hotels",
                                  )),
                              DashBoardIcon(
                                  icon: Icons.restaurant_menu_outlined,
                                  text: "Food"),
                              DashBoardIcon(
                                  icon: Icons.directions_bike_outlined,
                                  text: "Render"),
                              DashBoardIcon(
                                text: "Train",
                                icon: Icons.train_outlined,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "POPULAR HOTELS",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                            itemCount: 3,
                            itemBuilder: (context, i) {
                              try {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HotelFullDetails(
                                                    address: hotel[i]
                                                        ["address"],
                                                    cost: hotel[i]["cost"],
                                                    details: hotel[i]
                                                        ["details"],
                                                    img: hotel[i]["img"],
                                                    name: hotel[i]["name"],
                                                    phno: hotel[i]["phno"],
                                                    place: hotel[i]["place"],
                                                    rating: hotel[i]["rating"],
                                                    lat: hotel[i]["lat"],
                                                    long: hotel[i]["long"],
                                                  )));
                                    },
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          // border: Border.all(
                                          //   color: Colors.red,
                                          //   width: 1,
                                          // ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        hotel[i]["name"],
                                                      ),
                                                      Divider(
                                                          color: Color.fromARGB(
                                                              255,
                                                              247,
                                                              127,
                                                              118),
                                                          endIndent: 10,
                                                          indent: 10,
                                                          thickness: 1),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            hotel[i]["place"],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Wrap(
                                                              spacing: 2,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                  size: 18,
                                                                ),
                                                                Text(hotel[i]
                                                                    ["rating"])
                                                              ]),
                                                        ],
                                                      ),
                                                    ]),
                                              ),
                                            )),
                                          ]),
                                    ),
                                  ),
                                );
                              } catch (e) {
                                print(e);
                              }
                              return Container();
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Hotel()));
                                  },
                                  child: Text(
                                    "See All >>",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 246, 113, 103)),
                                  )),
                            )
                          ],
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 15.0),
                        //   child: Text(
                        //     "THINGS TO DO",
                        //     style: TextStyle(
                        //         fontSize: 20, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 10),
                          child: Text(
                            "PHOTOGRAPHY",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoGraphy()));
                            },
                            child: Container(
                              width: double.infinity,
                              child: Image.asset(
                                "images/img.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 237, 91, 80),
              ));
            }));
  }
}
