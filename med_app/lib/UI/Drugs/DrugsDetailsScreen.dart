import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';

class DrugsDetailedScreen extends StatelessWidget {
  final title;
  final subTitle;
  final imageURL;
  final price;
  final ingrediant;

  const DrugsDetailedScreen(
      {Key key,
      this.title,
      this.subTitle,
      this.imageURL,
      this.price,
      this.ingrediant})
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
            decoration: BoxDecoration(color: Colors.white),
            child: CachedNetworkImage(
              imageUrl: imageURL,
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
                margin: EdgeInsets.only(top: 10),
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              price.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                          child: Row(children: [
                            Icon(
                              Icons.description,
                              color: ColorsCollection.mainColor,
                            ),
                            Text(
                              "Description of usage:",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              subTitle,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )),
                      ),
                      ExpandableNotifier(
                          child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: <Widget>[
                              ScrollOnExpand(
                                scrollOnExpand: true,
                                scrollOnCollapse: false,
                                child: ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                    headerAlignment:
                                        ExpandablePanelHeaderAlignment.center,
                                    tapBodyToCollapse: true,
                                  ),
                                  header: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      child: Row(children: [
                                        Icon(
                                          FontAwesomeIcons.flask,
                                          color: ColorsCollection.mainColor,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "Ingredients of medicine:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  expanded: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: ingrediant.length,
                                      itemBuilder: (ctx, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Container(
                                            child: Text(
                                              ingrediant[index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Proxima',
                                                  fontSize: 18),
                                            ),
                                          ),
                                        );
                                      }),
                                  collapsed: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      for (var _ in Iterable.generate(1))
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              "Active Ingredients of the medicine",
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            )),
                                    ],
                                  ),
                                  builder: (_, collapsed, expanded) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      child: Expandable(
                                        collapsed: collapsed,
                                        expanded: expanded,
                                        theme: const ExpandableThemeData(
                                            crossFadePoint: 0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              );
            }),
      ]),
    );
  }
}
