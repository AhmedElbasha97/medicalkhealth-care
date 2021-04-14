import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String text, callback) {
  Widget cancelButton = ElevatedButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = ElevatedButton(
    child: Text("Continue"),
    onPressed: () {
      callback();
      Navigator.of(context).pop();
    },
  );

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
