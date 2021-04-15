import 'package:flutter/material.dart';
import 'package:med_app/UI/DoctorNextScreen/doctor_next_screen.dart';
import 'package:med_app/UI/PatientNextScreen/patient_next_screen.dart';

import 'package:med_app/UI/doctors/doctor_booking_next_screen/doctor_booking_next_screen.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/doctor_booking_screen.dart';

// import 'package:firebase_core/firebase_core.dart' as firebase_core;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await firebase_core.Firebase.initializeApp();

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_app/UI/auth/login/Login.dart';
import 'package:med_app/UI/auth/register/register_screen.dart';
import 'package:med_app/UI/auth/signup/Signup.dart';
import 'package:med_app/UI/specialitylist/specialty_list.dart';
import 'package:med_app/UI/splash/splash_screen.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providedrs/database_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider(
          //   create: (context) => DatabaseProvider(
          //       speciality: 'Dermatology', id: '32FqmbJsHCTEMn8pgTXBnPLoAr82'),
          //   child: DoctorBookingScreen(),
          // ),
          Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
          ),
        ],
        child: MaterialApp(
          home: SpecialtyList(),
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
