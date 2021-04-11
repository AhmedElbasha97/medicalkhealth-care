import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';





class BlogsCard extends StatelessWidget {
  final Title;
  final subTitle;
 final index;
  const BlogsCard({Key key, this.Title, this.subTitle,this.index }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Card(
      shadowColor: Colors.grey,

        shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10), ),
        
        margin: EdgeInsets.all(20.0),
            

            child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [

          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                   Title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                     subTitle,
                      textAlign: TextAlign.left),
                ),



              ],
            ),
          ),
          Hero(
            tag: 'imageHero$index',
            child:CachedNetworkImage(
              imageUrl:
              'https://images.unsplash.com/photo-1507297230445-ff678f10b524?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.4,

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
        ],
      ),
    );

  }
}