import 'dart:convert';

import 'package:docpdpartner/model/doctor_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  String mobile='';
  String otp='';
  bool isEmpty=false;
  bool isNotValid=false;
  bool isLoader=false;
  BuildContext mContext;
  LoginProvider(BuildContext context,String mobile){
       mContext=context;
       this.mobile=mobile;
  }


   void setMobile(String mobile){
     this.mobile=mobile;
   }


   void setOTP(String otp){
     this.otp=otp;
   }

   Future<void> validMobile(GlobalKey<ScaffoldState> gState) async {
     if(mobile.length==0){
        isEmpty=true;
        isNotValid=false;
        notifyListeners();
     }else if(mobile.length<=9 || mobile.length>10){
       isNotValid=true;
       isEmpty=false;
       notifyListeners();
     }else{
       isEmpty=false;
       isNotValid=false;
       isLoader=true;;
       notifyListeners();
       String token=await MyAppPrefrences.getToken();

       var map={
         'MobileNo':mobile,
         'Password':'',
         'deviceToken':token,
       };
        String response=await ApiClient.post(ApiClient.login,mContext,body: map);
        try {
          if (!AppUtils.isEmpty(response)) {
            var js = json.decode(response);
            List<DoctorModel> data = (js['DashBoardDetails'] as List).map((i) =>
                DoctorModel.fromJSON(i)).toList();
            if (data.length > 0) {
              // MyAppPrefrences.sav
              Navigator.pushNamed(
                  mContext, '/OTPScreen', arguments: {"mobile": mobile,});
            }
          }
        }catch(_){
          print(_);
        }
       isLoader=false;;
       notifyListeners();


     }
   }


  Future<void> validOTP(GlobalKey<ScaffoldState> gState) async {
    if(otp.length==0){
      isEmpty=true;
      isNotValid=false;
      notifyListeners();
    }else if(otp.length<=3){
      isNotValid=true;
      isEmpty=false;
      notifyListeners();
    }else{
      isEmpty=false;
      isNotValid=false;
      isLoader=true;;
      notifyListeners();
      String token=await MyAppPrefrences.getToken();
      var map={
        'MobileNo':mobile,
        'OTP':otp,
        'deviceToken':token,
      };
      String response=await ApiClient.post(ApiClient.T2DDoctorOTPValidation,mContext,body: map,state: gState);
      try {
        if (!AppUtils.isEmpty(response)) {
          var js = json.decode(response);
          List<DoctorModel> data = (js['DashBoardDetails'] as List).map((i) => DoctorModel.fromOTPJSON(i)).toList();
          if(data.length>0) {
            MyAppPrefrences.saveLogin(data[0]);
            Navigator.pushNamedAndRemoveUntil(
                mContext, '/HomePage', (Route<dynamic> route) => false);
          }
        }
      }catch(_){}
      isLoader=false;;
      notifyListeners();


    }
  }

   bool isOTPResend=false;

    resendOTP(GlobalKey<ScaffoldState> gState) async {
      isOTPResend=true;
      notifyListeners();
      String token=await MyAppPrefrences.getToken();
      var map={
        'MobileNo':mobile,
        'Password':'',
        'deviceToken':token,
      };
      String response=await ApiClient.post(ApiClient.login,mContext,body: map);
      try {
        if (!AppUtils.isEmpty(response)) {
          var js = json.decode(response);
          List<DoctorModel> data = (js['DashBoardDetails'] as List).map((i) =>
              DoctorModel.fromJSON(i)).toList();
          if (data.length > 0) {
            gState.currentState.showSnackBar(SnackBar(
              content: Text("OTP resend successfully...",style: TextStyle(color: Colors.green),),
            ));
          }
        }
      }catch(_){
        print(_);
      }
      isOTPResend=false;
      notifyListeners();

    }
}