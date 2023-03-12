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
              "images/1678558969219.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/1678558969231.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/1678558969245.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/1678558969258.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/1678558969272.jpg",
              fit: BoxFit.cover,
            ),
            Image.network(
              "https://static.toiimg.com/thumb/msid-92089121,width-748,height-499,resizemode=4,imgsize-139308/Most-beautiful-places-to-visit-in-India-for-first-timers.jpg",
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
