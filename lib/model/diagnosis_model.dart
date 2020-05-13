import 'package:flutter/foundation.dart';

class DiagnosisModel{

   String id='';
   String diagnosesName='';
   bool isSelected=false;

   DiagnosisModel({this.id,this.diagnosesName,});

   factory DiagnosisModel.fromJSON(Map<String,dynamic> map){
      return DiagnosisModel(
         id:map['\$id'],
         diagnosesName:map.containsKey('SymptompName')?map['SymptompName']:map['DiagnosesName'],

      );
   }

  Map<String,String> toMap() {
      return {
         'PatientDaignosis':diagnosesName
      };
  }



}