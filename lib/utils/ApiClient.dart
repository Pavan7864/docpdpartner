import 'dart:async';
import 'dart:convert';
import 'package:device_id/device_id.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:io' show Platform;

class ApiClient{
   static bool isUpdated=false;
  static String BASE_URL="https://services.docopd.com/";
  static String imageBaseUrl="https://services.docopd.com/";
  static String API_URL="$BASE_URL/api/";

  static String login='T2DDoctorLogin';
  static String T2DDoctorOTPValidation='T2DDoctorOTPValidation';
  static String CSCAppointmentList='CSCAppointmentList';
  static String paGetCommonDiagnoses='paGetCommonDiagnoses';
  static String paGetCommonSymptom='paGetCommonSymptom';
  static String paSearchGenericMedicine='paSearchGenericMedicine';
  static String paSearchSymptoms='paSearchSymptoms?search=';
  static String paSearchDiagnoses='paSearchDiagnoses?search=';
  static String paSearchInvestigation='paSearchInvestigation';
  static String paSearchInvestigationCommon='paSearchInvestigationCommon';
  static String CSCPrescriptionGenerate='CSCPrescriptionGenerate';
  static String paGetCancelList='paGetCancelList';
  static String paSetCancel='paSetCancel';
  static String paDashboard='paDashboard';
  static String VideoCallInitate='VideoCallInitate';
  static String CSCPatientDetails='CSCPatientDetails';
  static String paDoctorProfileUpdate='paDoctorProfileUpdate';
  static String paGetDoctorHistory='paGetDoctorHistory';
  static String paSetDoctorAvailability='paSetDoctorAvailability';
  static String paGetDoctorAvailability='paGetDoctorAvailability';



  static Future<String> post(String url,BuildContext context, {Map body,GlobalKey<ScaffoldState> state}) async {
    if(body==null){
      body=Map<String,String>();
    }
    var userLogin=await MyAppPrefrences.getLogin();
    if(userLogin!=null){
      body['DoctorCustomID']=userLogin.doctorCustomId;
      body['DocCustomID']=userLogin.doctorCustomId;
    }
    String deviceid = await DeviceId.getID;
    body['device_id']=deviceid==null?'':deviceid;
    body['deviceType']=Platform.isAndroid?'Android':'IOS';
    var header = {
      "Content-Type": "application/json",
    };

    print(body);

    try {
      return http.post(API_URL + url, body: utf8.encode(json.encode(body)),
          headers: header,
          encoding: Encoding.getByName("utf-8")).then((
          http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          if(state!=null){
                state.currentState.showSnackBar(SnackBar(
                  content: Text("Internal server issue please try again later..."),
                ));
          }else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Internal server issue please try again later..."),
            ));
          }
          return "";
        } else if (response.body == null) {
          if(state!=null){
            state.currentState.showSnackBar(SnackBar(
              content: Text("Internal server issue please try again later..."),
            ));
          }else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Internal server issue please try again later..."),
            ));
          }
          return "";
        }
        var js=json.decode(response.body);
        if(js['Status']==0 || js['Status']=='0'){
          if(state!=null){
            state.currentState.showSnackBar(SnackBar(
              content: Text(js['Message']),
            ));
          }else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(js['Message']),
            ));
          }

            return "";
        }else {
          return response.body;
        }
      });
    } catch (_) {
      return "";
    }
  }

  static Future<String> get(String url,BuildContext context) async {

    try{
      return http.get(API_URL+url).then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Internal server issue please try again later..."),
          ));
          return "";
        } else if (response.body == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Internal server issue please try again later..."),
          ));
          return "";
        }
        var js=json.decode(response.body);
        if(js['Status']==0){
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(js['Message']),
          ));
          return "";
        }else {
          return response.body;
        }
      });
    } catch(_) {
      return "";
    }
  }

}