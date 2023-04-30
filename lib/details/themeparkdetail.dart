import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

class ThemeParkFull extends StatefulWidget {
  var img;
  var name;
  var rating;
  var entry;
  var address;
  var time;
  var lat;
  var long;
  var phno;
  var id;
  ThemeParkFull(
      {this.address,
      this.entry,
      this.img,
      this.name,
      this.phno,
      this.rating,
      this.lat,
      this.long,
      this.id,
      this.time});

  @override
  State<ThemeParkFull> createState() => _ThemeParkFullState();
}

bool tap = true;
var change = "";

class _ThemeParkFullState extends State<ThemeParkFull> {
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

  TextEditingController message = TextEditingController();
  sendmessage() async {
    var id = widget.id.toString();

    final _CollectionReference = FirebaseFirestore.instance
        .collection("themepark")
        .doc(id)
        .collection("messages")
        .doc();
    return _CollectionReference.set({
      "id": _CollectionReference.id,
      "name": FirebaseAuth.instance.currentUser!.displayName,
      "text": message.text,
      "time": DateTime.now().toString(),
      "about": "message"
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Review has been posted"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ));
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var id = widget.id.toString();

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection("themepark")
        .doc(id)
        .collection("messages")
        .snapshots();
    return DefaultTabController(
      length: 2,
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
            CachedNetworkImage(
              imageUrl: widget.img,
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 300,
              fit: BoxFit.cover,
              width: double.infinity,
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
                      Share.share("Image Url: " +
                          widget.img +
                          "  " +
                          "Name of the place: " +
                          widget.name +
                          "  " +
                          "Address: " +
                          widget.address +
                          "  ");
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
                  text: "Reviews",
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
                        Icon(Icons.location_on,
                            color: Color.fromARGB(255, 250, 134, 126)),
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
                  Divider(thickness: 0.5, color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.call,
                            color: Color.fromARGB(255, 250, 134, 126)),
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
                    thickness: 0.5,
                    color: Colors.black,
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
                    thickness: 0.5,
                    color: Colors.black,
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
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _usersStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          // if (snapshot.data!.docs.isEmpty) {
                          //   return Center(child: Text("No Review Found"));
                          // }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              var time = data["time"].substring(0, 10);

                              return Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Color.fromARGB(
                                              122, 250, 157, 150),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 7,
                                              bottom: 7),
                                          child: Text(
                                            data["text"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "-" + data["name"] + " at " + time,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              );
                              //
                            }).toList(),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                        controller: message,
                        decoration: InputDecoration(
                            hintText: "type..",
                            labelText: "Share your experience",
                            prefixIcon: Icon(Icons.note_alt_outlined),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  sendmessage();
                                  message.clear();
                                },
                                icon: Icon(Icons.send)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  )
                ],
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
