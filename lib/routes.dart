import 'package:docpdpartner/main.dart';
import 'package:docpdpartner/page/add_medicine_page.dart';
import 'package:docpdpartner/page/appointment_page.dart';
import 'package:docpdpartner/page/diagnosis_page.dart';
import 'package:docpdpartner/page/edit_profile.dart';
import 'package:docpdpartner/page/history_container.dart';
import 'package:docpdpartner/page/my_availability.dart';
import 'package:docpdpartner/page/namaste_page.dart';
import 'package:docpdpartner/page/otp_page.dart';
import 'package:docpdpartner/page/home_page.dart';
import 'package:docpdpartner/page/patient_detail.dart';
import 'package:docpdpartner/page/patient_other_details.dart';
import 'package:docpdpartner/page/popup/bp_dialog.dart';
import 'package:docpdpartner/page/popup/height_dialog.dart';
import 'package:docpdpartner/page/popup/sugar_dialog.dart';
import 'package:docpdpartner/page/popup/wight_dialog.dart';
import 'package:docpdpartner/page/profile_menu.dart';
import 'package:docpdpartner/page/symptomp_page.dart';
import 'package:flutter/material.dart';

class Routes{
  static final Map<String, WidgetBuilder> _routes = {
    "/": (context) => Splash(),
    "/NamasteScreen": (context) => NamasteScreen(),
    "/OTPScreen": (context) => OTPScreen(),
    "/HomePage": (context) => HomePage(),
    "/ProfileMenu": (context) => ProfileMenu(),
    "/AppointmentScreen": (context) => AppointmentScreen(),
    "/PatientDetails": (context) => PatientDetails(),
    "/EditProfile": (context) => EditProfile(),
    "/HistoryContainer": (context) => HistoryContainer(),
    "/MyAvailability": (context) => MyAvailability(),
    "/PatientOtherDetails": (context) => PatientOtherDetails(),
//    "/AddMedicineScreen": (context) => AddMedicineScreen(),

  };
  static Map<String, WidgetBuilder> getAll() => _routes;

}