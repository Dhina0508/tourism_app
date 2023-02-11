import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/place_list.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List home = [];
  Future<List<QueryDocumentSnapshot<Object?>>> getdata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("tourism").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        home.add({
          "x": qn.docs[i]["id"],
          "name": qn.docs[i]["name"],
          "img": qn.docs[i]["img"]
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
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < home.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaceList(
                                            value: home[i]["x"],
                                            name: home[i]["name"],
                                            img: home[i]["img"],
                                          )));
                            },
                            child: Image.network(
                              home[i]["img"],
                              fit: BoxFit.cover,
                              width: 400,
                              height: 250,
                            ),
                          ),
                          Text(home[i]["name"]),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
