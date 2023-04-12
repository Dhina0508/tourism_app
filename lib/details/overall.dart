import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/hospital_list.dart';
import 'package:tourism/details/hotel_particular_place.dart';
import 'package:tourism/details/pharmacy_list.dart';
import 'package:tourism/details/place_list.dart';
import 'package:tourism/details/rental_list.dart';
import 'package:tourism/details/special.dart';
import 'package:tourism/details/themepark.dart';
import 'package:tourism/details/train.dart';

class OverAll extends StatefulWidget {
  var value;
  var name;
  var img;
  OverAll({this.value, this.name, this.img});

  @override
  State<OverAll> createState() => _OverAllState();
}

class _OverAllState extends State<OverAll> {
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpecialList(
                                name: widget.name,
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 0.9)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          "Special at " + widget.name,
                          style: TextStyle(
                              fontFamily: "JosefinSans",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceList(
                                name: widget.name,
                                value: widget.value,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.white,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                child: Image.asset(
                              "images/3.jpg",
                              fit: BoxFit.cover,
                              height: 130,
                              width: 350,
                            )),
                          ),
                          Align(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                ),
                                Container(
                                  height: 30,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      "Must Visit Places",
                                      style: TextStyle(
                                          fontFamily: "JosefinSans",
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Hotel_Particular_Place_List(
                                    value: widget.value,
                                    name: widget.name,
                                  )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  child: Image.asset(
                                "images/hotel.jpeg",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              )),
                            ),
                            Align(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    height: 30,
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        "Hotel",
                                        style: TextStyle(
                                            fontFamily: "JosefinSans",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentalList(
                                    value: widget.value,
                                    name: widget.name,
                                  )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Card(
                        elevation: 10,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  child: Image.asset(
                                "images/c.png",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              )),
                            ),
                            Align(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 150,
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        "Rental Shop",
                                        style: TextStyle(
                                            fontFamily: "JosefinSans",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HospitalList(
                                    name: widget.name,
                                  )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  child: Image.asset(
                                "images/ho.jpg",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              )),
                            ),
                            Align(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    height: 30,
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: "JosefinSans",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Pharmacy_list(
                                    name: widget.name,
                                  )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Card(
                        elevation: 10,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  child: Image.asset(
                                "images/p.jpg",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              )),
                            ),
                            Align(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 150,
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        "Pharmacy",
                                        style: TextStyle(
                                            fontFamily: "JosefinSans",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThemeParkList(
                                    name: widget.name,
                                  )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  child: Image.asset(
                                "images/t.jpg",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              )),
                            ),
                            Align(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    height: 30,
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        "Theme Park",
                                        style: TextStyle(
                                            fontFamily: "JosefinSans",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Train()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Card(
                        elevation: 10,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  child: Image.asset(
                                "images/tr.jpg",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              )),
                            ),
                            Align(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 150,
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        "Train Timing",
                                        style: TextStyle(
                                            fontFamily: "JosefinSans",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
