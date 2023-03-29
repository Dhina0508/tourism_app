import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/hospital_full.dart';
import 'package:tourism/details/place_details.dart';
import 'package:tourism/details/themeparkdetail.dart';

class ThemeParkList extends StatefulWidget {
  var name;
  ThemeParkList({this.name});

  @override
  State<ThemeParkList> createState() => _ThemeParkListState();
}

class _ThemeParkListState extends State<ThemeParkList> {
  List ph = [];
  //Future<List<QueryDocumentSnapshot<Object?>>>
  getthemeparkdata() async {
    var collection = widget.name;
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("themepark").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["about"] == widget.name) {
          ph.add({
            "name": qn.docs[i]["name"],
            "about": qn.docs[i]["about"],
            "img": qn.docs[i]["img"],
            "address": qn.docs[i]["address"],
            "entry": qn.docs[i]["entry"],
            "phno": qn.docs[i]["phno"],
            "rating": qn.docs[i]["rating"],
            "time": qn.docs[i]["time"],
            "lat": qn.docs[i]["lat"],
            "long": qn.docs[i]["long"],
            "id": qn.docs[i]["id"]
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
    getthemeparkdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Theme Park at " + widget.name,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Cinzel",
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 251, 116, 106),
      ),
      body: ph.length >= 1
          ? SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: ph.length,
                      itemBuilder: (context, i) {
                        // return ListTile(
                        //   onTap: () async {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => PlaceDetails(
                        //                   lat: ph[i]["lat"],
                        //                   long: ph[i]["long"],
                        //                   address: ph[i]["address"],
                        //                   des: ph[i]["des"],
                        //                   entry: ph[i]["entry"],
                        //                   img: ph[i]["img"],
                        //                   name: ph[i]["name"],
                        //                   phno: ph[i]["phno"],
                        //                   rating: ph[i]["rating"],
                        //                   time: ph[i]["time"],
                        //                 )));
                        //   },
                        //   title: Text(
                        //     ph[i]["name"],
                        //   ),
                        //   subtitle: Container(
                        //     child: Wrap(
                        //       spacing: 2, // space between two icons
                        //       children: [
                        //         Icon(
                        //           Icons.star,
                        //           color: Colors.amber,
                        //           size: 18,
                        //         ), // icon-1
                        //         Text(
                        //           ph[i]["rating"],
                        //           style: TextStyle(
                        //               fontSize: 14, fontWeight: FontWeight.bold),
                        //         ) // icon-2
                        //       ],
                        //     ),
                        //   ),
                        //   leading: SizedBox(
                        //     height: 250,
                        //     width: 130,
                        //     child: ConstrainedBox(
                        //       constraints: BoxConstraints(
                        //           maxHeight: 250,
                        //           maxWidth: 200,
                        //           minHeight: 100,
                        //           minWidth: 100),
                        //       child: Image.network(
                        //         ph[i]["img"],
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // );
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThemeParkFull(
                                            lat: ph[i]["lat"],
                                            long: ph[i]["long"],
                                            address: ph[i]["address"],
                                            img: ph[i]["img"],
                                            entry: ph[i]["entry"],
                                            name: ph[i]["name"],
                                            phno: ph[i]["phno"],
                                            rating: ph[i]["rating"],
                                            time: ph[i]["time"],
                                            id: ph[i]["id"],
                                          )));
                            },
                            child: Card(
                              elevation: 10,
                              child: Container(
                                height: 90,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  ph[i]["img"],
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  ph[i]["name"],
                                                ),
                                                Wrap(spacing: 2, children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                  Text(ph[i]["rating"])
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
                ],
              ),
            )
          : Center(
              child: Text(
                "Not yet uploaded",
                style: TextStyle(fontSize: 15, fontFamily: 'Josefinsans'),
              ),
            ),
    );
  }
}
