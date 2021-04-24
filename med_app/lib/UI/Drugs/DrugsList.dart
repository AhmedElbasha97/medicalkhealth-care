import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/provider/Drug_provider.dart';
import 'package:provider/provider.dart';
import 'DrugsDetailsScreen.dart';

class DrugsList extends StatefulWidget {
  @override
  _DrugsListState createState() => _DrugsListState();
}

class _DrugsListState extends State<DrugsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          title: Text(
            'Drugs',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: ColorsCollection.mainColor,
          elevation: 0.0,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0.0, 0.0, 0.0, 0.0),
                child: ChangeNotifierProvider<DrugsProvider>(
                    create: (context) => DrugsProvider(),
                    child: Consumer<DrugsProvider>(
                        builder: (buildContext, DrugsProvider, _) {
                      return (DrugsProvider.drugs != null)
                          ? Container(
                              child: SingleChildScrollView(
                                  child: GridView.builder(
                              itemCount: DrugsProvider.drugs.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 3 / 2.15,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 4.0),
                              itemBuilder: (BuildContext context, int index) {
                                var drug = DrugsProvider.drugs[index];
                                return InkWell(
                                    splashColor: Colors.grey.withAlpha(15),
                                    onTap: () async {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            DrugsDetailedScreen(
                                          title: drug.name,
                                          price: drug.price,
                                          subTitle: drug.descripti,
                                          imageURL: drug.image,
                                          ingrediant: drug.ingridients,
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueGrey
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        border: Border.all(
                                            width: 6.0,
                                            color: Colors.white70
                                                .withOpacity(0.9)),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40.0),
                                            bottomRight: Radius.circular(
                                                40.0) //                 <--- border radius here
                                            ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.6),
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                              drug.image,
                                              imageBuilder: (context, imageProvider) => Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    4,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .width /5.2,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Image.asset('assets/images/capsule.png',
                                                      fit: BoxFit.contain,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          4,
                                                      height: MediaQuery.of(context)
                                                          .size
                                                          .width /5.2
                                                  ),
                                              errorWidget: (context, url, error) =>
                                                  Image.asset('assets/images/capsule.png',
                                                      fit: BoxFit.contain,
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          4,
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .width /5.2
                                                    ),
                                            ),
                                            // Container(
                                            //   child: Image.network(
                                            //     drug.image,
                                            //     fit: BoxFit.contain,
                                            //   ),
                                            //   width: MediaQuery.of(context)
                                            //           .size
                                            //           .width /
                                            //       4,
                                            //   height: MediaQuery.of(context)
                                            //           .size
                                            //           .width /
                                            //       5.2,
                                            // ),
                                            Center(
                                              child: Text(
                                                drug.name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                drug.price,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            )))
                          : Center(child: CircularProgressIndicator());
                    })),
              ),

            ])));
  }
}
