import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tourism/dash_board_four_pages/Photos_upload_page.dart';
import 'package:tourism/dash_board_four_pages/all_places.dart';
import 'package:tourism/dash_board_four_pages/hotel.dart';
import 'package:tourism/details/hotel_full.dart';
import 'package:tourism/details/overall.dart';
import 'package:tourism/details/place_list.dart';
import 'package:tourism/helper/icons.dart';
import 'package:tourism/map/current_loc.dart';
import 'package:tourism/pages/myprofile.dart';
import 'package:tourism/pages/search.dart';

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
      for (int j = 0; j < 3; j++) {
        hotel.add({
          "name": qn.docs[j]["name"],
          "img": qn.docs[j]["img"],
          "place": qn.docs[j]["place"],
          "rating": qn.docs[j]["rating"],
          "address": qn.docs[j]["address"],
          "cost": qn.docs[j]["cost"],
          "details": qn.docs[j]["details"],
          "phno": qn.docs[j]["phno"],
          "lat": qn.docs[j]["lat"],
          "long": qn.docs[j]["long"],
          "hotel_email": qn.docs[j]["email"],
          "time": qn.docs[j]["time"]
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
    return Scaffold(
        body: SingleChildScrollView(
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
                    autoPlayAnimationDuration: Duration(milliseconds: 900),
                    viewportFraction: 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, carouselPageChangedReason) {
                      _DotPosition = val;
                    }),
              ),
              Align(
                alignment: Alignment.bottomCenter,
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
                                  "Tamilnadu,India",
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text("Welcome,",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            FirebaseAuth.instance.currentUser!.displayName
                                .toString(),
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.redAccent,
                                fontFamily: "Cinzel"),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 30),
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 15),
              child: Text(
                "BEST PLACES ",
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
                                    builder: (context) => OverAll(
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
                              child: CachedNetworkImage(
                                imageUrl: home[i]["img"],
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                height: 250,
                                width: 250,
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
                                          builder: (context) => OverAll(
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
                                builder: (context) => AllPlaces()));
                      },
                      child: Text(
                        "See All >>",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 246, 113, 103)),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "POPULAR HOTELS",
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
                itemCount: hotel.length,
                itemBuilder: (context, i) {
                  try {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HotelFullDetails(
                                        address: hotel[i]["address"],
                                        cost: hotel[i]["cost"],
                                        details: hotel[i]["details"],
                                        time: hotel[i]["time"],
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
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(18, 249, 144, 141),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: Container(
                                  child: CachedNetworkImage(
                                    imageUrl: hotel[i]["img"],

                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    height: 250, width: 250, fit: BoxFit.cover,
                                    // 100MB
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            hotel[i]["name"],
                                            style: TextStyle(
                                                fontFamily: "JosefinSans"),
                                          ),
                                          Divider(
                                              color: Color.fromARGB(
                                                  255, 239, 64, 51),
                                              endIndent: 10,
                                              indent: 10,
                                              thickness: 1),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                hotel[i]["place"],
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade800),
                                              ),
                                              Wrap(spacing: 2, children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 18,
                                                ),
                                                Text(hotel[i]["rating"])
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Hotel()));
                      },
                      child: Text(
                        "See All >>",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 246, 113, 103)),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10),
              child: Text(
                "PHOTOGRAPHY",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Photography()));
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
            // SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Text(
            //     "EXPLORE THE BEAUTIFUL WORLD !",
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => AllPlaces()));
            //       },
            //       child: Container(
            //         height: 50,
            //         width: 150,
            //         decoration: BoxDecoration(
            //             color: Color.fromARGB(42, 244, 125, 117),
            //             borderRadius: BorderRadius.circular(10),
            //             border: Border.all(
            //                 color: Color.fromARGB(255, 237, 112, 103),
            //                 width: 0.5)),
            //         child: Center(
            //             child: Text(
            //           "Places",
            //           style: TextStyle(
            //               fontFamily: "JosefinSans",
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold),
            //         )),
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => Hotel()));
            //       },
            //       child: Container(
            //         height: 50,
            //         width: 150,
            //         child: Center(
            //             child: Text(
            //           "Hotels",
            //           style: TextStyle(
            //               fontFamily: "JosefinSans",
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold),
            //         )),
            //         decoration: BoxDecoration(
            //             color: Color.fromARGB(42, 244, 125, 117),
            //             borderRadius: BorderRadius.circular(10),
            //             border: Border.all(
            //                 color: Color.fromARGB(255, 237, 112, 103),
            //                 width: 0.5)),
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       onTap: () {},
            //       child: Container(
            //         height: 50,
            //         width: 150,
            //         decoration: BoxDecoration(
            //             color: Color.fromARGB(42, 244, 125, 117),
            //             borderRadius: BorderRadius.circular(10),
            //             border: Border.all(
            //                 color: Color.fromARGB(255, 237, 112, 103),
            //                 width: 0.5)),
            //         child: Center(
            //             child: Text(
            //           "Emergency",
            //           style: TextStyle(
            //               fontFamily: "JosefinSans",
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold),
            //         )),
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {},
            //       child: Container(
            //         height: 50,
            //         width: 150,
            //         child: Center(
            //             child: Text(
            //           "Rental",
            //           style: TextStyle(
            //               fontFamily: "JosefinSans",
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold),
            //         )),
            //         decoration: BoxDecoration(
            //             color: Color.fromARGB(42, 244, 125, 117),
            //             borderRadius: BorderRadius.circular(10),
            //             border: Border.all(
            //                 color: Color.fromARGB(255, 237, 112, 103),
            //                 width: 0.5)),
            //       ),
            //     )
            //   ],
            // ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "THINGS TO DO",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Stack(children: [
                      Container(
                          width: 210,
                          height: 210,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              child: Image.asset(
                                "images/a.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Text(
                                "Trekking",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: "Cinzel"),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Stack(children: [
                      Container(
                          width: 210,
                          height: 210,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              child: Image.asset(
                                "images/b.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Text(
                                "Camping",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: "Cinzel"),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(children: [
                      Container(
                          width: 210,
                          height: 210,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              child: Image.asset(
                                "images/c.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Parasailing",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: "Cinzel"),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Stack(children: [
                      Container(
                          width: 210,
                          height: 210,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              child: Image.asset(
                                "images/d.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Text(
                                "Heritage Tour",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: "Cinzel"),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Stack(children: [
                      Container(
                          width: 210,
                          height: 210,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              child: Image.asset(
                                "images/e.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Text(
                                "Scuba Diving",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: "Cinzel"),
                              ),
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
            )
          ],
        ),
      ),
    ));
  }
}
