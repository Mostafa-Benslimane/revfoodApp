import 'package:flutter/material.dart';
import 'package:revfood/MainApp/ProfilPage.dart';
import 'package:revfood/MainApp/communityPage.dart';
import 'package:revfood/MainApp/homePage.dart';
import 'package:revfood/MainApp/nearbypage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revfood/MainApp/profilPageWitoutLog.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> _pages = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      setState(() {
        _pages = [
          {
            'page': const HomeScreen(),
            'title': 'Revfood',
            'style': 'lol',
          },
          {
            'page': const NearbyScreen(),
            'title': 'Revfood',
            'style': 'lol',
          },
          {
            'page': const CommunityScreen(),
            'title': 'Revfood',
            'style': 'lol',
          },
          {
            'page': const ProfilScreen(),
            'title': 'Revfood',
            'style': 'lol',
          },
        ];
      });
    } else {
      setState(() {
        _pages = [
          {
            'page': const HomeScreen(),
            'title': 'Revfood',
            'style': 'lol',
          },
          {
            'page': const NearbyScreen(),
            'title': 'Revfood',
            'style': 'lol',
          },
          {
            'page': const CommunityScreen(),
            'title': 'Revfood',
            'style': 'lol',
          },
          {
            'page': const ProfilScreenWithoutLog(),
            'title': 'Revfood',
            'style': 'lol',
          },
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage]['page'],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
          elevation: 5,
          currentIndex: _currentPage,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xffb22222),
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 26),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.public_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: ''),
          ],
        ),
      ),
    );
  }
}
