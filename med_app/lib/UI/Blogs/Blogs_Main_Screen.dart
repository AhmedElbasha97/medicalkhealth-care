
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:provider/provider.dart';

import 'Medical_List_Screen.dart';
import 'Nutrition_List_View.dart';

class BlogHomescreen extends StatefulWidget {
  @override
  _BlogHomescreenState createState() => _BlogHomescreenState();
}
class _BlogHomescreenState extends State<BlogHomescreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetotpions = <Widget>[
    MedicalListScreen(),
    NutritionalListScreen(),
  ];
  void _itemSwitch(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "Blogs"
                    ),
                    backgroundColor: ColorsCollection.mainColor,
                    bottom: TabBar(
                      tabs: <Widget>[
                        Tab(
                          text: 'Medical',
                        ),
                        Tab(
                          text: 'Nuitrition',
                        ),
                      ],
                      onTap: _itemSwitch,
                    ),
                  ),
                  body: _widgetotpions.elementAt(_selectedIndex))
    );}
  }

