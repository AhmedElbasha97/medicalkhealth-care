import 'package:med_app/models/token.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class CallService {
  Future<Token> generateToken(doctorName) async {
    int uid = new Random.secure().nextInt(1000000000);
    final response = await http.get(Uri.parse(
        'https://tele-med-iti.herokuapp.com/access_token?channel=$uid'));
    if (response.statusCode == 200) {
      Token token;
      token = tokenFromJson(response.body);
      token.channelName = uid.toString();
      print(token.channelName);
      return token;
    } else {
      throw Exception('faild to generat token');
    }
  }
}
