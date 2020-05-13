import 'package:flutter/foundation.dart';

class AppointmentModel{

   String userName='';
   String userPic='';
   String requestType='';
   String appoinmentDate='';
   String appoinmentReason='';
   String bookingTime='';
   String pending='';
   String prescriptionID='';
   String meetingID='';

   String bpSystolic;
   String bpDiastolic;

   String ppReading;
   String sugarFasting;

   String kilo;
   String gram;

   String feed;
   String inch;
   String id;
   String customId;
   String patientId;



   AppointmentModel({this.patientId,this.id,this.customId,this.feed,this.inch,this.kilo,this.gram,this.ppReading,this.sugarFasting,this.bpSystolic,this.bpDiastolic,this.userName,this.userPic,this.requestType,this.appoinmentReason,this.appoinmentDate,this.bookingTime,this.pending,this.prescriptionID,this.meetingID});

   factory AppointmentModel.fromJSON(Map<String,dynamic> map){
      return AppointmentModel(
          userName:map['UserName'],
         userPic:map['UserPic'],
         id:map['ID'].toString(),
         customId:map['CustomId'],
         requestType:map['RequestType'],
         appoinmentReason:map['AppoinmentReason'],
         appoinmentDate:map['AppoinmentDate'],
         bookingTime:map['BookingTime'],
         pending:map['Pending'],
         prescriptionID:map['PrescriptionID'].toString(),
         meetingID:map['MeetingID'],
         kilo:map.containsKey('kilo')?map['kilo'].toString():'',
         gram:map.containsKey('gram')?map['gram'].toString():'',
         ppReading:map.containsKey('ppReading')?map['ppReading'].toString():'',
         sugarFasting:map.containsKey('sugarFasting')?map['sugarFasting'].toString():'',
         bpSystolic:map.containsKey('bpSystolic')?map['bpSystolic'].toString():'',
         bpDiastolic:map.containsKey('bpDiastolic')?map['MeetingID'].toString():'',
         feed:map.containsKey('feed')?map['feed'].toString():'',
         inch:map.containsKey('inch')?map['inch'].toString():'',
         patientId:map.containsKey('patientId')?map['patientId'].toString():'',
      );
   }


    Map<String,String> toMap(){
       return  {
          "UserName": userName,
          "UserPic": userPic,
          "RequestType":requestType,
          "CustomId":customId,
          "ID":id,
          "patientId":patientId??'',
          "AppoinmentReason": appoinmentReason,
          "AppoinmentDate":appoinmentDate,
          "BookingTime": bookingTime,
          "Pending": pending,
          "PrescriptionID": prescriptionID,
          "MeetingID": meetingID,
          "bpDiastolic": bpDiastolic,
          "bpSystolic": bpSystolic,
          "ppReading": ppReading,
          "sugarFasting": sugarFasting,
          "gram": gram,
          "kilo": kilo,
          "feed": feed,
          "inch": inch,
       };
    }


}