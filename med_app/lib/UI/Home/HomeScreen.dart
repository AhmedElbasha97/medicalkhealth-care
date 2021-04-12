import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/auth/RestPassword/ResetPassswordScreen.dart';
import 'package:med_app/UI/auth/signup/Signup.dart';
import 'package:med_app/Widgets/BlogsCard.dart';
import 'package:med_app/Widgets/ButtonCards.dart';
import 'package:med_app/Widgets/Top_Header_custom.dart';
import 'package:med_app/Widgets/directed_link.dart';
import 'package:med_app/Widgets/rounderd_small_button.dart';
import 'package:med_app/Widgets/social_media_button.dart';
import 'package:med_app/Widgets/text_field.dart';
import 'package:med_app/Widgets/top_hader.dart';

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
              top: 30,
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
                  tooltip: 'Increase volume by 10',
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
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    print("hiii");
                  },
                ),
              ),

            ],
          )),
          Positioned(
              top: 30,
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
              initialChildSize: 0.65,
              minChildSize: 0.65,
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                  Container(
                                    height: MediaQuery.of(context).size.height / 20,
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text("See All",style: TextStyle(
                                      color: ColorsCollection.mainColor,
                                      fontSize: 20,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Proxima',
                                    )),),
                                  ],
                                ),
                              ),
                     Padding(
                       padding: EdgeInsets.all(1.0),
                       child: Container(
                          width: MediaQuery.of(context).size.width*1,
                          height: MediaQuery.of(context).size.height * 0.25,


                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index){
                          return BlogsCard(Title: "ahmed",subTitle: "Aliigfdnshsdefgbfdevbshfdbvsfdbvkbkfdsbvkdffbsbsdbfsdbii",index: 1,);
                        })
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
                                  Container(
                                    height: MediaQuery.of(context).size.height / 20,
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text("See All",style: TextStyle(
                                      color: ColorsCollection.mainColor,
                                      fontSize: 20,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Proxima',
                                    )),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                  width: MediaQuery.of(context).size.width*1,
                                  height: MediaQuery.of(context).size.height * 0.25,


                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder: (context, index){
                                        return BlogsCard(Title: "ahmed",subTitle: "Aliigfdnshsdefgbfdevbshfdbvsfdbvkbkfdsbvkdffbsbsdbfsdbii",index: 1,);
                                      })
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