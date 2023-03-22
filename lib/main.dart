import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/Vendor/home.dart';
import 'package:tourism/Vendor/vendor_dashboard.dart';
import 'package:tourism/auth/login_page.dart';
import 'package:tourism/dash_board_four_pages/hotel.dart';
import 'package:tourism/myprofile/about.dart';
import 'package:tourism/pages/dashboard.dart';
import 'package:tourism/pages/fav.dart';
import 'package:tourism/pages/myprofile.dart';
import 'package:tourism/pages/search.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString('email');
  runApp(GetMaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red,
          colorScheme: ColorScheme.light(primary: Colors.red)),
      debugShowCheckedModeBanner: false,
      home: email == null ? LoginPage() : Home(),
      routes: {
        'Dashboard': (context) => DashBoard(),
        'home': (context) => Home(),
        'login': (context) => LoginPage()
      }));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentindex = 0;
  final Screens = [DashBoard(), Fav(), Search(), MyProfile()];
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection("User_data");
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.email).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            if (data["about"] == "user") {
              return Scaffold(
                body: Screens[_currentindex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentindex,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 20,
                  selectedFontSize: 15,
                  unselectedFontSize: 12,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Color.fromARGB(255, 249, 109, 99),
                  showUnselectedLabels: true,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: '',
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      _currentindex = index;
                    });
                  },
                ),
              );
            } else {
              return VendorHome();
            }
          }
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            color: Color.fromARGB(255, 245, 112, 103),
          )));
        });
  }
}
