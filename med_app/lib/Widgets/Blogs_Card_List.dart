
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';





class BlogsCardList extends StatelessWidget {
  final Title;
  final subTitle;
  final imageURL;
  final index;
  const BlogsCardList({Key key, this.Title, this.subTitle,this.index, this.imageURL }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 50.0,
          ),
        ],
      ),
      child: Card(

        shadowColor: Colors.grey,

        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10), ),

        margin: EdgeInsets.all(20.0),


        child:
            Stack(
              children: [
                Hero(
                  tag: 'imageHero$index',
                  child:CachedNetworkImage(
                    imageUrl:
                    image(),
                    imageBuilder: (context, imageProvider) => Container(
                      height: MediaQuery.of(context).size.height * 0.29,
                      width: MediaQuery.of(context).size.width ,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
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
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,

                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(

                        topRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey,
                          blurRadius: 50.0,
                        ),

                      ],
                      color: Colors.white
                    ),

                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width  ,
                          child: Container(
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
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(width: 7.0,style: BorderStyle.solid, color:ColorsCollection.mainColor),
                                  ),
                                ),
                                child:Padding(
                                padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                child:Text(
                                  Title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [

                              SizedBox(height: 10,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width ,
                                child: Text(
                                    subTitle, maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center),
                              ),



                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),



      ),
    );

  }

  image() {
    if(imageURL == null){
      return "https://image.freepik.com/free-photo/digital-healthcare-network-connection-hologram-modern-virtual-screen-interface-medical-technology-network-concept_1205-6951.jpg";
    }else{
      return imageURL;
    }
  }
}
