class BookingModel{

  String customId='';
  String userName='';
  String userPic='';
  String dob='';
  String madicalSummary='';
  String additionalNotes='';
  String appoinmentReason='';
  String appoinmentDate='';
  String bookingTime='';
  String callingMode='';
  String pending='';
  String id='';
  String gender='';
  String pdfurl='';

  BookingModel({this.customId,this.userName,this.userPic,this.dob,this.madicalSummary,this.additionalNotes,this.appoinmentReason,this.appoinmentDate,
  this.bookingTime,this.callingMode,this.pending,this.id,this.gender,this.pdfurl});

  factory BookingModel.fromJSON(Map<String,dynamic> map){

      return BookingModel(
           customId: map['CustomId'],
        userName: map['UserName'],
        userPic: map['UserPic'],
        dob: map['DateOfBirth'],
        madicalSummary: map['MadicalSummary'],
        additionalNotes: map['AdditionalNotes'],
        appoinmentReason: map['AppoinmentReason'],
        appoinmentDate: map['AppoinmentDate'],
        bookingTime: map['BookingTime'],
        callingMode: map['CallingMode'],
        pending: map['Pending'],
        id: map['PID'].toString(),
        gender: map['gender'],
        pdfurl: map['pdfurl'],
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