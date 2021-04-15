import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class UserProfileInfoWidget extends StatelessWidget {
  final String infoTitle;
  final String infoValue;
  final IconData icon;

  const UserProfileInfoWidget({
    Key key,
    @required this.infoTitle,
    @required this.infoValue,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Row(
                children: [
                  Icon(
                    (icon),
                    size: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text('${infoTitle}',
                        style: TextStyle(
                          color: ColorsCollection.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(
              left: 0,
            ),
            child: Text('${infoValue}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
          ),
        ],
      ),
    );
  }
}
