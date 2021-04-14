import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/TextwithDropComp.dart';
import 'package:med_app/Widgets/show_alert_dialog_widget.dart';
import 'package:med_app/Widgets/text_field.dart';

class SlidingBookingPage extends StatefulWidget {
  final callback;
  final progressIndicator;
  int pageNumber;

  SlidingBookingPage({this.callback, this.pageNumber, this.progressIndicator});

  @override
  _SlidingBookingPageState createState() => _SlidingBookingPageState();
}

class _SlidingBookingPageState extends State<SlidingBookingPage> {
  fawryCallback() {
    print(widget.pageNumber);
    setState(() {
      widget.pageNumber++;
    });
    widget.callback();
    print(widget.pageNumber);
  }

  @override
  Widget build(BuildContext context) {
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
                                  onPressed: () {},
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
                                  onTap: () {},
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
                                  onTap: () {},
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
                                        '800309730',
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
