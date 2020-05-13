import 'package:docpdpartner/model/days_medicine.dart';
import 'package:docpdpartner/model/routes_model.dart';
import 'package:flutter/foundation.dart';

class MedicineModel{

   String id='';
   String masterId='';
   String name='';
   String mrp='';
   String unitSize='';
   MedicineDay howManyDay;
   MedicineDay frequencyDay;
   String selectTime='';
   RoutesModel selectroute;
   RoutesModel selectDoes;
   String notes='';

  bool isSelected=false;

   MedicineModel({this.id,this.name,this.mrp,this.unitSize,this.masterId});

   factory MedicineModel.fromJSON(Map<String,dynamic> map){
      return MedicineModel(
         id:map.containsKey('\$id')?map['\$id']:'0',
         masterId:map['Id'],
         name:map['GenericName'],
         unitSize:map['UnitSize'],
         mrp:map['MRP'],

      );
   }

    Map<String ,String> toMap(){
      return {
        'MedicinemasterID':masterId,
        'MedicineName':name,
        'HowmanyDays':howManyDay.nodays??'1',
        'Frequancy':frequencyDay.days,
        'Time':selectTime,
        'DoseFrom':selectDoes.title,
        'RauteOfAdministration':selectroute.title,
        'Note':notes??'',
      };
    }



}