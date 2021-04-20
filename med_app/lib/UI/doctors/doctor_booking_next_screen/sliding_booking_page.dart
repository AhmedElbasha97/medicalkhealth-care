import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/show_alert_dialog_widget.dart';
import 'package:med_app/Widgets/text_field.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/models/token.dart';
import 'package:med_app/provider/app_provider.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:med_app/services/callservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:med_app/UI/appointments/appointment_page/session_notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SlidingBookingPage extends StatefulWidget {
  final callback;
  final progressIndicator;
  final callMethods;
  final daySelected;
  final hourSelected;
  final doctorName;
  final doctorSpeciality;
  final doctorId;
  final fees;
  final doctorAvatar;
  final appointments;
  final callbackAppointed;
  final List selectedHoursList;
  final List avAppList;
  int pageNumber;

  SlidingBookingPage(
      {this.callback,
      this.avAppList,
      this.callbackAppointed,
      this.pageNumber,
      this.selectedHoursList,
      this.doctorSpeciality,
      this.fees,
      this.appointments,
      this.daySelected,
      this.hourSelected,
      this.doctorAvatar,
      this.doctorId,
      this.doctorName,
      this.progressIndicator,
      this.callMethods});

  @override
  _SlidingBookingPageState createState() => _SlidingBookingPageState();
}

class _SlidingBookingPageState extends State<SlidingBookingPage> {
  static FirebaseDatabase database = new FirebaseDatabase();
  DatabaseReference userRef = database.reference();
  File file;

  var callMethod;
  var attachedFile;
  var appointdate;
  var appointdateFormed;
  var paymentMethod;

  final phoneNum = TextEditingController();
  final symptoms = TextEditingController();
  Token token;
  User user;
  String id;
  Patient patient;

  final SessionNotification _notifications = SessionNotification();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  @override
  void initState() {
    super.initState();
    initNotifies();
    print(widget.daySelected);
    print(DateTime.now());
    appointdate = DateFormat('yyyy-MM-dd').parse(widget.daySelected).add(
        Duration(
            hours: DateFormat('hh:mm').parse(widget.hourSelected).hour,
            minutes: DateFormat('hh:mm').parse(widget.hourSelected).minute));
    appointdateFormed = appointdate.difference(DateTime.now()).inMilliseconds;
  }

