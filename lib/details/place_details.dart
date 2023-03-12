import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

class PlaceDetails extends StatefulWidget {
  var img;
  var name;
  var rating;
  var entry;
  var des;
  var address;
  var time;
  var lat;
  var long;
  var phno;
  PlaceDetails(
      {this.address,
      this.des,
      this.entry,
      this.img,
      this.name,
      this.phno,
      this.rating,
      this.lat,
      this.long,
      this.time});

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

bool tap = true;
var change = "";

class _PlaceDetailsState extends State<PlaceDetails> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.img,
              fit: BoxFit.cover,
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
                      backgroundColor: Color.fromARGB(255, 245, 121, 112),
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
                      Share.share(widget.name);
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
              height: 10,
            ),
            TabBar(
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.red,
              automaticIndicatorColorAdjustment: true,
              labelColor: Colors.red,
              tabs: [
                Tab(
                  text: "Info",
                ),
                Tab(
                  text: "Description",
                ),
                Tab(
                  text: "Photos",
                ),
              ],
            ), // TabBar
            Expanded(
                child: TabBarView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            child: Text(widget.address,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.help_outline_outlined),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(thickness: 1),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.call),
                        SizedBox(
                          width: 20,
                        ),
                        Text(widget.phno,
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Entry: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "JosefinSans",
                                color: Color.fromARGB(255, 250, 134, 126))),
                        Text("Rs: " + widget.entry,
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description: ",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "JosefinSans",
                            color: Color.fromARGB(255, 250, 134, 126))),
                    Text("  " + widget.des,
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
              Container(
                child: Image.network(widget.img),
              )
            ]))
            // Padding(
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Address: ",
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontFamily: "JosefinSans",
            //               color: Color.fromARGB(255, 250, 134, 126))),
            //       Text("  " + widget.address,
            //           style: TextStyle(
            //             fontSize: 15,
            //           )),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   child: Row(
            //     children: [
            //       Text("Contact: ",
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontFamily: "JosefinSans",
            //               color: Color.fromARGB(255, 250, 134, 126))),
            //       Text(widget.phno,
            //           style: TextStyle(
            //             fontSize: 15,
            //           )),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   child: Row(
            //     children: [
            //       Text("Entry: ",
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontFamily: "JosefinSans",
            //               color: Color.fromARGB(255, 250, 134, 126))),
            //       Text("Rs: " + widget.entry,
            //           style: TextStyle(
            //             fontSize: 15,
            //           )),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Description: ",
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontFamily: "JosefinSans",
            //               color: Color.fromARGB(255, 250, 134, 126))),
            //       Text("  " + widget.des,
            //           style: TextStyle(
            //             fontSize: 15,
            //           )),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   child: Row(
            //     children: [
            //       Text("Overall Rating: ",
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontFamily: "JosefinSans",
            //               color: Color.fromARGB(255, 250, 134, 126))),
            //       Text(widget.rating,
            //           style: TextStyle(
            //             fontSize: 15,
            //           )),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
    );
  }

  void fav_icon() {
    setState(() {
      tap = !tap;
    });
  }
}
