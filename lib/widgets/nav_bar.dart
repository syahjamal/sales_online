import 'package:flutter/material.dart';
import 'package:sales_online/pages/orders_page.dart';
import 'package:sales_online/pages/profile_page.dart';
import 'package:sales_online/pages/splash_screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final List<Widget> _children=[
    SplashScreen(),
    Orders(),
    ProfilePage()
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home') 
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text('Settings') 
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.contacts),
            title: new Text('Profile') 
          ),
        ]
      ),
    );
  }
}