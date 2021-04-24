import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';

class TextFieldComp extends StatefulWidget {
  final String label;
  final String hint;
  final controller;
  final callback;
  final onChange;
  final maxCharacter;
  final keyboardTypeNumber;
  bool textSafePassword;
  TextFieldComp(
      {this.label,
      this.hint,
      this.controller,
      this.callback,
      this.onChange = false,
      this.keyboardTypeNumber = false,
        this.textSafePassword = false,
        this.maxCharacter});

  @override
  _TextFieldCompState createState() => _TextFieldCompState();
}

class _TextFieldCompState extends State<TextFieldComp> {
  var focused = false;
  var encription = true;
  void _toggle() {
    setState(() {
      encription = ! encription;
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          width: constraints.maxWidth,
          child: FocusScope(
            child: Focus(
              onFocusChange: (focus) {
                setState(() {
                  focused = focus;
                });
              },
              child: TextFormField(
                onChanged: (value) {
                  if (widget.onChange) {
                    widget.callback(value);
                  }
                },
                controller: widget.controller,
                maxLength: widget.maxCharacter ,
                obscureText: widget.textSafePassword?encription:false,
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
                    suffixIcon: widget.textSafePassword? IconButton(
                      onPressed: _toggle,
                      icon:encription? Icon(FontAwesomeIcons.eyeSlash,color:  Colors.grey,): Icon(FontAwesomeIcons.eye,color:  ColorsCollection.mainColor,),

                    ): Icon(Icons.add,
                      color: Colors.white,),
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
              ),
            ),
          ),
        );
      },
    );
  }
}
