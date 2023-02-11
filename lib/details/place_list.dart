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
          "time": qn.docs[i]["time"]
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
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        Container(
          child: Image.network(widget.img),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemExtent: 100.0,
            itemCount: places.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceDetails(
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
                title: Text(
                  places[i]["name"],
                ),
                trailing: Container(
                  child: Text(places[i]["rating"]),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    places[i]["img"],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
      ]),
    ));
  }
}
