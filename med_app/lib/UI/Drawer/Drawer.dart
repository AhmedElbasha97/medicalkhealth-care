import 'dart:ui';
import 'package:med_app/UI/Drawer/AboutUs.dart';
import 'package:med_app/UI/Drawer/TermsAndCondition.dart';
import 'package:med_app/UI/auth/register/register_screen.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

class DrawerSide extends StatefulWidget {
  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  var email="";
  var name="";
  var imagePath="https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png";

  getImgeUrl(imagepath) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagepath)
        .getDownloadURL();
    return downloadURL;
  }

  @override
  void initState() {
    super.initState();
    var type = context.read<AppProvider>().type;
    if (context.read<AppProvider>().type != null) {
      if (type == "patient") {
        name = context
            .read<AppProvider>()
            .patient
            .name;
        imagePath = context
            .read<AppProvider>()
            .patient
            .userAvatar;
        email = context
            .read<AppProvider>()
            .patient
            .balance;
      } else {
        name = context
            .read<AppProvider>()
            .doctor
            .name;
        imagePath = context
            .read<AppProvider>()
            .doctor
            .userAvatar;
        email = context
            .read<AppProvider>()
            .doctor
            .email;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent,
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
                            right: BorderSide(
                                width: 3.0,
                                style: BorderStyle.solid,
                                color: Color(0xfff2f2f2).withOpacity(0.5)),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: FutureBuilder(
                              future: getImgeUrl(imagePath),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    height: MediaQuery.of(context).size.width *
                                        0.19,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot.data),
                                          fit: BoxFit.fill),
                                    ),
                                  );
                                }
                                return Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.19,
                                  height: MediaQuery.of(context).size.width *
                                      0.19,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage('assets/userAvatar.jpg'),
                                        fit: BoxFit.fill),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: ListTile(
                          title: Text(
                            "${name}",
                            style: TextStyle(
                                color: Color(0xfff2f2f2),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Proxima',
                                fontSize: 20),
                          ),
                          subtitle: Text(
                            "Balance is: ${email} LE",
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

                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TermsAndCondition(),
                          ));
                        },
                        leading: Icon(
                          Icons.description,
                          color: ColorsCollection.mainColor,
                        ),
                        title: Text(
                          "Terms AND Condition",
                          style: TextStyle(
                              color: ColorsCollection.mainColor,
                              fontFamily: 'Proxima',
                              fontSize: 16),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AboutUs(),
                          ));
                        },
                        leading: Icon(
                          Icons.add_ic_call,
                          color: ColorsCollection.mainColor,
                        ),
                        title: Text(
                          "About US",
                          style: TextStyle(
                              color: ColorsCollection.mainColor,
                              fontFamily: 'Proxima',
                              fontSize: 16),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          context.read<AppProvider>().clear();
                          context.read<AuthService>().signOut();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.remove("userid");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResgisterScreen(),
                          ));
                        },
                        leading: Icon(
                          Icons.logout,
                          color: ColorsCollection.mainColor,
                        ),
                        title: Text(
                          "Log Out",
                          style: TextStyle(
                              color: ColorsCollection.mainColor,
                              fontFamily: 'Proxima',
                              fontSize: 16),
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
