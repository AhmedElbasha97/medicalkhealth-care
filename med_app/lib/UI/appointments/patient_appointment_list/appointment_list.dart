import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/appointments/patient_appointment_list/appointment_card_widget.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class AppointmentList extends StatelessWidget {
  final patientId;
  AppointmentList({this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          title: Text('Appointments'),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
                icon: Icon(Icons.event_note),
                color: Colors.white,
                onPressed: () => null),
          ),
          backgroundColor: ColorsCollection.mainColor,
          elevation: 0.0,
        ),
        body: ChangeNotifierProvider<AppProvider>(
          create: (context) =>
              AppProvider(patientId: "jWg8VDotubNZUz2OpAeN5tE5ull2"),
          child: Consumer<AppProvider>(
            builder: (context, patientProvider, _) {
              return (patientProvider.patient != null)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListView.builder(
                        itemCount: patientProvider.patient.appointment.length,
                        itemBuilder: (ctx, index) {
                          return AppointmentCard(
                              appointment:
                                  patientProvider.patient.appointment[index],
                              appointments: patientProvider.patient.appointment,
                              index: index,
                              patientId: patientProvider.patient.userId);
                        },
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
