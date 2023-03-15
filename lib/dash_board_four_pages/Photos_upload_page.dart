import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Photography extends StatefulWidget {
  Photography({Key? key}) : super(key: key);

  @override
  State<Photography> createState() => _PhotographyState();
}

class _PhotographyState extends State<Photography> {
  bool tap = false;
  ImagePicker image = ImagePicker();
  File? file;

  String url = "";
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  geting_Photo() async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imageFile =
        FirebaseStorage.instance.ref().child("Photography").child(name);

    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    final _CollectionReference =
        FirebaseFirestore.instance.collection("Photography").doc();
    return _CollectionReference.set({
      "img": url,
      "Time": DateTime.now(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Photos Has Been Posted Successfully"),
        behavior: SnackBarBehavior.floating,
      ));
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget tripPhotos = new StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Photography').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text(
                'Error in receiving trip photos: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Not connected to the Stream or null');

            case ConnectionState.waiting:
              return new Text('Awaiting for interaction');

            case ConnectionState.active:
              print("Stream has started but not finished");

              var totalPhotosCount = 0;
              List<DocumentSnapshot> tripPhotos;

              if (snapshot.hasData) {
                tripPhotos = snapshot.data!.docs;
                totalPhotosCount = tripPhotos.length;

                if (totalPhotosCount > 0) {
                  return new GridView.builder(
                      itemCount: totalPhotosCount,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Card(
                            child: Container(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                  ClipRect(
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        heightFactor: 0.7,
                                        child: new CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 243, 121, 112)),
                                          imageUrl: tripPhotos[index]["img"],
                                        )),
                                  ),
                                ])),
                          ),
                        );
                      });
                }
              }

              return new Center(
                  child: Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  new Text("No trip photos found.")
                ],
              ));

            case ConnectionState.done:
              return new Text('Streaming is done');
          }

          // return Container(
          //   child: new Text("No trip photos found."),
          // );
        });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed("Dashboard");
            },
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Share your View",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "JosefinSans"),
        ),
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            Column(
              children: [
                InkWell(
                  onTap: () {
                    getImage();
                    ontap();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: file == null
                        ? NetworkImage(
                            "https://t3.ftcdn.net/jpg/03/66/66/62/360_F_366666222_DCAdZ5uHSl1ckP1jbHVq7uzO8CFKvmhy.jpg")
                        : tap == false
                            ? NetworkImage(
                                "https://t3.ftcdn.net/jpg/03/66/66/62/360_F_366666222_DCAdZ5uHSl1ckP1jbHVq7uzO8CFKvmhy.jpg")
                            : FileImage(File(file!.path)) as ImageProvider,
                    radius: 40,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      geting_Photo();
                      setState(() {
                        ontap();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Photography()));
                      });
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Color.fromARGB(255, 246, 121, 112),
                          fontSize: 15),
                    )),
              ],
            ),
            tripPhotos,
          ],
        ),
      ),
    );
  }

  ontap() {
    setState(() {
      tap = !tap;
    });
  }
}
