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
    return Scaffold(
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
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Stack(children: [
              Image.network(
                widget.img,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        widget.name + "...",
                        style: TextStyle(
                            fontFamily: "Splash",
                            fontSize: 60,
                            color: Colors.white),
                      ),
                    ],
                  )),
            ]),
            // Text(
            //   widget.name + " Welcome's you ! ",
            //   style: TextStyle(fontSize: 35, fontFamily: "Pacifico"),
            // ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemExtent: 100,
                itemCount: places.length,
                itemBuilder: (context, i) {
                  return ListTile(
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
                    title: Text(
                      places[i]["name"],
                    ),
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
                            places[i]["rating"],
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
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
                          places[i]["img"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
          ]),
        ));
  }
}
