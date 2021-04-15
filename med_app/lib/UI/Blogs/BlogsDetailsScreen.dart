import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
class BlogsDetailedScreen extends StatelessWidget {
  final title;
  final SubTitle;
  final URI;
  final imageURL;
  final Date;
  final Index;
  const BlogsDetailedScreen({Key key, this.title, this.SubTitle, this.URI, this.imageURL, this.Index, this.Date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,

        body: Stack(
            children: [


          Positioned(
              top: 1,
              left: 0,
              right: 0,

                child: Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [
                        const Color(0xff00c5cc),
                        const Color(0xFF00A1A7),
                      ],
                    ),
                  ),
                 child: Hero(
                    tag: 'imageHero$Index',
                    child:CachedNetworkImage(
                      imageUrl:
                        image(),

                      imageBuilder: (context, imageProvider) => Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width ,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),

                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),

                        ),
                      ),
                      placeholder: (context, url) =>
                          Image.asset('lib/assets/iPhone X, XS, 11 Pro – 1.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('lib/assets/iPhone X, XS, 11 Pro – 1.png'),
                    ),
                  ),
                ),
              ),
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
                          icon: const Icon(Icons.arrow_back_ios),
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
          DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 1,
              builder: (context, scrollController) {

                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 32),
                  decoration: BoxDecoration(


                      color: Colors.white,
                      border: Border.all(
                          width: 5.0,
                          color: ColorsCollection.mainColor),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(
                              40.0) //                 <--- border radius here
                      ),
                    ),

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
                            child:Text(
                             title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                  fontWeight: FontWeight.bold),

                            )),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 150.0, 0.0),
                          child: Container(

                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.04,

                              child:Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 3.0,
                                      color: ColorsCollection.mainColor),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40.0),
                                      topRight: Radius.circular(
                                          40.0) //                 <--- border radius here
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(width: 7.0,style: BorderStyle.solid, color:ColorsCollection.mainColor),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(3.0,0.0, 0.0, 0.0),
                                    child: Text(

                                      "Date Of Publishing:",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),

                                    ),
                                  ),
                                ),
                              )),
                        ),

                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.1,

                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                formatDate(Date.toString()),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 150.0, 0.0),
                          child: Container(

                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.04,

                              child:Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 3.0,
                                      color: ColorsCollection.mainColor),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40.0),
                                      topRight: Radius.circular(
                                          40.0) //                 <--- border radius here
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(width: 7.0,style: BorderStyle.solid, color:ColorsCollection.mainColor),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(3.0,0.0, 0.0, 0.0),
                                    child: Text(

                                      "Description:",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),

                                    ),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(height: 5),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                          SubTitle,
                              style: TextStyle(
                                  fontSize: 18,
                                 ),
                        )),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 150.0, 0.0),
                          child: Container(

                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.04,

                              child:Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 3.0,
                                      color: ColorsCollection.mainColor),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40.0),
                                      topRight: Radius.circular(
                                          40.0) //                 <--- border radius here
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(width: 7.0,style: BorderStyle.solid, color:ColorsCollection.mainColor),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(3.0,0.0, 0.0, 0.0),
                                    child: Text(

                                      "For More Details:",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),

                                    ),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Color.fromRGBO(21, 104, 102, 1),
                            onPressed: () {
                              print("hiiiiiiii");
                              _launchURL(URI, context);

                            },
                            child: Text(
                              "For More Details",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
        ]),
      );
  }
  _launchURL(String url, context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text("oop's somethng goes wrong"),
            content: Text("please Check Your Internet"),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );

    }
  }
  String formatDate(String dbDate){
    List<String> dateTimeList = dbDate.split(" ");
    List<String> dateList = dateTimeList.first.split("-");
    String dateTime = dateList[1]+"-"+dateList.last+"-"+dateList.first ;
    return dateTime;
  }
  image() {
    if(imageURL == null){
      return "https://image.freepik.com/free-photo/digital-healthcare-network-connection-hologram-modern-virtual-screen-interface-medical-technology-network-concept_1205-6951.jpg";
    }else{
      return imageURL;
    }
  }
}