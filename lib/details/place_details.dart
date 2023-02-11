import 'package:flutter/material.dart';

class PlaceDetails extends StatefulWidget {
  var img;
  var name;
  var rating;
  var entry;
  var des;
  var address;
  var time;
  var phno;
  PlaceDetails(
      {this.address,
      this.des,
      this.entry,
      this.img,
      this.name,
      this.phno,
      this.rating,
      this.time});

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(widget.img),
          Text(widget.name),
          Text(widget.address),
          Text(widget.des),
          Text(widget.entry),
          Text(widget.phno),
          Text(widget.time),
          Text(widget.rating)
        ],
      ),
    );
  }
}
