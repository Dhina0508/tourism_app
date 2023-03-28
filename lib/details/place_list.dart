import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/dash_board_four_pages/hotel.dart';
import 'package:tourism/details/hospital_list.dart';
import 'package:tourism/details/hotel_particular_place.dart';
import 'package:tourism/details/pharmacy_list.dart';
import 'package:tourism/details/place_details.dart';
import 'package:tourism/details/rental_list.dart';
import 'package:tourism/helper/icons.dart';

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
        .orderBy("name", descending: false)
        .where("about", isEqualTo: null)
        .get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["about"] == "") {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                    builder: (context) =>
                                        Hotel_Particular_Place_List(
                                          value: widget.value,
                                          name: widget.name,
                                        )));
                          },
                          child: DashBoardIcon(
                            icon: Icons.hotel,
                            text: "Hotels",
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HospitalList(
                                        name: widget.name,
                                      )));
                        },
                        child: DashBoardIcon(
                            icon: Icons.add_home_work_outlined,
                            text: "Hospital"),
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
                        child: DashBoardIcon(
                            icon: Icons.local_hospital_sharp, text: "Pharmacy"),
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
                        child: DashBoardIcon(
                          text: "Rental",
                          icon: Icons.directions_bike_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => HospitalList(
                //                       value: widget.value,
                //                       name: widget.name,
                //                     )));
                //       },
                //       child: Container(
                //         height: 35,
                //         width: 110,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Color.fromARGB(255, 250, 122, 113),
                //             width: 2,
                //           ),
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //         child: Center(
                //             child: Text(
                //           "Hospital",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontFamily: "JosefinSans"),
                //         )),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => Pharmacy_list(
                //                       value: widget.value,
                //                       name: widget.name,
                //                     )));
                //       },
                //       child: Container(
                //         height: 35,
                //         width: 110,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(30),
                //           border: Border.all(
                //             color: Color.fromARGB(255, 250, 122, 113),
                //             width: 2,
                //           ),
                //         ),
                //         child: Center(
                //             child: Text(
                //           "Pharmacy",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontFamily: "JosefinSans"),
                //         )),
                //       ),
                //     ),
                //   ],
                // ),

                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 15, right: 15),
                  child: Text(
                    "Places",
                    style: TextStyle(fontFamily: "Cinzel", fontSize: 25),
                  ),
                ),

                places.length > 1
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: places.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                var id = widget.value.toString();
                                var collection = widget.name;

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
                                            id: id.toString(),
                                            collection:
                                                collection.toString())));
                              },
                              child: Card(
                                elevation: 10,
                                child: Container(
                                  height: 100,
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
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "JosefinSans",
                                                        fontSize: 17),
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
                          SizedBox(height: 175),
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
