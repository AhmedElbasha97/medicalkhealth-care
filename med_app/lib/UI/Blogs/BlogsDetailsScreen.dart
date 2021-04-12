import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class Home extends StatelessWidget {
  final title;
  final SubTitle;
  final URI;
  final imageURL;
  final Index;
  const Home({Key key, this.title, this.SubTitle, this.URI, this.imageURL, this.Index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,

        body: Stack(
            children: [

          Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Container(
                 child: Hero(
                    tag: 'imageHero$Index',
                    child:CachedNetworkImage(
                      imageUrl:
                      'https://images.unsplash.com/photo-1507297230445-ff678f10b524?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
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
                            fit: BoxFit.cover,
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
                            child:Text(
                             title,
                            )),
                        SizedBox(height: 10),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                          SubTitle,
                        )),
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
}