import 'package:flutter/foundation.dart';

class SymptompModel{

   String id='';
   String name='';
   bool isSelected=false;

   SymptompModel({this.id,this.name,});

   factory SymptompModel.fromJSON(Map<String,dynamic> map){
      return SymptompModel(
         id:map.containsKey('\$id')?map['\$id'].toString():'0',
         name:map['SymptompName'],

      );
   }

   Map<String,String> toMap(){
      return {
          '\$id':id,
          'PatientSymtoms':name
      };
   }



}