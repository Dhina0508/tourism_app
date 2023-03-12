import 'package:flutter/material.dart';

class Settingss extends StatelessWidget {
  const Settingss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListTile(
          onTap: () {},
          title: Text("About"),
          leading: Icon(Icons.account_box_outlined,
              color: Color.fromARGB(255, 246, 120, 111)),
        ),
      ),
    );
  }
}
