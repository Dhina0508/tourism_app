import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? _InputText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 110, 110),
        title: Text('Search Places'),
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
                          .where('name', isEqualTo: _InputText)
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

                              return CardItem(
                                img: img,
                                name: name,
                                // rating: rate,
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

class CardItem extends StatefulWidget {
  String? name;
  String? img;

  CardItem({
    this.name,
    this.img,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(widget.name!),
          leading: Container(
            child: Image.network(
              widget.img!,
              height: 100,
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
