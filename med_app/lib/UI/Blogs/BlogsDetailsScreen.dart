import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogsDetailedScreen extends StatelessWidget {
  final title;
  final subTitle;
  final URI;
  final imageURL;
  final date;
  final index;
  const BlogsDetailedScreen(
      {Key key,
      this.title,
      this.subTitle,
      this.URI,
      this.imageURL,
      this.index,
      this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
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
              tag: 'imageHero$index',
              child: CachedNetworkImage(
                imageUrl: image(),
                imageBuilder: (context, imageProvider) => Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
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
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ),
        Positioned(
            top: 30,
            left: 20,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: ColorsCollection.mainColor,
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
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
                  border:
                      Border.all(width: 5.0, color: ColorsCollection.mainColor),
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
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 5),
                      Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              border:
                                  Border.all(width: 3.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                10.0,
                                0.0,
                                0.0,
                                0.0,
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Row(children: [
                                  Icon(
                                    Icons.date_range,
                                    color: ColorsCollection.mainColor,
                                  ),
                                  Text(
                                    "Date Of Publishing:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(
                          formatDate(date.toString()),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                border:
                                    Border.all(width: 3.0, color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  10.0,
                                  0.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                    child: Row(children: [
                                      Icon(
                                        Icons.description,
                                        color: ColorsCollection.mainColor,
                                      ),
                                      Text(
                                        "Description:",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            )),
                      ]),
                      SizedBox(height: 5),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            subTitle,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                      SizedBox(height: 20),
                      Row(children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                border:
                                    Border.all(width: 3.0, color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  10.0,
                                  0.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                    child: Row(children: [
                                      Icon(
                                        Icons.add,
                                        color: ColorsCollection.mainColor,
                                      ),
                                      Text(
                                        "For More Details:",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            )),
                      ]),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.1,
                        // ignore: deprecated_member_use

                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Color.fromRGBO(21, 104, 102, 1),
                          onPressed: () {
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
              // ignore: deprecated_member_use
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

  String formatDate(String dbDate) {
    List<String> dateTimeList = dbDate.split(" ");
    List<String> dateList = dateTimeList.first.split("-");
    String dateTime = dateList[1] + "-" + dateList.last + "-" + dateList.first;
    return dateTime;
  }

  image() {
    if (imageURL == null) {
      return "https://image.freepik.com/free-photo/digital-healthcare-network-connection-hologram-modern-virtual-screen-interface-medical-technology-network-concept_1205-6951.jpg";
    } else {
      return imageURL;
    }
  }
}
