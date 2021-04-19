import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class BlogsCardList extends StatelessWidget {
  final title;
  final subTitle;
  final imageURL;
  final index;
  const BlogsCardList(
      {Key key, this.title, this.subTitle, this.index, this.imageURL})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.43,
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: new Card(
                  elevation: 10,
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          Image.network(
                            image(),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height * 0.125,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(1),
                                  Colors.white.withOpacity(0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ))),
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, bottom: 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.78,
                                    child: Text(title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorsCollection.mainColor,
                                            fontWeight: FontWeight.bold)),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, bottom: 5),
                                child: Icon(Icons.arrow_forward_ios_outlined,
                                    color: ColorsCollection.mainColor,
                                    size: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 16, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(subTitle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 6,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.4),
                                    fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          )),
    );
  }

  image() {
    if (imageURL == null) {
      return "https://image.freepik.com/free-photo/digital-healthcare-network-connection-hologram-modern-virtual-screen-interface-medical-technology-network-concept_1205-6951.jpg";
    } else {
      return imageURL;
    }
  }
}
