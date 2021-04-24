import 'package:flutter/material.dart';
import 'package:med_app/models/DrugsModel.dart';
import 'package:med_app/repository/Drugs_Repo.dart';
class DrugsProvider extends ChangeNotifier {
  List<Drugs> drugs;

  int counter = 1;
  DrugsRepo _drugRepo = DrugsRepo();

  DrugsProvider() {
    getDrugs();
  }

  void getDrugs() async {
    _drugRepo.fetchDrugs().then((newdrugs) {
    this.drugs = newdrugs;
      notifyListeners();
    });
  }
}
