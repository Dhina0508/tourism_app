import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RentalRequestStatus extends StatefulWidget {
  RentalRequestStatus({Key? key}) : super(key: key);

  @override
  State<RentalRequestStatus> createState() => _RentalRequestStatusState();
}

class _RentalRequestStatusState extends State<RentalRequestStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          'Rental Booking Status',
          style: TextStyle(fontFamily: "Cinzel"),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 247, 133, 133),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Rental_booking_Request")
              .orderBy('c_time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  if (x['email'] == FirebaseAuth.instance.currentUser!.email) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shadowColor: Color.fromARGB(255, 252, 159, 152),
                        elevation: 7,
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Shop Name:  ",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 244, 128, 120),
                                          fontFamily: "JosefinSans",
                                          fontSize: 19),
                                    ),
                                    Text(
                                      x["shop_name"],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Requested Date:  ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 249, 102, 92),
                                          fontFamily: "JosefinSans",
                                          fontSize: 19),
                                    ),
                                    Text(
                                      x["date"],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Status:  ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 247, 106, 96),
                                          fontFamily: "JosefinSans",
                                          fontSize: 19),
                                    ),
                                    Text(
                                      x["status"],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    if (x['status'] == "Pending")
                                      Icon(
                                        Icons.hourglass_bottom_outlined,
                                        color: Colors.orange,
                                      )
                                    else if (x['status'] == "Accepted")
                                      Icon(
                                        Icons.done_all_rounded,
                                        color: Colors.green,
                                      )
                                    else if (x['status'] == "Rejected")
                                      Icon(
                                        Icons.not_interested_rounded,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                  ],
                                ),
                                x['status'] == "Pending"
                                    ? SizedBox(
                                        height: 40,
                                        width: 250,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                backgroundColor: Color.fromARGB(
                                                    255, 246, 87, 76)),
                                            onPressed: () {
                                              String id = x['id'];
                                              final docUser = FirebaseFirestore
                                                  .instance
                                                  .collection(
                                                      "Rental_booking_Request")
                                                  .doc(id.toString());
                                              docUser.delete();
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.clear_outlined),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "Cancel My Booking Request"),
                                              ],
                                            )),
                                      )
                                    : x['status'] == "Accepted"
                                        ? Container(
                                            child: Text(
                                              "Thanks for Booking at " +
                                                  x['shop_name'],
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: "Pacifico"),
                                            ),
                                          )
                                        : Container(
                                            child: Text(
                                              "Sorry for the Inconvinence by " +
                                                  x['shop_name'],
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: "Pacifico"),
                                            ),
                                          )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          }),
    );
  }
}
