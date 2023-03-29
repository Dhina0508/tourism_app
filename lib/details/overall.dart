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
              // Padding(
              //   padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
              //   child: Text(
              //     "Sights",
              //     style: TextStyle(fontFamily: "Cinzel", fontSize: 25),
              //   ),
              // ),
              SizedBox(
                height: 25,
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          child: Image.asset(
                        "images/3.jpg",
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity,
                      )),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.temple_buddhist_outlined,
                                    size: 30,
                                  ),
                                  Text(
                                    "Visiting Place",
                                    style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          child: Image.asset(
                        "images/hotel.jpeg",
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity,
                      )),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.hotel,
                                    size: 30,
                                  ),
                                  Text(
                                    "Hotel",
                                    style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          child: Image.asset(
                        "images/c.png",
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity,
                      )),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.car_rental_sharp,
                                    size: 30,
                                  ),
                                  Text(
                                    "Rental Shop",
                                    style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HospitalList(
                                name: widget.name,
                              )));
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          child: Image.asset(
                        "images/h.jpeg",
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity,
                      )),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.medical_services_outlined,
                                    size: 30,
                                  ),
                                  Text(
                                    "Hospital",
                                    style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          child: Image.asset(
                        "images/p.jpg",
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity,
                      )),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.local_hospital,
                                    size: 30,
                                  ),
                                  Text(
                                    "Pharmacy",
                                    style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThemeParkList(
                                name: widget.name,
                              )));
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          child: Image.asset(
                        "images/t.jpg",
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity,
                      )),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.run_circle_outlined,
                                    size: 30,
                                  ),
                                  Text(
                                    "Theme Park",
                                    style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          child: Image.asset(
                        "images/img.jpg",
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity,
                      )),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.supervised_user_circle_sharp,
                                    size: 27,
                                  ),
                                  Text(
                                    "Special at " + widget.name,
                                    style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Train()));
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          child: Image.asset(
                        "images/tr.jpg",
                        fit: BoxFit.cover,
                        height: 120,
                        width: double.infinity,
                      )),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.train,
                                    size: 30,
                                  ),
                                  Text(
                                    "Train Timing",
                                    style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
