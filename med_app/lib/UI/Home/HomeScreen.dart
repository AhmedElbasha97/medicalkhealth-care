import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Blogs/Blogs_Main_Screen.dart';
import 'package:med_app/UI/DoctorProfile/doctor_profile.dart';
import 'package:med_app/UI/Drawer/Drawer.dart';
import 'package:med_app/UI/PatientProfile/patient_profile.dart';
import 'package:med_app/Widgets/BlogsCard.dart';
import 'package:med_app/Widgets/ButtonCards.dart';
import 'package:med_app/Widgets/Top_Header_custom.dart';
import 'package:med_app/provider/Blog_Provider.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:med_app/UI/Blogs/BlogsDetailsScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name = " ";
  var type;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = context.read<AppProvider>().type;
    if (context.read<AppProvider>().type != null) {
      if (type == "patient") {
        var userName = context.read<AppProvider>().patient.name;
        var arr = userName.split(' ');
        name = arr[0];
      } else {
        var userName = context.read<AppProvider>().doctor.name;
        var arr = userName.split(' ');
        name = arr[0];
      }
    }
  }

  Widget build(BuildContext context) {
    return Consumer<BlogProvider>(builder: (context, BlogProvider, _) {
      return Container(
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              const Color(0xff00c5cc),
              const Color(0xFF00A1A7),
            ],
          ),
        ),
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu_rounded),
                      iconSize: 30.0,
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.account_circle_sharp),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () {
                        if (context.read<AppProvider>().type != null)
                          (context.read<AppProvider>().type == "patient")
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PatientProfile(
                                    navigateFromOtherScreen: true,
                                  ),
                                ))
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DoctorProfile(
                                    navigateFromOtherScreen: true,
                                  ),
                                ));
                      },
                    ),
                  ]),
            ),
            drawer: new DrawerSide(),
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Positioned(
                  top: 0,
                  left: 10,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: TopHaderCustom(
                          text: 'Welcome\n${name}\nTo TeleMed',
                          image: "assets/Doctors-pana.png"),
                    ),
                  )),
              DraggableScrollableSheet(
                  initialChildSize: 0.75,
                  minChildSize: 0.75,
                  maxChildSize: 1,
                  builder: (context, scrollController) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 32),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: ((context.read<AppProvider>().type !=
                                            null) &&
                                        (context.read<AppProvider>().type ==
                                            "patient"))
                                    ? ButtonCard(
                                        title: "Doctor Speciality",
                                        subtitle:
                                            "you can find doctors with it speciality there",
                                        goDoctor: true,
                                      )
                                    : Container(
                                        color: Colors.white,
                                      )),
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: ButtonCard(
                                  title: "Appointment",
                                  subtitle:
                                      'you can follow yor appointments here',
                                  goDoctor: false,
                                )),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("Blogs",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Proxima',
                                            )),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  BlogHomescreen(
                                                navigateFromOtherScreen: true,
                                              ),
                                            ));
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                            padding: EdgeInsets.only(left: 1),
                                            child: Text("See All",
                                                style: TextStyle(
                                                  color: ColorsCollection
                                                      .mainColor,
                                                  fontSize: 20,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Proxima',
                                                )),
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.27,
                                      child: (BlogProvider.blogs != null)
                                          ? ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  BlogProvider.blogs.length,
                                              itemBuilder: (ctx, index) {
                                                final person =
                                                    BlogProvider.blogs[index];
                                                return GestureDetector(
                                                  child: BlogsCardWidget(
                                                    title: person.title,
                                                    subTtitle: person.body,
                                                    bg: person.image,
                                                  ),
                                                  onTap: () async {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlogsDetailedScreen(
                                                        title: person.title,
                                                        subTitle: person.body,
                                                        imageURL: person.image,
                                                        URI: person.url,
                                                        index: index,
                                                        date: person.date,
                                                      ),
                                                    ));
                                                  },
                                                );
                                              })
                                          : Center(
                                              child:
                                                  CircularProgressIndicator())),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        padding: EdgeInsets.only(left: 1),
                                        child: Text("News Feed",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Proxima',
                                            )),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  BlogHomescreen(
                                                navigateFromOtherScreen: true,
                                              ),
                                            ));
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                            padding: EdgeInsets.only(left: 1),
                                            child: Text("See All",
                                                style: TextStyle(
                                                  color: ColorsCollection
                                                      .mainColor,
                                                  fontSize: 20,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Proxima',
                                                )),
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.27,
                                      child: (BlogProvider.newsFeed != null)
                                          ? ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  BlogProvider.newsFeed.length,
                                              itemBuilder: (ctx, index) {
                                                final person = BlogProvider
                                                    .newsFeed[index];

                                                return GestureDetector(
                                                  child: BlogsCardWidget(
                                                    title: person.title,
                                                    subTtitle: person.body,
                                                    bg: person.image,
                                                  ),
                                                  onTap: () async {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlogsDetailedScreen(
                                                        title: person.title,
                                                        subTitle: person.body,
                                                        imageURL: person.image,
                                                        URI: person.url,
                                                        index: index,
                                                        date: person.date,
                                                      ),
                                                    ));
                                                  },
                                                );
                                              })
                                          : Center(
                                              child:
                                                  CircularProgressIndicator())),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  }),
            ]),
          ),
        ),
      );
    });
  }
}
