import 'package:flutter/material.dart';

class DashBoardIcon extends StatelessWidget {
  IconData icon;
  String text;
  DashBoardIcon({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
      height: 70,
      width: 65,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 35,
            color: Color.fromARGB(255, 248, 119, 110),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      )),
    );
  }
}
