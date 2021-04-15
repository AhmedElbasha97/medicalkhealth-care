import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Blogs/Blog_Provider.dart';
import 'package:med_app/UI/Blogs/Blogs_Main_Screen.dart';
import 'package:med_app/UI/PatientProfile/patient_profile.dart';
import 'package:med_app/Widgets/BlogsCard.dart';
import 'package:med_app/Widgets/ButtonCards.dart';
import 'package:med_app/Widgets/Top_Header_custom.dart';
import 'package:provider/provider.dart';
import 'package:med_app/UI/Blogs/BlogsDetailsScreen.dart';


class Home extends StatelessWidget {

  final myEmailController = TextEditingController();
  final myPasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        gradient: new LinearGradient(
        colors: [
          const Color(0xff00c5cc),
        const Color(0xFF00A1A7),
    ],
    ),
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Stack(children: [
          Positioned(
              top: 50,
              left: 0,
              right: 0,

              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(1.0),
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  color: Colors.white,
                  iconSize: 30.0,

                  onPressed: () {
                    print("hiii");
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1.0),
                child: IconButton(
                  icon: const Icon(Icons.account_circle_sharp),
                  color: Colors.white,
                  iconSize: 30.0,

                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PatientProfile(),));
                  },
                ),
              ),

            ],
          )),
          Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Container(
                  child: TopHaderCustom(
                      text: 'Welcome\n   akram \n    To TeleMed',image: "assets/Doctors-pana.png"),
                ),
              )),
          DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.7,
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
                           child: ButtonCard(title: "Doctor Speciality",subtitle: "you can find doctors with it speciality there",)),
                        SizedBox(height: 10),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: ButtonCard(title: "Appointment", subtitle: 'you can follow yor appointments here',)),

                        SizedBox(height: 20),
                     Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height / 20,
                                      padding: EdgeInsets.only(left: 1),
                                      child: Text("Blogs",style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Proxima',
                                      )),
                                    ),
                                    GestureDetector(
                                        onTap: () async{
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>
                                                BlogHomescreen(),));},
                                        child: Container(
                                          height: MediaQuery.of(context).size.height / 20,
                                          padding: EdgeInsets.only(left: 1),
                                          child: Text("See All",style: TextStyle(
                                            color: ColorsCollection.mainColor,
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Proxima',
                                          )),)
                                    ),
                                  ],
                                ),
                              ),
                     Padding(
                       padding: EdgeInsets.all(1.0),
                       child: Container(
                          width: MediaQuery.of(context).size.width*1,
                          height: MediaQuery.of(context).size.height * 0.25,


                          child: ChangeNotifierProvider<BlogProvider>(
                             create: (context) => BlogProvider(),
                             child: Consumer<BlogProvider>(
                               builder: (buildContext, BlogProvider, _) {
                                 print('hi4');

                                 return (BlogProvider.Blogs != null)
                                     ? ListView.builder(
                                     scrollDirection: Axis.horizontal,
                                     itemCount: BlogProvider.Blogs.length,
                                     itemBuilder: (ctx, index) {
                                       final person = BlogProvider.Blogs[index];
                                       if((BlogProvider.Blogs.length-2) == index){
                                         BlogProvider.getBlogAtFrist();
                                       }

                                       return GestureDetector(
                                         child: BlogsCard(Title: person.title,subTitle: person.body,imageURL: person.image,),
                                         onTap: () async{

                                             Navigator.of(context).push(MaterialPageRoute(
                                                 builder: (context) =>
                                                 BlogsDetailedScreen(title: person.title,SubTitle: person.body,imageURL: person.image,URI: person.url,Index: index, Date: person.date,),));

                                         },);
                                     })
                                     : Center(child: CircularProgressIndicator());
                               },
                             ),
                           )
                  ),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height / 20,
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text("News Feed",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Proxima',
                                    )),
                                  ),
                                  GestureDetector(
                                    onTap: () async{
                                        Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            BlogHomescreen(),));},
                                    child: Container(
                                      height: MediaQuery.of(context).size.height / 20,
                                      padding: EdgeInsets.only(left: 1),
                                      child: Text("See All",style: TextStyle(
                                        color: ColorsCollection.mainColor,
                                        fontSize: 20,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Proxima',
                                      )),)
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Container(
                                  width: MediaQuery.of(context).size.width*1,
                                  height: MediaQuery.of(context).size.height * 0.25,


                                  child: ChangeNotifierProvider<BlogProvider>(
                                    create: (context) => BlogProvider(),
                                    child: Consumer<BlogProvider>(
                                      builder: (buildContext, BlogProvider, _) {
                                        print('hi4');

                                        return (BlogProvider.NewsFeed != null)
                                            ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: BlogProvider.NewsFeed.length,
                                            itemBuilder: (ctx, index) {
                                              final person = BlogProvider.NewsFeed[index];


                                              return GestureDetector(
                                                child: BlogsCard(Title: person.title,subTitle: person.body,imageURL: person.image,),
                                                onTap: () async{

                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlogsDetailedScreen(title: person.title,SubTitle: person.body,imageURL: person.image,URI: person.url,Index: index, Date: person.date,),));

                                                },);
                                            })
                                            : Center(child: CircularProgressIndicator());
                                      },
                                    ),
                                  )
                              ),
                            ),
                          ],

                        ),





                        SizedBox(height: 20),

                        SizedBox(height: 12),

                        SizedBox(height: 18),

                        SizedBox(height: 18),

                      ],
                    ),
                  ),
                );
              }),
        ]),
      ),
    );
  }
}