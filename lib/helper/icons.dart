import 'package:flutter/material.dart';

class DashBoardIcon extends StatelessWidget {
  IconData icon;
  DashBoardIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade200),
        height: 65,
        width: 60,
        child: Center(
            child: Icon(
          icon,
          size: 35,
          color: Color.fromARGB(255, 248, 119, 110),
        )),
      ),
    );
  }
}
