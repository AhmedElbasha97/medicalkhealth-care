import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';





class BlogsCard extends StatelessWidget {
  final Title;
  final subTitle;
  final imageURL;
 final index;
  const BlogsCard({Key key, this.Title, this.subTitle,this.index, this.imageURL }) : super(key: key);
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
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                      subTitle, maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left),
                ),



              ],
            ),
          ),
          Hero(
            tag: 'imageHero$index',
            child:CachedNetworkImage(
              imageUrl:
              image(),
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height * 0.29,
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
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(child: CircularProgressIndicator())
            ),
          ),
        ],
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