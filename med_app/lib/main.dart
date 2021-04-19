import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_app/UI/splash/splash_screen.dart';
import 'package:med_app/Widgets/start.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => AppProvider(),
        // child: PatientInfoScreen(),
      ),
      Provider<AuthService>(
        create: (_) => AuthService(FirebaseAuth.instance),
      ),
      StreamProvider(
        create: (context) => context.read<AuthService>().authStateChanges,
      )
    ], child: MaterialApp(home: Splash()));
}

  signedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('userid');
    return checkValue;
  }

  decideScreen() async {
    if (signedin()) {
      return Start();
    } else {
      return Splash();
    }
  }
}
