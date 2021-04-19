import 'package:med_app/models/DrugsModel.dart';
import 'package:med_app/services/DrugsServices.dart';

class DrugsRepo {
  DrugService _blogService = DrugService();
  Future<List<Drugs>> fetchDrugs() async {
    return _blogService.fetchDrugs();
  }
}
