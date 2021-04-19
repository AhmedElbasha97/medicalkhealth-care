import 'dart:math';

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../../../Styles/colors.dart';
import '../../database/reminder_repository.dart';
import '../../helpers/platform_flat_button.dart';
import '../../helpers/snack_bar.dart';
import '../../models/medicine_type.dart';
import '../../models/pill.dart';
import '../../notifications/notifications.dart';
import '../../screens/add_new_medicine/form_fields.dart';
import '../../screens/add_new_medicine/medicine_type_card.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AddNewMedicine extends StatefulWidget {
  @override
  _AddNewMedicineState createState() => _AddNewMedicineState();
}

class _AddNewMedicineState extends State<AddNewMedicine> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();

  //medicine types
  final List<String> weightValues = ["pills", "ml", "mg"];

  //list of medicines forms objects
  final List<MedicineType> medicineTypes = [
    MedicineType("Syrup", Image.asset("assets/images/syrup.png"), true),
    MedicineType("Pill", Image.asset("assets/images/pills.png"), false),
    MedicineType("Capsule", Image.asset("assets/images/capsule.png"), false),
    MedicineType("Cream", Image.asset("assets/images/cream.png"), false),
    MedicineType("Drops", Image.asset("assets/images/drops.png"), false),
    MedicineType("Syringe", Image.asset("assets/images/syringe.png"), false),
  ];

  //-------------Pill object------------------
  int howManyWeeks = 1;
  String selectWeight;
  DateTime setDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  //==========================================

  //-------------- Database and notifications ------------------
  final ReminderRepository _repository = ReminderRepository();
  final Notifications _notifications = Notifications();

  //============================================================

  List<bool> values = List.filled(7, true);

  @override
  void initState() {
    super.initState();
    selectWeight = weightValues[0];
    initNotifies();
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        title: Text('Add Pills'),
        backgroundColor: ColorsCollection.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceHeight * 0.03,
            ),
            Container(
              height: deviceHeight * 0.35,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: FormFields(
                      howManyWeeks,
                      selectWeight,
                      popUpMenuItemChanged,
                      sliderChanged,
                      nameController,
                      amountController)),
            ),
            WeekdaySelector(
              onChanged: (int day) {
                setState(() {
                  final index = day % 7;
                  values[index] = !values[index];
                });
              },
              values: values,
              selectedFillColor: ColorsCollection.mainColor,
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Container(
              height: deviceHeight * 0.035,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: FittedBox(
                  child: Text(
                    "Medicine form",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...medicineTypes.map(
                        (type) => MedicineTypeCard(type, medicineTypeClick))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.03,
            ),
            Container(
              width: double.infinity,
              height: deviceHeight * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: PlatformFlatButton(
                        handler: () => openTimePicker(),
                        buttonChild: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              DateFormat.Hm().format(this.setDate),
                              style: TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.access_time,
                              size: 30,
                              color: ColorsCollection.mainColor,
                            )
                          ],
                        ),
                        color: Color.fromRGBO(7, 190, 200, 0.1),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: PlatformFlatButton(
                        handler: () => openDatePicker(),
                        buttonChild: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              DateFormat("dd.MM").format(this.setDate),
                              style: TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.event,
                              size: 30,
                              color: ColorsCollection.mainColor,
                            )
                          ],
                        ),
                        color: Color.fromRGBO(7, 190, 200, 0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Container(
              height: deviceHeight * 0.09,
              width: double.infinity,
              child: PlatformFlatButton(
                handler: () async => savePill(),
                color: ColorsCollection.mainColor,
                buttonChild: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //slider changer
  void sliderChanged(double value) =>
      setState(() => this.howManyWeeks = value.round());

  //choose popum menu item
  void popUpMenuItemChanged(String value) =>
      setState(() => this.selectWeight = value);

  //------------------------OPEN TIME PICKER (SHOW)----------------------------
  //------------------------CHANGE CHOOSE PILL TIME----------------------------

  TimeOfDay _time = TimeOfDay.now();

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  openTimePicker() {
    Navigator.of(context)
        .push(
      showPicker(
        context: context,
        value: _time,
        onChange: onTimeChanged,
        disableHour: false,
        disableMinute: false,
        minMinute: 0,
        maxMinute: 59,

        // Optional onChange to receive value as DateTime
        onChangeDateTime: (DateTime dateTime) {
          print(dateTime);
        },
      ),
    )
        .then((_) {
      DateTime newDate = DateTime(
          setDate.year,
          setDate.month,
          setDate.day,
          _time != null ? _time.hour : setDate.hour,
          _time != null ? _time.minute : setDate.minute);
      setState(() => setDate = newDate);
      print("hi from $setDate");
    });
  }

  //====================================================================

  //-------------------------SHOW DATE PICKER AND CHANGE CURRENT CHOOSE DATE-------------------------------
  Future<void> openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: setDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);
      setState(() => setDate = newDate);
      print(setDate.day);
      print(setDate.month);
      print(setDate.year);
    });
  }

  //=======================================================================================================

  //--------------------------------------SAVE PILL IN DATABASE---------------------------------------
  Future savePill() async {
    //check if medicine time is lower than actual time
    if (setDate.millisecondsSinceEpoch <=
            DateTime.now().millisecondsSinceEpoch &&
        values[(setDate.subtract(Duration(days: 6)).weekday) - 1]) {
      snackbar.showSnack(
          "Check your medicine time and date", _scaffoldKey, null);
    } else {
      var diffId = Random().nextInt(10000000);
      //create pill object
      Pill pill = Pill(
          diffId: diffId,
          amount: amountController.text,
          howManyWeeks: howManyWeeks,
          medicineForm: medicineTypes[medicineTypes
                  .indexWhere((element) => element.isChoose == true)]
              .name,
          name: nameController.text,
          time: setDate.millisecondsSinceEpoch,
          type: selectWeight,
          notifyId: Random().nextInt(10000000));

      //---------------------| Save as many medicines as many user checks |----------------------
      for (int i = 0; (i < howManyWeeks * 7); i++) {
        DateTime pillDate =
            DateTime.fromMicrosecondsSinceEpoch(pill.time * 1000);
        if (values[(pillDate.subtract(Duration(days: 6)).weekday) - 1]) {
          await _repository.insertData("Pills", pill.pillToMap());
          //set the notification schneudele
          tz.initializeTimeZones();
          tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));
          await _notifications.showNotification(
              pill.name,
              pill.amount + " " + pill.medicineForm + " " + pill.type,
              time,
              pill.notifyId,
              flutterLocalNotificationsPlugin);
        }
        setDate = setDate.add(Duration(milliseconds: 86400000));
        pill.time = setDate.millisecondsSinceEpoch;
        pill.notifyId = Random().nextInt(10000000);
      }
      //---------------------------------------------------------------------------------------
      snackbar.showSnack("Saved", _scaffoldKey, null);
      Navigator.of(context).pop(howManyWeeks);
    }
  }

  //=================================================================================================

  //----------------------------CLICK ON MEDICINE FORM CONTAINER----------------------------------------
  void medicineTypeClick(MedicineType medicine) {
    setState(() {
      medicineTypes.forEach((medicineType) => medicineType.isChoose = false);
      medicineTypes[medicineTypes.indexOf(medicine)].isChoose = true;
    });
  }

  //=====================================================================================================

  //get time difference
  int get time =>
      setDate.millisecondsSinceEpoch -
      tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
}
