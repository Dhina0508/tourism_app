import 'package:flutter/material.dart';

class Rental extends StatefulWidget {
  Rental({Key? key}) : super(key: key);

  @override
  State<Rental> createState() => _RentalState();
}

class _RentalState extends State<Rental> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Not yet uploaded",
          style: TextStyle(fontSize: 15, fontFamily: 'Josefinsans'),
        ),
      ),
    );
  }
}
