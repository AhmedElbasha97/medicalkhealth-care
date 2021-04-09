import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class TextFieldComp extends StatefulWidget {
  final String label;
  final String hint;

  TextFieldComp({this.label, this.hint});

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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xFF02B4BB)),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(40.0),
                        )),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                    labelText: widget.label,
                    labelStyle: TextStyle(
                        color:
                            focused ? ColorsCollection.mainColor : Colors.grey,
                        fontSize: 20,
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.bold),
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      fontFamily: 'Proxima',
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
            ),
          ),
        );
      },
    );
  }
}
