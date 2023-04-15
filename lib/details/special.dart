import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpecialList extends StatefulWidget {
  var name;
  SpecialList({this.name});
  @override
  State<SpecialList> createState() => _SpecialListState();
}

class _SpecialListState extends State<SpecialList> {
  List rental = [];
  // Future<List<QueryDocumentSnapshot<Object?>>>
  getplacedata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("special").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["about"] == widget.name) {
          rental.add({
            "item": qn.docs[i]["item"],
            "img": qn.docs[i]["img"],
            "about": qn.docs[i]["about"],
            "id": qn.docs[i]["id"],
          });
        }
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    getplacedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
              )),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 251, 116, 106),
          centerTitle: true,
          title: Text(
            "Special at " + widget.name,
            style: TextStyle(
              fontFamily: "Cinzel",
            ),
          )),
      body: rental.length >= 1
          ? Column(
              children: [
                SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: rental.length,
                        itemBuilder: (context, i) {
                          if (rental[i]["about"] == widget.name) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {},
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
                                            // child: CachedNetworkImage(
                                            //   imageUrl: rental[i]["img"],
                                            //   errorWidget:
                                            //       (context, url, error) =>
                                            //           Icon(Icons.error),
                                            //   fit: BoxFit.cover,
                                            // ),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        rental[i]["img"]),
                                                    fit: BoxFit.cover)),
                                          )),
                                          Expanded(
                                              child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      rental[i]["item"],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "JosefinSans",
                                                          fontSize: 17),
                                                    ),
                                                  ]),
                                            ),
                                          )),
                                        ]),
                                  ),
                                ),
                              ),
                            );
                          }
                        })),
              ],
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
