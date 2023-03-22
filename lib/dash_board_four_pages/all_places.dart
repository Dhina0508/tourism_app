import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism/details/place_list.dart';

class AllPlaces extends StatefulWidget {
  AllPlaces({Key? key}) : super(key: key);

  @override
  State<AllPlaces> createState() => _AllPlacesState();
}

class _AllPlacesState extends State<AllPlaces> {
  List p = [];
  // Future<List<QueryDocumentSnapshot<Object?>>>
  getplacedata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("tourism").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        p.add({
          "name": qn.docs[i]["name"],
          "img": qn.docs[i]["img"],
          "x": qn.docs[i]["id"]
        });
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
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Places",
            style: TextStyle(fontFamily: "Cinzel", color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: p.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlaceList(
                                  value: p[i]["x"],
                                  name: p[i]["name"],
                                  img: p[i]["img"],
                                )));
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Image.network(
                            p[i]["img"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(245, 149, 183, 213),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          p[i]["name"],
                          style: TextStyle(fontFamily: "Cinzel", fontSize: 20),
                        )),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
