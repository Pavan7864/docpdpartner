class HistoryModel{

  final String userName;
  final String userPic;
  final String reason;
  final String bookingDate;
  final String bookingTime;
  final String serviceType;
  final String status;
  final String pdfurl;

  HistoryModel({this.userName,this.userPic,this.reason,this.bookingDate,this.bookingTime,this.serviceType,this.status,this.pdfurl});

  factory HistoryModel.fromJSON(Map<String,dynamic> map){
    return HistoryModel(
        userName:map['UserName'],
        userPic:map['UserPic'],
        reason:map['AppoinmentReason'],
        bookingDate:map['BookingDate'],
      bookingTime:map['BookingTime'],
        serviceType:map['ServiceType'],
        status:map['Status'],
        pdfurl:map['pdfurl'],
    );
  }

  Map<String,String> toMap(){

    return {
      "UserName": "Pawan",
      "UserPic": "https://rudrafiles.blob.core.windows.net/userpic/152934524484U5878.jpg",
      "ServiceId/DoctorID": "1",
      "ServiceName/DocName": "Talk to Doctor",
      "ServiceUrl/DocUrl": "https://rudrafiles.blob.core.windows.net/images/t2d-home-Icon.png",
      "AppoinmentReason": "",
      "BookingDate": "2020-05-07T21:30:00",
      "BookingTime": "21:30-23:30",
      "ServiceType": "TalktoDoctor",
      "Status": "0",
      "SID/BookingID": "7468",
      "IsDoctorBooking": "1",
      "IsServiceBooking": "0",
      "CreatedDatetime": "2020-05-07T22:46:35.717",
      "DocName": "Abishak Singh",
      "DocPic": "https://rudrafiles.blob.core.windows.net/doctorprofile/Original/doc_2423_Dr__Sharma.jpeg",
      "DocCustomID": "4f6a0ae603ac",
      "ServiceStatus": "Prescription generated",
      "pdfurl": "https://rudrafiles-secondary.blob.core.windows.net/prescription/U5878746801ae3ac4c6b0158887192177.pdf"
    };
  }
}