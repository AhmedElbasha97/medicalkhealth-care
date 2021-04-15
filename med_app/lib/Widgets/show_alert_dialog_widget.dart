import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

showAlertDialog(BuildContext context, String text, callback) {
  Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        elevation: 3.0,
        primary: Colors.grey[100],
        onPrimary: ColorsCollection.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));
  Widget continueButton = ElevatedButton(
      child: Text("Continue"),
      onPressed: () {
        callback();
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        elevation: 3.0,
        primary: Colors.grey[100],
        onPrimary: ColorsCollection.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));

  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text(text),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