  fawryCallback() async {
    print(widget.pageNumber);
    setState(() {
      widget.pageNumber++;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('userid');
    print("booking $id");
    token = await CallService().generateToken(widget.doctorName);
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);

    provider.getPatientById(id);
    patient = provider.patient;
    print("booking: ${provider.patient.email}");
    widget.callback();
    addDoctorAppoinment();
    addPatientAppoinment();
    deleteAvailableAppointment();
    print(widget.pageNumber);
  }

  deleteAvailableAppointment() async {
    var doctor = userRef.child('users/${widget.doctorId}/availableAppointment');
    List x = widget.avAppList;
    for (var i = 0; i < x.length; i++) {
      if (DateFormat('yyyy-MM-dd').parse(x[i].availableDay).day ==
          appointdate.day) {
        x[i].availableHours.removeWhere(
            (e) => (DateFormat('hh:mm').parse(e).hour == appointdate.hour));
      }
    }
    var avAppListMapped = x.map((e) => e.toJson()).toList();
    doctor.set(avAppListMapped).then((_) {
      print("Transaction Committed");
    });
  }

  addDoctorAppoinment() async {
    var doctor = userRef
        .child('users/${widget.doctorId}/appointment/${widget.appointments}');

    doctor.set(<String, dynamic>{
      "date": widget.daySelected,
      "hour": widget.hourSelected,
      "patientAvatar": patient.userAvatar,
      "patientId": id,
      "patientName": patient.name,
      "callMethod": callMethod,
      "symptoms": symptoms.text,
      "patientPhoneNum": phoneNum.text,
      "caseFile": attachedFile,
      "paymentMethod": paymentMethod,
      "token": token.token,
      "channelName": token.channelName
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  addPatientAppoinment() async {
    var ref = userRef.child(
        'users/$id/appointment/${(patient.appointment == null) ? 0 : patient.appointment.length}');
    ref.set(<String, dynamic>{
      "date": widget.daySelected,
      "hour": widget.hourSelected,
      "doctorAvatar": widget.doctorAvatar,
      "doctorId": widget.doctorId,
      "doctorName": widget.doctorName,
      "doctorSpeciality": widget.doctorSpeciality,
      "callMethod": callMethod,
      "symptoms": symptoms.text,
      "patientPhoneNum": phoneNum.text,
      "caseFile": attachedFile,
      "paymentMethod": paymentMethod,
      "token": token.token,
      "channelName": token.channelName
    }).then((_) async {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));
      await _notifications.showNotification(
          widget.doctorName,
          'You have an appointment',
          appointdateFormed,
          Random().nextInt(10000000),
          flutterLocalNotificationsPlugin);
      print('Transaction  committed.');
    });
  }

  Future imagePick() async {
    FilePickerResult documents = await FilePicker.platform.pickFiles();
    if (documents != null) {
      setState(() {
        file = File(documents.files.single.path);
      });
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    imagePick().then((_) {
      attachedFile = file.path;
      Reference ref = storage.ref().child(file.path);
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.then((res) {
        res.ref.getDownloadURL();
        print('Transaction Committed');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var random = new Random.secure();
    return widget.pageNumber == 0
        ? ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'TeleHealth Call Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: 'Proxima',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 30.0),
                child: Text(
                  'You can choose whether to make a voice call or a video call or even a chat with the doctor to highest benefit from our service',
                  style: TextStyle(fontFamily: 'Proxima', fontSize: 16.0),
                ),
              ),
              if (widget.callMethods.chat)
                Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 20.0),
                    child: Card(
                      elevation: 3.0,
                      child: InkWell(
                        onTap: () {
                          widget.callback();
                          callMethod = 'chat';
                        },
                        child: Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.comment,
                              color: ColorsCollection.mainColor,
                              size: 28.0,
                            ),
                            title: Text(
                              'Chat',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                'Using our voice chat to communicate through internet',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (widget.callMethods.voice)
                Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 20.0),
                    child: Card(
                      elevation: 3.0,
                      child: InkWell(
                        onTap: () {
                          widget.callback();
                          callMethod = 'voice';
                        },
                        child: Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.phone_in_talk,
                              color: ColorsCollection.mainColor,
                              size: 30.0,
                            ),
                            title: Text(
                              'Voice Call',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                'Using our voice chat to communicate through internet',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (widget.callMethods.video)
                Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 20.0),
                    child: Card(
                      elevation: 3.0,
                      child: InkWell(
                        onTap: () {
                          widget.callback();
                          callMethod = 'video';
                        },
                        child: Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.video_call,
                              color: ColorsCollection.mainColor,
                              size: 32.0,
                            ),
                            title: Text(
                              'Video Call',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                  'Using our voice chat to communicate through internet'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )
        : widget.pageNumber == 1
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Contact Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        fontFamily: 'Proxima',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 25.0),
                    child: Text(
                      'Please provide your contact details to be able to communicate with the doctor in case of poor or no network existed.',
                      style: TextStyle(fontFamily: 'Proxima', fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: TextFieldComp(
                      label: 'Phone Number',
                      hint: "01012345678",
                      keyboardTypeNumber: true,
                      controller: phoneNum,
                    ),
                  )
                ],
              )
            : widget.pageNumber == 2
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Notes (Optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              fontFamily: 'Proxima',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'It would be helpful for the doctor if you could provide the symptoms you feel and any medical documents you have.',
                            style: TextStyle(
                                fontFamily: 'Proxima', fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Symptoms:',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFieldComp(
                          keyboardTypeNumber: false,
                          hint: "e.g. cough, back pain, etc.",
                          controller: symptoms,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Documents:',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text('Use Images or PDF Files'),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  child: Text(
                                    "Attach Files",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    uploadImageToFirebase(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // elevation: 3.0,
                                    primary: Colors.grey[100],
                                    onPrimary: ColorsCollection.mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : widget.pageNumber == 3
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Choose Payment Method',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                  fontFamily: 'Proxima',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                'Choose how you favourite way of payment:',
                                style: TextStyle(
                                    fontFamily: 'Proxima', fontSize: 16.0),
                              ),
                            ),
                            Container(
                              height: 100,
                              child: Card(
                                elevation: 3.0,
                                child: InkWell(
                                  onTap: () {
                                    showAlertDialog(
                                        context,
                                        "Are you sure you will pay with Fawry?",
                                        fawryCallback);
                                    paymentMethod = 'fawry';
                                  },
                                  child: Center(
                                    child: ListTile(
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                AssetImage("assets/fawry.jpg"),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        'Fawry',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text('+5 EGP Fawry Fee'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              child: Card(
                                elevation: 3.0,
                                child: InkWell(
                                  onTap: () {
                                    paymentMethod = 'credit';
                                  },
                                  child: Center(
                                    child: ListTile(
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                AssetImage("assets/credit.png"),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        'Credit Card',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text('Visa or MasterCard'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              child: Card(
                                elevation: 3.0,
                                child: InkWell(
                                  onTap: () {
                                    paymentMethod = 'paypal';
                                  },
                                  child: Center(
                                    child: ListTile(
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                AssetImage("assets/paypal.png"),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        'PayPal',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text('Pay with PayPal Account'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 80.0,
                              color: ColorsCollection.mainColor,
                            ),
                            Text(
                              'Your booking is pending payment',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Proxima',
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                'Pay at your nearest fawry',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Center(
                                child: Container(
                                  height: 70,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: Text('Reference Number'),
                                      ),
                                      Text(
                                        "${random.nextInt(10000000)}",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: Container(
                                  height: 70,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: Text('Time left'),
                                      ),
                                      Text(
                                        '12 Hours',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey[300],
                              ),
                            ),
                            Text(
                                'Booking will be confirmed once you pay with Fawry, otherwise it\'ll be cancelled'),
                          ],
                        ),
                      );
  }
}
