import 'package:flutter/material.dart';

class Vendor extends StatefulWidget {
  Vendor({Key? key}) : super(key: key);

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("VENDOR"),
      ),
    );
  }
}
