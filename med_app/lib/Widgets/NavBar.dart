import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/UI/Blogs/Blogs_Main_Screen.dart';
import 'package:med_app/UI/Drugs/DrugsList.dart';
import 'package:med_app/UI/Home/HomeScreen.dart';
import 'package:med_app/UI/PatientProfile/patient_profile.dart';
import 'package:med_app/UI/callpages/callingtest.dart';
import 'package:med_app/UI/specialitylist/specialty_list.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'UI/movie_list/movie_screen.dart';

class Nav extends StatefulWidget {
  final String userid;
  Nav(this.userid);
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetotpions = <Widget>[
    BlogHomescreen(),
    DrugsList(),
    Home(),
    SpecialtyList(),
    PatientProfile()
  ];

  void _itemSwitch(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }
@override void initState() {
    // TODO: implement initState
    super.initState();
      // getStringValuesSF().then((i){
      //   id=i;
      // });
  }
  @override
  Widget build(BuildContext context) {
    print("nav ${widget.userid}");

    AppProvider provider =

          Provider.of<AppProvider>(context, listen: false);

      provider.getUserType('${widget.userid}');
    return 
    
   Scaffold(  
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
              ),
              Icon(
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
            height: 50,
            buttonBackgroundColor: Colors.white,
            color: Colors.white,
          ),
          body: _widgetotpions.elementAt(_selectedIndex),
        );
  }
}
