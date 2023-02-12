import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDirection extends StatefulWidget {
  var longitude;
  var latitude;
  var name;
  PlaceDirection({this.latitude, this.longitude, this.name});

  @override
  State<PlaceDirection> createState() => _PlaceDirectionState();
}

class _PlaceDirectionState extends State<PlaceDirection> {
  late GoogleMapController googleMapController;
  List<Marker> markers = [];
  @override
  void initState() {
    initalize();
    super.initState();
  }

  initalize() {
    Marker FirstMarker = Marker(
        markerId: MarkerId('place'),
        position: LatLng(
            double.parse(widget.latitude), double.parse(widget.longitude)),
        infoWindow: InfoWindow(title: widget.name, snippet: 'Place'),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));

    markers.add(FirstMarker);

    setState(() {});
  }

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(28.223652, 77.337513), zoom: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Plz click on the Marker to get Location",
            style: TextStyle(
                fontFamily: "JosefinSans", fontSize: 17, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          zoomControlsEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
          markers: markers.map((e) => e).toSet(),
        ));
  }
}
