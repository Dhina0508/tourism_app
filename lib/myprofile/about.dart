import 'dart:math';

import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "About",
                style: TextStyle(
                    fontFamily: "JosefinSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "                 This is the Application which act as a Virtual Tourist Guide. It Guide the user to Visit only the value and Worth places which are more famous in that specific District. This Application contains the list of Best Hotels and Restaurant to take a healthy food and to have good Stay.",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade800,
                  letterSpacing: 1.2),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "For the Emergency purpose, this application provide the nearby Pharmacy as well as Hospitals.",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade800,
                  letterSpacing: 1.2),
            )
          ],
        ),
      ),
    );
  }
}
