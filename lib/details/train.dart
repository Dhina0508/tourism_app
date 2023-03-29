import 'package:flutter/material.dart';

class Train extends StatefulWidget {
  Train({Key? key}) : super(key: key);

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Not yet Uploaded"),
      ),
    );
  }
}
