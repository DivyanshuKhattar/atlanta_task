import 'dart:convert';
import 'package:atlanta_task/CommonClasses/common_function.dart';
import 'package:atlanta_task/Models/user_model_class.dart';
import 'package:http/http.dart' as http;

class Util {

  /// constant base url for all api
  static String baseUrl = "https://jsonplaceholder.typicode.com/";

  /// function for GET USER LIST api calling
  Future<List<UserModel>> getUserList() async {
    var network = await CommonFunction().checkNetwork();
    if (network == true) {
      var response = await http.get(Uri.parse("${baseUrl}users"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body);
        return result.map(((e) => UserModel.fromJson(e))).toList();
      }
      else {
        throw Exception(response.reasonPhrase);
        // show toast message to update the user (reason of the error)
      }
    }
    else {
      throw Exception();
      // show toast message (Network issues)
    }
  }

}