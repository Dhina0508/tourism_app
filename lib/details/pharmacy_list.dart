import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/place_details.dart';

class Pharmacy_list extends StatefulWidget {
  var value;
  var name;
  Pharmacy_list({this.value, this.name});

  @override
  State<Pharmacy_list> createState() => _Pharmacy_listState();
}

class _Pharmacy_listState extends State<Pharmacy_list> {
  List ph = [];
  //Future<List<QueryDocumentSnapshot<Object?>>>
  getpharmacydata() async {
    var id = widget.value.toString();
    var collection = widget.name;
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection("tourism")
        .doc(id.trim())
        .collection(collection)
        .orderBy("name", descending: false)
        .get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["about"] == "ph") {
          ph.add({
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
    getpharmacydata();
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
        title: Text("Pharmacy"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 251, 116, 106),
      ),
      body: Column(
        children: [
          ph.length > 1
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemExtent: 100,
                  itemCount: ph.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlaceDetails(
                                      lat: ph[i]["lat"],
                                      long: ph[i]["long"],
                                      address: ph[i]["address"],
                                      des: ph[i]["des"],
                                      entry: ph[i]["entry"],
                                      img: ph[i]["img"],
                                      name: ph[i]["name"],
                                      phno: ph[i]["phno"],
                                      rating: ph[i]["rating"],
                                      time: ph[i]["time"],
                                    )));
                      },
                      title: Text(
                        ph[i]["name"],
                      ),
                      subtitle: Container(
                        child: Wrap(
                          spacing: 2, // space between two icons
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ), // icon-1
                            Text(
                              ph[i]["rating"],
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
                            ph[i]["img"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                    // return Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: GestureDetector(
                    //     onTap: () async {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => PlaceDetails(
                    //                     lat: ph[i]["lat"],
                    //                     long: ph[i]["long"],
                    //                     address: ph[i]["address"],
                    //                     des: ph[i]["des"],
                    //                     entry: ph[i]["entry"],
                    //                     img: ph[i]["img"],
                    //                     name: ph[i]["name"],
                    //                     phno: ph[i]["phno"],
                    //                     rating: ph[i]["rating"],
                    //                     time: ph[i]["time"],
                    //                   )));
                    //     },
                    //     child: Card(
                    //       elevation: 10,
                    //       child: Container(
                    //         child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               Expanded(
                    //                   child: Container(
                    //                 decoration: BoxDecoration(
                    //                     image: DecorationImage(
                    //                         image: NetworkImage(
                    //                           ph[i]["img"],
                    //                         ),
                    //                         fit: BoxFit.cover)),
                    //               )),
                    //               Expanded(
                    //                   child: Container(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceEvenly,
                    //                       children: [
                    //                         Text(
                    //                           ph[i]["name"],
                    //                         ),
                    //                         Wrap(spacing: 2, children: [
                    //                           Icon(
                    //                             Icons.star,
                    //                             color: Colors.amber,
                    //                             size: 18,
                    //                           ),
                    //                           Text(ph[i]["rating"])
                    //                         ]),
                    //                       ]),
                    //                 ),
                    //               )),
                    //             ]),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  })
              : Column(
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    Center(
                      child: Text(
                        "Not yet uploaded",
                        style:
                            TextStyle(fontSize: 15, fontFamily: 'Josefinsans'),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
