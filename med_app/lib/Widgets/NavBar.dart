import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/UI/Blogs/Blogs_Main_Screen.dart';
import 'package:med_app/UI/DoctorProfile/doctor_profile.dart';
import 'package:med_app/UI/Drugs/drugs_main_page.dart';
import 'package:med_app/UI/Home/HomeScreen.dart';
import 'package:med_app/UI/PatientProfile/patient_profile.dart';
import 'package:med_app/UI/specialitylist/specialty_list.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
class Nav extends StatefulWidget {
  final String userId;
  Nav({this.userId});
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetotpions;

  void _itemSwitch(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _widgetotpions = <Widget>[
      BlogHomescreen(),
      DrugsMainPageScreen(),
      Home(),
      SpecialtyList(),
      if (context.read<AppProvider>().type != null)
        (context.read<AppProvider>().type == "patient")
            ? PatientProfile()
            : DoctorProfile()
    ];
    return Consumer<AppProvider>(builder: (context, databaseProvider, _) {
      if (databaseProvider.type == null) {
        databaseProvider.getUserType(widget.userId);
      }
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
    });
  }
}