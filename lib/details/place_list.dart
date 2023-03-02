import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/place_details.dart';

class PlaceList extends StatefulWidget {
  var value;
  var name;
  var img;
  PlaceList({this.value, this.name, this.img});

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  List places = [];

  getdata() async {
    var id = widget.value.toString();
    var collection = widget.name;
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection("tourism")
        .doc(id.trim())
        .collection(collection)
        .get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        places.add({
          "name": qn.docs[i]["name"],
          "img": qn.docs[i]["img"],
          "address": qn.docs[i]["address"],
          "des": qn.docs[i]["des"],
          "entry": qn.docs[i]["entry"],
          "phno": qn.docs[i]["phno"],
          "rating": qn.docs[i]["rating"],
          "time": qn.docs[i]["time"],
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
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(220),
          child: AppBar(
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.img,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.name,
              style: TextStyle(
                  fontSize: 30, fontFamily: "Cinzel", color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios_new)),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                places.length > 1
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemExtent: 100,
                        itemCount: places.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlaceDetails(
                                              lat: places[i]["lat"],
                                              long: places[i]["long"],
                                              address: places[i]["address"],
                                              des: places[i]["des"],
                                              entry: places[i]["entry"],
                                              img: places[i]["img"],
                                              name: places[i]["name"],
                                              phno: places[i]["phno"],
                                              rating: places[i]["rating"],
                                              time: places[i]["time"],
                                            )));
                              },
                              child: Card(
                                elevation: 10,
                                child: Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    places[i]["img"],
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    places[i]["name"],
                                                  ),
                                                  Wrap(spacing: 2, children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 18,
                                                    ),
                                                    Text(places[i]["rating"])
                                                  ]),
                                                ]),
                                          ),
                                        )),
                                      ]),
                                ),
                              ),
                            ),
                          );
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
            )));
  }
}
