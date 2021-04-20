import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:permission_handler/permission_handler.dart';

import './call.dart';

class IndexPage extends StatefulWidget {
  IndexPage(
      {this.channelName,
      this.method,
      this.id,
      this.token,
      this.appointmentDate,
      this.callbackDelete});
  final method;
  final channelName;
  final token;
  final DateTime appointmentDate;
  final callbackDelete;
  final id;

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// if channel textField is validated to have error
  bool _validateError;

  ClientRole _role = ClientRole.Broadcaster;
  @override
  void dispose() {
    // dispose input controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _validateError = (widget.channelName != null);
    return Center(
        child: Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          "Join Session",
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: ((widget.appointmentDate.year <= DateTime.now().year ||
                    widget.appointmentDate.month <= DateTime.now().month) &&
                widget.appointmentDate.day <= DateTime.now().day &&
                widget.appointmentDate.minute <= DateTime.now().minute)
            ? onJoin
            : null,
        style: ElevatedButton.styleFrom(
          elevation: 3.0,
          primary: Colors.white,
          onPrimary: ColorsCollection.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            side: BorderSide(color: ColorsCollection.mainColor, width: 1.0),
          ),
        ),
      ),
    ));
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      widget.channelName.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (widget.channelName.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
              callbackDelete: widget.callbackDelete,
              id: widget.id,
              channelName: widget.channelName,
              role: _role,
              method: widget.method,
              token: widget.token),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
