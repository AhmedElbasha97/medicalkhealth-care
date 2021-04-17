import 'package:http/http.dart' as http;
import 'package:med_app/models/DrugsModel.dart';

class DrugService {
  Future<List<Drugs>> fetchDrugs() async {
    final response = await http.get(Uri.parse('https://med-app-701e8-default-rtdb.firebaseio.com/Drugs.json'));
    if (response.statusCode == 200) {
      print("hiii from services");
      var per=drugsFromJson(response.body);
      print(per[0].image);
      return drugsFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD Blogs');
    }
  }



}