import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoGraphy extends StatefulWidget {
  PhotoGraphy({Key? key}) : super(key: key);

  @override
  State<PhotoGraphy> createState() => _PhotoGraphyState();
}

class _PhotoGraphyState extends State<PhotoGraphy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "World Wide PhotoGraphy",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 246, 117, 107),
                fontFamily: "JosefinSans"),
          ),
          centerTitle: true,
        ),
        body: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: [
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/fav.png",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome2.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/welcome5.jpg",
              fit: BoxFit.cover,
            ),
          ],
        ));
  }
}
