class VitalModel{

  String systolic='';
  String diagonstic='';
  String vbpDate='';
  String vbpRisk='';
  String vbpSuggestion='';
  String ppRating='';
  String fastingRating='';
  String weight='';
  String height='';
  String totalColestrol='';
  String vThyriodRisk='';
  String id='';
  String t3='';
  String t4='';
  String tsh='';

  VitalModel({this.systolic,this.diagonstic,this.vbpDate,this.vbpRisk,this.vbpSuggestion,this.ppRating,this.fastingRating,this.weight,
  this.height,this.totalColestrol,this.vThyriodRisk,this.id,this.t3,this.t4,this.tsh});

  factory VitalModel.fromJSON(Map<String,dynamic> map){

      return VitalModel(
           systolic: map['Systolic'],
        diagonstic: map['Diastolic'],
        vbpDate: map['VbpTestDate'],
        vbpRisk: map['VbpRisk'],
        vbpSuggestion: map['VbpSuggestion'],
        ppRating: map['PP'],
      //  fastingRating: map['Fasting'],
        weight: map['Weight'],
        height: map['Height'],
        totalColestrol: map['TotalColestrol'],
        vThyriodRisk: map['VThyriodRisk'],
        id: map['PID'],
        t3: map['T3'],
        t4: map['T4'],
        tsh: map['TSH'],
      );
  }

 /* {
  "CustomId": "U25851a59464dc4a07",
  "UserName": "MANISH CHAUHAN",
  "UserPic": null,
  "DateOfBirth": null,
  "MadicalSummary": null,
  "AdditionalNotes": null,
  "AppoinmentReason": "",
  "AppoinmentDate": "2020-05-02T12:00:00",
  "BookingTime": null,
  "CallingMode": null,
  "Pending": "0",
  "PID": 46
  }*/
}