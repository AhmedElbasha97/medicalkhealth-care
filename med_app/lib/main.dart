import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_app/Widgets/NavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_app/UI/splash/splash_screen.dart';
import 'package:med_app/provider/patient_provider.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



void main() async {

  HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) =>
                PateintProvider(patientId: 'VO2CnrLJfJRb0sEKUH3ncNTGmgA2'),
            // child: PatientInfoScreen(),
          ),
          Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance),
          ),

          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,

          )
        ],
        child: MaterialApp(
            home:  Nav()

        ));

  }
  signedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey('userid');
    return CheckValue;
  }
  decideScreen() async{
    if(signedin()){
      return Nav();
    }else{
      return Splash();
    }
  }

}