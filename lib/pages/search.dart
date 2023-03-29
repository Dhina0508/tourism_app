import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/details/overall.dart';
import 'package:tourism/details/place_list.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? name;
  String? img;

  _SearchState({
    this.name,
    this.img,
  });

  String? _InputText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Search Places',
          style: TextStyle(
              fontFamily: "Josefinsans",
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: ((value) {
                  setState(() {
                    _InputText = value;
                  });
                }),
                decoration: InputDecoration(
                    hintText: 'Search ', suffixIcon: Icon(Icons.search)),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('tourism')
                          .where('name',
                              isEqualTo: _InputText?.toLowerCase().capitalize)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data?.docs[index]['name'];
                              String img = snapshot.data?.docs[index]['img'];
                              String x = snapshot.data?.docs[index]["id"];

                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Card(
                                  elevation: 3,
                                  child: ListTile(
                                    title: Text(name),
                                    leading: Container(
                                      child: Image.network(
                                        img,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        width: 100,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OverAll(
                                                    value: x,
                                                    name: name,
                                                    img: img,
                                                  )));
                                    },
                                  ),
                                ),
                              );
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
