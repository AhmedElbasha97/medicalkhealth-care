import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:med_app/UI/DoctorProfile/doctor_profile_settings/doctor_profile_settings.dart';
import 'package:med_app/UI/PatientProfile/patient_info_screen.dart';
import 'package:med_app/UI/PatientProfile/patient_medicalNotes_screen.dart';
import 'package:med_app/UI/PatientProfile/patient_profile_cards.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:med_app/models/patient.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PatientProfileWidget extends StatefulWidget {
  final text;
  final profileInfo;
  final navigateFromAnotherScreen;
  final color;
  final userId;
  Patient patient;

  PatientProfileWidget({
    this.text,
    this.color,
    this.profileInfo,
    this.userId,
    this.patient,
    this.navigateFromAnotherScreen = false,
  });

  @override
  _PatientProfileWidgetState createState() => _PatientProfileWidgetState();
}

class _PatientProfileWidgetState extends State<PatientProfileWidget> {
  static FirebaseDatabase database = new FirebaseDatabase();
  final counterRef = database.reference().child('counter');
  DatabaseReference userRef = database.reference();
  File file;
  String filePath;

  Future imagePick() async {
    FilePickerResult documents = await FilePicker.platform.pickFiles();

    if (documents != null) {
      setState(() {
        // files = documents.paths.map((path) => File(path)).toList();
        file = File(documents.files.single.path);
      });
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    imagePick().then((_) {
      Reference ref = storage.ref().child(file.path);
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.then((res) {
        res.ref.getDownloadURL();
      });
    }).then((value) => addDoctor());
  }

  addDoctor() async {
    var user = userRef.child('users/${widget.patient.userId}');
    final TransactionResult transactionResult =
        await counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
    if (transactionResult.committed) {
      user.update({'userAvatar': file.path}).then((_) {
        getImgeUrl(widget.patient.userAvatar);
        print('Transaction  committed.');
      }).then((_) {
        print('Transaction  committed.');
        Timer(Duration(seconds: 5), () {
          AppProvider provider =
              Provider.of<AppProvider>(context, listen: false);
          provider.getUserType('${widget.patient.userId}');
        });
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  getImgeUrl(imagepath) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagepath)
        .getDownloadURL();
    print(downloadURL);
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => widget.navigateFromAnotherScreen,
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: widget.navigateFromAnotherScreen,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: (widget.navigateFromAnotherScreen)
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                        color: ColorsCollection.splashTitleColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    uploadImageToFirebase(ctx);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Stack(children: [
                      Container(
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            spreadRadius: 1,
                            color: ColorsCollection.mainColor.withOpacity(.8),
                          )
                        ]),
                        child: CircleAvatar(
                          radius: 57,
                          backgroundColor: ColorsCollection.mainColor,
                          child: CircleAvatar(
                            radius: 55,
                            child: FutureBuilder(
                                future: getImgeUrl(widget.patient.userAvatar),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot.data),
                                            fit: BoxFit.cover),
                                      ),
                                    );
                                  }
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage('assets/userAvatar.jpg'),
                                          fit: BoxFit.fill),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 2,
                          child: Icon(Icons.cloud_upload_sharp))
                    ]),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(widget.patient.name,
                        style: TextStyle(
                            color: ColorsCollection.splashTitleColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 22))),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(widget.patient.email,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 14))),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * .65,
                  child: DottedBorder(
                    color: ColorsCollection.mainColor,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    padding: EdgeInsets.all(2),
                    strokeWidth: 1,
                    dashPattern: [6, 6],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xffE4F9FD),
                        //
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 50, right: 50, bottom: 20),
                          child: Column(
                            children: [
                              Text('Balance',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14)),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${widget.patient.balance} EGP",
                                  style: TextStyle(
                                      color: ColorsCollection.splashTitleColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                PatientCardWidget(
                  cardLabel: "Info",
                  icon: Icons.info,
                  buttonNavigation: PatientInfoScreen(),
                ),
                PatientCardWidget(
                  cardLabel: "Medical Records",
                  icon: Icons.notes_rounded,
                  buttonNavigation: PatientMedicalNotesScreen(),
                ),
                PatientCardWidget(
                  cardLabel: "My Payments",
                  icon: Icons.payment,
                ),
                PatientCardWidget(
                  cardLabel: "Settings",
                  icon: Icons.settings,
                  buttonNavigation: DoctorSettings(),
                ),
                PatientCardWidget(
                  cardLabel: "Logout",
                  icon: Icons.logout,
                  logout: true,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
