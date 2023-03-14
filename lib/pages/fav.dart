import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/place_details.dart';

class Fav extends StatefulWidget {
  Fav({Key? key}) : super(key: key);

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Favourite",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "JosefinSans"),
          )),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("fav_places")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("places")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            try {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Image.asset(
                  "images/fav.png",
                  fit: BoxFit.cover,
                  color: Colors.white70.withOpacity(0.3),
                  colorBlendMode: BlendMode.modulate,
                ));
              } else {
                return ListView.builder(
                  itemExtent: 100,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        // margin:
                        //     EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                          child: Container(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                Container(
                                  width: 150,
                                  height: 100,
                                  child: Image.network(
                                    _documentSnapshot['img'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                            _documentSnapshot['name'],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 18,
                                                ),
                                                Text(" " +
                                                    _documentSnapshot[
                                                        'rating']),
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                )),
                                Container(
                                  width: 100,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("fav_places")
                                                .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                .collection("places")
                                                .doc(_documentSnapshot.id)
                                                .delete();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Container(
                                                padding: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Text(
                                                  "Placed removed from Fav",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              behavior: SnackBarBehavior.fixed,
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                            ));
                                          },
                                          icon: Icon(
                                              Icons.remove_circle_outlined))
                                    ],
                                  ),
                                ),
                              ])),
                        ),
                      ),
                    );
                  },
                );
              }
            } catch (e) {
              print(e);
            }
            return Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 250, 101, 91),
            ));
          }),
    );
  }
}
