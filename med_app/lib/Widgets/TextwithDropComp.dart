import 'package:flutter/material.dart';
import 'package:med_app/Widgets/DropDownComp.dart';
import 'package:med_app/Widgets/text_field.dart';

class TextWithDropComp extends StatefulWidget {
  final String label;
  final String hint;
  final val1;
  final val2;
  final maxChar;

  TextWithDropComp({this.label, this.hint, this.val1, this.val2, this.maxChar});

  @override
  _TextWithDropCompState createState() => _TextWithDropCompState();
}

class _TextWithDropCompState extends State<TextWithDropComp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          child: Stack(
            children: [
              Positioned(
                child: TextFieldComp(
                  label: widget.label,
                  hint: widget.hint,
                  keyboardTypeNumber: true,
                  maxCharacter: widget.maxChar,
                ),
              ),
              Positioned(
                right: 1,
                child: Container(
                  width: 80,
                  height: 58,
                  child: DropDownComp(val1: widget.val1, val2: widget.val2),
                ),
              ),
              // (string != null) ? Text(string) : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
