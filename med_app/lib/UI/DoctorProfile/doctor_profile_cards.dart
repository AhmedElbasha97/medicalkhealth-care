import 'package:flutter/material.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:med_app/Styles/colors.dart';

class DocotorCardWidget extends StatelessWidget {
  final text;
  final color;
  final logout;
  final String cardLabel;
  final IconData icon;
  final buttonNavigation;

  DocotorCardWidget(
      {this.text,
      this.color,
      this.logout,
      this.cardLabel,
      this.icon,
      this.buttonNavigation});
  @override
  Widget build(BuildContext context) {
    double _size = 50.0;
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            height: _size,
            child: Card(
              shadowColor: Colors.transparent,
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          Icon((icon),
                              size: 20, color: ColorsCollection.mainColor),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(cardLabel,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 15,
                      ))
                ],
              ),
            ),
          ),
        ),
        onTap: () async {
          if (logout == true) {
            context.read<AuthService>().signOut();
            Navigator.of(context).pop();
          }
          if (buttonNavigation != null) {
            await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => this.buttonNavigation));
          }
        });
  }
}
