import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class DrugsMainPageWidget extends StatelessWidget {
  final String title;
  final String bg;
  final String subTtitle;
  final buttonNavigation;

  const DrugsMainPageWidget(
      {Key key, this.title, this.bg, this.subTtitle, this.buttonNavigation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                                    Colors.white.withOpacity(1),
                                    Colors.white.withOpacity(0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ))),
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: Text(title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorsCollection.mainColor,
                                            fontWeight: FontWeight.bold))),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, bottom: 5),
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
                              Text(subTtitle,
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
        onTap: () async {
          if (buttonNavigation != null) {
            await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => this.buttonNavigation));
          }
        });
  }
}
