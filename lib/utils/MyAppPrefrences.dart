import 'dart:convert';
import 'package:docpdpartner/model/doctor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppPrefrences{






  static void clearLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('LoginDoctor', "");
  }

  static void saveLogin(DoctorModel model) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var value = json.encode(model.toMap());
    prefs.setString("LoginDoctor", value);

  }



  static Future<DoctorModel> getLogin() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data= prefs.getString("LoginDoctor");
    DoctorModel model;
    if(data == null || data.isEmpty){
      return model;
    }
    var value=json.decode(data);
    model=DoctorModel.fromOTPJSON(value);

    return model;

  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("tokenFCM",token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tokenFCM');
  }

}