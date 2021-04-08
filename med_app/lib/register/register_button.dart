import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class ResgisterButtonWidget extends StatelessWidget {
  const ResgisterButtonWidget(
      {Key key,
      @required this.buttonInnerText,
      @required this.buttonBG,
      this.buttonNavigation})
      : super(key: key);
  final String buttonInnerText;
  final bool buttonBG;
  final String
      buttonNavigation; //this should be required please check (register_screen.dart)
  @override
  Widget build(BuildContext context) {
    return
        // ignore: deprecated_member_use
        FlatButton(
      color: buttonBG ? ColorsCollection.mainColor : Colors.white,
      minWidth: MediaQuery.of(context).size.width * .45,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: ColorsCollection.mainColor,
              width: 1,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          buttonInnerText,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: buttonBG ? Colors.white : ColorsCollection.mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      onPressed:
          () {}, //adding your navigation here depending on the condition of buttonNavigation
    );
  }
}
