import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/UploadCard.dart';
import 'package:med_app/Widgets/start.dart';
import 'package:med_app/Widgets/text_field.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class DoctorNextScreen extends StatefulWidget {
  final email;
  final userId;
  final username;

  DoctorNextScreen({this.email, this.userId, this.username});
  @override
  _DoctorNextScreenState createState() => _DoctorNextScreenState();
}

class _DoctorNextScreenState extends State<DoctorNextScreen> {
  var _selectedProfession = '';
  var profession = ['Doctor', 'Pharmacist', 'Nutritionist'];
  var specialities = [
    'Dermatology',
    'Dentistry',
    'Psychiatry',
    'Pediatrics',
    'Neurology',
    'Orthopedics',
    'Gynaecology and Infertility',
    'Ear, Nose and Throat',
    'Cardiology and Vascular',
    'Allergy and Immunology',
    'Andrology and Male Infertility',
    'Audiology',
    'Cardiology and Thoracic',
    'Chest and Respiratory',
    'Diabetes and Endocrinology',
    'Diagnostic Radiology',
    'Dietitian and Nutrition',
    'Family Medicine',
    'Oncology',
    'Gastroenterology and Endoscopy',
    'General Practice'
  ];
  static List<Language> _languages = [
    Language(id: 1, lang: "Arabic"),
    Language(id: 2, lang: "English"),
    Language(id: 3, lang: "French"),
    Language(id: 4, lang: "German"),
    Language(id: 5, lang: "Spanish"),
    Language(id: 6, lang: "Hindi"),
    Language(id: 7, lang: "Turkish"),
    Language(id: 8, lang: "Russian"),
    Language(id: 9, lang: "Chinese"),
    Language(id: 10, lang: "Korean"),
    Language(id: 11, lang: "Japanese"),
    Language(id: 12, lang: "Portuguese"),
  ];
  final _items = _languages
      .map((language) => MultiSelectItem<Language>(language, language.lang))
      .toList();

  static FirebaseDatabase database = new FirebaseDatabase();
  final counterRef = database.reference().child('counter');
  DatabaseReference userRef = database.reference();

  final name = TextEditingController();
  final age = TextEditingController();
  final experience = TextEditingController();
  var speciality, certificate, id, candidate;
  List _langListSelected = [];
  String _selectedGender;
  String _nameText;
  String _ageText;

