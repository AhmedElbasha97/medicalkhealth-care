import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

// ignore: must_be_immutable
class UserProfileInfoEditWidget extends StatelessWidget {
  final String infoTitle;
  final String infoValue;
  final callback;
  final keyboardTypeNumber;
  final bool isBio;
  final int maxchar;
  final int maxlines;
  const UserProfileInfoEditWidget(
      {Key key,
      @required this.infoTitle,
      @required this.infoValue,
      @required this.keyboardTypeNumber,
      this.isBio = false,
      this.callback, this.maxchar, this.maxlines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
              child: TextFormField(
                initialValue: '$infoValue',
                maxLength: maxchar,
                maxLines:  maxlines,
                keyboardType: keyboardTypeNumber
                    ? TextInputType.number
                    : TextInputType.text,
                decoration: InputDecoration(
                    fillColor: ColorsCollection.mainColor,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ColorsCollection.mainColor, width: 5.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.bold),
                    labelText: '$infoTitle'),
                onChanged: (text) {
                  callback(text);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
