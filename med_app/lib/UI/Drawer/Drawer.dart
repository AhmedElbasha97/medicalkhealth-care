import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class DrawerSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: double.infinity,
          decoration: BoxDecoration(
              color:Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 8.0,
                )
              ],
              border: Border(
                  right: BorderSide(
                    color: Colors.white70.withOpacity(0.3),
                  ))),
          child: Stack(
            children: [
              SizedBox(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.0,
                      sigmaY: 4.0,
                    ),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff00c5cc),
                          const Color(0xFF00A1A7)
                        ])),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 3.0,style: BorderStyle.solid, color:Color(0xfff2f2f2).withOpacity(0.5)),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/46.jpg"),
                              radius: 30.0,
                            ),
                          ),
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.43,
                          child:ListTile(
                            title: Text(
                              "Akram",
                              style: TextStyle(
                                  color: Color(0xfff2f2f2),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Proxima',
                                  fontSize: 20),
                            ),
                            subtitle:Text(
                              "Patinent ta3ban",
                              style: TextStyle(
                                  color: Color(0xfff2f2f2),
                                  fontFamily: 'Proxima',
                                  fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 4.0,style: BorderStyle.solid, color:ColorsCollection.mainColor.withOpacity(0.3)),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.home,
                              color: ColorsCollection.mainColor,
                            ),
                            title: Text("Home Page",
                            style: TextStyle(
                            color: ColorsCollection.mainColor,
                            fontFamily: 'Proxima',
                            fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 4.0,style: BorderStyle.solid, color:ColorsCollection.mainColor.withOpacity(0.3)),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.person,
                              color: ColorsCollection.mainColor,
                            ),
                            title: Text("Profile Page",
                            style: TextStyle(
                            color: ColorsCollection.mainColor,
                            fontFamily: 'Proxima',
                            fontSize: 16),
                            ),
                            ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 4.0,style: BorderStyle.solid, color:ColorsCollection.mainColor.withOpacity(0.3)),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.settings,
                              color: ColorsCollection.mainColor,
                            ),
                            title: Text("Settings",
                            style: TextStyle(
                            color: ColorsCollection.mainColor,
                            fontFamily: 'Proxima',
                            fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 4.0,style: BorderStyle.solid, color:ColorsCollection.mainColor.withOpacity(0.3)),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.logout,
                              color:ColorsCollection.mainColor,
                            ),
                            title: Text("Log Out",
                          style: TextStyle(
                          color: ColorsCollection.mainColor,
                          fontFamily: 'Proxima',
                          fontSize: 16),
                          ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),

      ),
    );

  }
}



