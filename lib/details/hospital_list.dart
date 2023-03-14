import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/place_details.dart';

class HospitalList extends StatefulWidget {
  var value;
  var name;
  HospitalList({this.value, this.name});

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  List hp = [];
  //Future<List<QueryDocumentSnapshot<Object?>>>
  gethospitaldata() async {
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
        if (qn.docs[i]["about"] == "hp") {
          hp.add({
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
    gethospitaldata();
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
        title: Text("Hospitals"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 251, 116, 106),
      ),
      body: Column(
        children: [
          hp.length > 1
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemExtent: 100,
                  itemCount: hp.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlaceDetails(
                                      lat: hp[i]["lat"],
                                      long: hp[i]["long"],
                                      address: hp[i]["address"],
                                      des: hp[i]["des"],
                                      entry: hp[i]["entry"],
                                      img: hp[i]["img"],
                                      name: hp[i]["name"],
                                      phno: hp[i]["phno"],
                                      rating: hp[i]["rating"],
                                      time: hp[i]["time"],
                                    )));
                      },
                      title: Text(
                        hp[i]["name"],
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
                              hp[i]["rating"],
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
                            hp[i]["img"],
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
                    //                     lat: hp[i]["lat"],
                    //                     long: hp[i]["long"],
                    //                     address: hp[i]["address"],
                    //                     des: hp[i]["des"],
                    //                     entry: hp[i]["entry"],
                    //                     img: hp[i]["img"],
                    //                     name: hp[i]["name"],
                    //                     phno: hp[i]["phno"],
                    //                     rating: hp[i]["rating"],
                    //                     time: hp[i]["time"],
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
                    //                           hp[i]["img"],
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
                    //                           hp[i]["name"],
                    //                         ),
                    //                         Wrap(spacing: 2, children: [
                    //                           Icon(
                    //                             Icons.star,
                    //                             color: Colors.amber,
                    //                             size: 18,
                    //                           ),
                    //                           Text(hp[i]["rating"])
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
