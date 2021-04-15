import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class DrugsMainPageWidget extends StatelessWidget {
  final String title;
  final String bg;
  final String subTtitle;

  const DrugsMainPageWidget({Key key, this.title, this.bg, this.subTtitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: new Card(
                elevation: 10,
                color: Colors.black,
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
                        Image.asset(
                          bg,
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(1),
                                Colors.black.withOpacity(0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ))),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 5),
                                child: Text(title,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorsCollection.mainColor,
                                        fontWeight: FontWeight.bold))),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, bottom: 5),
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: ColorsCollection.mainColor, size: 12),
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
                          Text(subTtitle,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.6),
                                  fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                )
                // elevation: 5,
                // shadowColor: ColorsCollection.mainColor,
                // clipBehavior: Clip.antiAlias,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10)),
                // child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 10),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             mainAxisSize: MainAxisSize.max,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.only(
                //                   bottom: 25,
                //                   top: 25,
                //                 ),
                //                 child: Row(children: [
                //                   Expanded(
                //                     flex: 4,
                //                     child: Text(medicalNote,
                //                         textAlign: TextAlign.start,
                //                         style: TextStyle(
                //                             color:
                //                                 ColorsCollection.secondaryColor,
                //                             fontWeight: FontWeight.normal,
                //                             fontSize: 16)),
                //                   ),
                //                 ]),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                ),
          ),
        ));
  }
}
