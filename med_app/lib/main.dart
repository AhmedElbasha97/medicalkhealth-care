import 'package:flutter/material.dart';
import 'package:med_app/UI/PatientProfile/patient_profile.dart';
import 'package:med_app/ui/PatientNextScreen/patient_next_screen.dart';
import 'package:med_app/ui/DoctorNextScreen/doctor_next_screen.dart';

// import 'package:firebase_core/firebase_core.dart' as firebase_core;

// void main() {
//   runApp(MyApp());
// }
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await firebase_core.Firebase.initializeApp();

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_app/UI/auth/login/Login.dart';
import 'package:med_app/UI/auth/register/register_screen.dart';
import 'package:med_app/UI/auth/signup/Signup.dart';
import 'package:med_app/UI/splash/splash_screen.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'UI/PatientProfile/patient_profile.dart';
import 'UI/PatientProfile/patient_edit_info_widget.dart';
import 'UI/PatientProfile/patient_info_screen.dart';
import 'provider/patient_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) =>
                DatabaseProvider('VO2CnrLJfJRb0sEKUH3ncNTGmgA2'),
            // child: PatientInfoScreen(),
          ),
          // ChangeNotifierProvider(
          //   create: (context) =>
          //       DatabaseProvider('fmSI3GbaBGbblc5oDGJHWaROnSg2'),
          //   child: PatientEditInfoWidget(),
          // ),
          // ChangeNotifierProvider(
          //   create: (context) =>
          //       DatabaseProvider('fmSI3GbaBGbblc5oDGJHWaROnSg2'),
          //   child: PatientInfoScreen(),
          // ),
          Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
          )
        ],
        child: MaterialApp(
          home: PatientProfile(),
          // fmSI3GbaBGbblc5oDGJHWaROnSg2
        ));
  }
}

//     return MaterialApp(
//       title: 'Medical App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Medical App'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             widget.title,
//             style:
//                 TextStyle(fontFamily: 'Proxima', fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Color(0xFF02B4BB),
//         ),
//         body: DoctorNextScreen());
//   }
// }
// SharedPreferences prefs = await SharedPreferences.getInstance();

//     bool CheckValue = prefs.containsKey("userid");

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
