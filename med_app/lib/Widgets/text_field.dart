import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class TextFieldComp extends StatefulWidget {
  final String label;
  final String hint;
  final controller;
  final callback;
  final keyboardTypeNumber;
  TextFieldComp(
      {this.label,
      this.hint,
      this.controller,
      this.callback,
      this.keyboardTypeNumber = false});

  @override
  _TextFieldCompState createState() => _TextFieldCompState();
}

class _TextFieldCompState extends State<TextFieldComp> {
  var focused = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          width: constraints.maxWidth - 50,
          child: FocusScope(
            child: Focus(
              onFocusChange: (focus) {
                setState(() {
                  focused = focus;
                });
              },
              child: TextFormField(
                onChanged: (value) {
                  if ((value != null || value.isNotEmpty) &&
                      widget.callback != null) {
                    widget.callback();
                  }
                },
                controller: widget.controller,
                keyboardType: widget.keyboardTypeNumber
                    ? TextInputType.number
                    : TextInputType.text,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xFF02B4BB)),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        )),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                    labelText: widget.label,
                    labelStyle: TextStyle(
                        color:
                            focused ? ColorsCollection.mainColor : Colors.grey,
                        fontSize: 18,
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.bold),
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      fontFamily: 'Proxima',
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
              ),
            ),
          ),
        );
      },
    );
  }
}
