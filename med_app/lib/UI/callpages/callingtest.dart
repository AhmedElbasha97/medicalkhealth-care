import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_app/UI/callpages/index.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';

class CallingTest extends StatefulWidget {
  
  @override
  _CallingTestState createState() => _CallingTestState();
}

class _CallingTestState extends State<CallingTest> {
User user;

  @override
  Widget build(BuildContext context) {
    
  
// void inputData()async{
//       user = await context.read<AuthService>().getCurrentUser();
//     final uid = user.uid;
//     // here you write the codes to input the data into firestore
//   }

   

    return Scaffold(
      body:Consumer<AppProvider>(
        builder: (context, appProvider, _) {
            //  inputData();
            //  print("id${user.uid}");
          // appProvider.getParent(user.uid);
        
          return (appProvider.patient != null)?
           Center(
             child: ListView.builder(
                        itemCount: appProvider.patientAppointments.length,
                        itemBuilder: (ctx, index) {
                          final appointment = appProvider.patientAppointments[index];
                          return IndexPage( method: appointment.callMethod,channelName:appointment.channelName,token: appointment.token,);
                        }),
           )
                  : Center(
                      child: Text(
                      "Sorry There are no mettings Right Now",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ));
        }
    ));
  }
}