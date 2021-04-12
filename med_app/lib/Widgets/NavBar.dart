import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/UI/Home/HomeScreen.dart';

// import 'UI/movie_list/movie_screen.dart';

class Nav extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Nav> {
  int _selectedIndex = 3;
  List<Widget> _widgetotpions = <Widget>[
    Home(),
    Home(),
    Home(),
    Home(),
    Home()
  ];

  void _itemSwitch(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor: Color(0xFF00A1A7),
        items: <Widget>[
          Icon(
            FontAwesomeIcons.blog,
            size: 25,
            color: Color(0xFF00A1A7),
          ),

          Icon(
            FontAwesomeIcons.tablets,
            size: 25,
            color: Color(0xFF00A1A7),
          ),Icon(
            Icons.home,
            size: 25,
            color: Color(0xFF00A1A7),
          ),
          Icon(
            Icons.search,
            size: 25,
            color: Color(0xFF00A1A7),
          ),
          Icon(
            Icons.people,
            size: 25,
            color: Color(0xFF00A1A7),
          ),
        ],
        onTap: _itemSwitch,
        height: 45,
        buttonBackgroundColor: Colors.white,
        color: Colors.white,
      ),
      body: _widgetotpions.elementAt(_selectedIndex),
    );
  }
}