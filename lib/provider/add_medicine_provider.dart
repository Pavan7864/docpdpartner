import 'dart:convert';

import 'package:docpdpartner/model/days_medicine.dart';
import 'package:docpdpartner/model/routes_model.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';

class AddMedicineProvider extends ChangeNotifier{

  int selectedDayPosition=-1;
  int selectedFrequency=-1;
  int selectTime=-1;
  RoutesModel selectedRoute;
  RoutesModel selectedDoes;
  String notes;
  List<MedicineDay> daysList=[];
  List<MedicineDay> daysFrequency=[];

  List<RoutesModel> listRoutes=[];

  List<RoutesModel> arrDoas=[];


  AddMedicineProvider(){

    getDays();
    getRoutes();
    getDoes();
  }

    getDays(){
       daysList=AppUtils.getDaysList();
       daysFrequency=AppUtils.getFrequency();
       notifyListeners();
    }

    getRoutes(){
       listRoutes=(rout['RouteList'] as List).map((i)=>RoutesModel.fromJSON(i)).toList();
       notifyListeners();
    }

    getDoes(){
       arrDoas=(does['DoseDetails'] as List).map((i)=>RoutesModel.fromJSON(i)).toList();
       notifyListeners();
    }

    selectDay(int position){
      selectedDayPosition=position;
      print(selectedDayPosition);
      notifyListeners();
    }

    setfaq(int position){
      selectedFrequency=position;
      notifyListeners();
    }

  void timeSelect(int i) {
    selectTime=i;
    notifyListeners();
  }

  void clickRoute(RoutesModel route) {
    selectedRoute=route;
    notifyListeners();
  }

  void clickDoes(RoutesModel v) {
      selectedDoes=v;
      notifyListeners();
  }

  void setNotes(String v) {
    notes=v;
    notifyListeners();
  }


}