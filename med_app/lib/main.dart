import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_app/UI/auth/login/Login.dart';
import 'package:med_app/UI/auth/register/register_screen.dart';
import 'package:med_app/UI/auth/signup/Signup.dart';
import 'package:med_app/UI/splash/splash_screen.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    //     bool CheckValue = prefs.containsKey("userid");
    return MultiProvider(providers: [
      Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        )
    ],child:MaterialApp(
      home: Splash(),
    ));
  }
}

// class AuthWrapper extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     final firebaseuser=context.watch<User>();
//         if (firebaseuser == null) {
//         return Login();
//       } else {
//         return ResgisterScreen();
//       }
//   }
// }
