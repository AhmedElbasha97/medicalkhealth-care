import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import './call.dart';

class IndexPage extends StatefulWidget {
  IndexPage({this.channelName, this.method,this.token});
  final method;
  final channelName;
  final token;

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// if channel textField is validated to have error
  bool _validateError ;

  ClientRole _role = ClientRole.Broadcaster;
  @override
  void dispose() {
    // dispose input controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     _validateError = (widget.channelName!=null);
    return Center(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: 
           RaisedButton(
              onPressed: onJoin,
              child: Text('Join'),
              color: Colors.blueAccent,
              textColor: Colors.white,
            ),
          ),
    );
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
            channelName: widget.channelName,
            role: _role,
            method: widget.method,
            token:widget.token
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
