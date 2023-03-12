import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism/auth/login_page.dart';
import 'package:tourism/pages/dashboard.dart';
import 'package:tourism/pages/fav.dart';
import 'package:tourism/pages/search.dart';
import 'firebase_options.dart';
import 'myprofile/Myprofile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString('email');
  runApp(GetMaterialApp(
    theme: ThemeData(primaryColor: Color.fromARGB(255, 243, 110, 101)),
    debugShowCheckedModeBanner: false,
    home: email == null ? LoginPage() : Home(),
  ));
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
  }
}