  addDoctor(profession, speciality, certificate, id, candidate, languages, name,
      age, experience, gender) async {
    if(name != null){
      if(age != null){
        if(experience != null){
          if(validateUsername(name)){
            if(int.parse(age)-
                24>int.parse(experience)){
              if(int.parse(age)>=25){
                if(int.parse(experience)>=0){
    var user = userRef.child('users/${widget.userId}');
    final TransactionResult transactionResult =
        await counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
    String prof = profession.toLowerCase();
    if (transactionResult.committed) {
      user.set(<String, dynamic>{
        "appointment": [],
        "availableAppointment": [],
        "age": age,
        "gender": gender,
        "bio": "",
        "experience": experience,
        "languages": languages,
        "balance": "1500",
        "fees": "",
        "rating": "4.0",
        "reviews": [],
        "userAvatar":
            "/data/user/0/com.example.med_app/cache/file_picker/placeholder.jpg",
        "documents": {
          "certificate": certificate,
          "id": id,
          "candidate": candidate
        },
        "callMethods": {"voice": true, "video": true},
        "email": widget.email,
        "profession": profession,
        "speciality": speciality,
        "userId": widget.userId,
        "username": widget.username,
        "name": name,
        "userType": prof
      }).then((_) {
        print('Transaction  committed.');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Start()));
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        showAlert(context, "oop's something goes wrong", "${transactionResult.error.message}");
      }
    }      }else{
                  showAlert(context, "experience years is not valid", "enter valid period of experience");
                }
                }else{
                showAlert(context, "age is not valid", "enter valid age");
              }
              }else{
              showAlert(context, "years of experience is not valid", "how your age is less than your year's of experience");

            }
          }else{
            showAlert(context, "name is not valid", "please enter valid name");

          }
        }else{
          showAlert(context, "years Of Experience is empty", "please enter your experience period");

        }
      }else{
        showAlert(context, "age is empty", "please enter your age");

      }
    }else{
      showAlert(context, "name is empty", "please enter your name");

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black,
            title: Text('Details'),
            backgroundColor: ColorsCollection.mainColor,
            elevation: 0.0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 3.0),
              child: Icon(
                Icons.account_circle,
                size: 30.0,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFieldComp(
                          label: 'What is your name*',
                          hint: "Enter your profile name",
                          controller: name,
                          callback: (val) {
                            setState(() {
                              _nameText = val;
                            });
                          },
                          onChange: true,maxCharacter: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5.0),
                        child: TextFieldComp(
                            label: 'What is your age*',
                            hint: "Enter your age",
                            controller: age,
                            callback: (val) {
                              setState(() {
                                _ageText = val;
                              });
                            },
                            onChange: true,
                            keyboardTypeNumber: true,maxCharacter: 2,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 5.0, right: 5.0),
                        child: Row(
                          children: [
                            Text(
                              'What is your gender',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Proxima',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5.0, left: 5.0, right: 5.0),
                        child: DropDown(
                          showUnderline: true,
                          hint: Text('choose gender'),
                          items: ['Male', 'Female'],
                          onChanged: (val) {
                            setState(() {
                              _selectedGender = val;
                              print(_selectedGender);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Choose Your Profession:',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Proxima',
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: DropDown(
                          hint: Text('choose Profession'),
                          items: ['Doctor', 'Pharmacist', 'Nutritionist'],
                          onChanged: (val) {
                            setState(() {
                              _selectedProfession = val;
                              print(_selectedProfession);
                              if (_selectedProfession == 'Pharmacist') {
                                speciality = 'Pharmacist';
                              } else if (_selectedProfession ==
                                  'Nutritionist') {
                                speciality = 'Nutritionist';
                              }
                            });
                          },
                        ),
                      ),
                      if (_selectedProfession == 'Doctor')
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5.0, left: 5.0, right: 5.0),
                          child: DropDown(
                            hint: Text('choose Speciality'),
                            items: specialities,
                            onChanged: (val) {
                              setState(() {
                                speciality = val;
                              });
                            },
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 15.0),
                        child: TextFieldComp(
                            label: 'Years of experience in this field',
                            hint: "Enter how many years of experience",
                            controller: experience,
                            keyboardTypeNumber: true,maxCharacter: 2,),
                      ),
                      MultiSelectChipField(
                        items: _items,
                        initialValue: [_languages[0]],
                        title: Text("Languages"),
                        headerColor:
                            ColorsCollection.mainColor.withOpacity(0.5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorsCollection.mainColor, width: 1.8),
                        ),
                        selectedChipColor:
                            ColorsCollection.mainColor.withOpacity(0.5),
                        selectedTextStyle: TextStyle(color: Colors.black),
                        onTap: (values) {
                          _langListSelected =
                              values.map((e) => e.lang).toList();
                          print(_langListSelected);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 10.0, bottom: 15.0, left: 5.0),
                        child: Text(
                          'Upload Your Documents: (Required)',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Proxima',
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      Column(
                        children: [
                          UploadCard(
                              title: "Enter Your Certificate",
                              asset: "assets/documents.jpg",
                              certType: 'Certificate',
                              callback: (val) =>
                                  setState(() => certificate = val)),
                          UploadCard(
                              title: "Enter Your ID",
                              asset: "assets/ID.png",
                              certType: 'ID',
                              callback: (val) => setState(() => id = val)),
                          UploadCard(
                              title: "Enter Your Candidate Card",
                              asset: "assets/Candidate.png",
                              certType: 'Candidate',
                              callback: (val) =>
                                  setState(() => candidate = val))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF00A1A7) // foreground
                          ),
                      onPressed: (
                              _langListSelected != [] &&
                              _selectedGender != null &&
                              _selectedProfession != null &&
                              certificate != null &&
                              id != null &&
                              candidate != null)
                          ? () {
                              addDoctor(
                                  _selectedProfession,
                                  speciality,
                                  certificate,
                                  id,
                                  candidate,
                                  _langListSelected,
                                  _nameText,
                                  _ageText,
                                  experience.text,
                                  _selectedGender);

                            }
                          : null,
                      child: Text(
                        'Finish',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Proxima',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
               )
            ],
          )),
    );
  }
  bool validateUsername(String value) {
    String pattern = r"^(\w|( \w)){0,20}$";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void showAlert(context, lable, message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(lable),
          content: Text(message),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Language {
  final id;
  final lang;
  Language({this.id, this.lang});
}
