class DoctorModel{

  String doctorID='';
  String MobileNo='';
  String hospitalName='';
  String addressLine1='';
  String addressLine2='';
  String hos_pic_url='';
  String HospitalLogoPath='';
  String HospitalUrl='';

  String HighesQualification='';
  String TotalCallsToday='';
  String DocAuthkey='';
  String MissedCallsToday='';
  String T2DcallAssignmentMonthally='';
  String TotalCallsMonthally='';
  String MissedCallsMonthally='';
  String FirstName='';
  String LastName='';
  String Description='';
  String TotalExperence='';
  String Country='';
  String State='';
  String City='';
  String Pic='';
  String ZipCode='';
  String Operator='';
  String Column1='';
  String Column2='';
  String doctorCustomId='';
  String T2DcallAssignmentToday='';
  String gender='';
  String DocCreateddate='';
  String AddressLine1='';
  String AddressLine2='';
  String MBBSCompletionDate='';
  String Specialization='';
  String hospitalId='';

  DoctorModel({this.doctorCustomId,this.doctorID,this.MobileNo,this.hospitalName,this.addressLine1,this.addressLine2,this.hos_pic_url,this.HospitalLogoPath,this.HospitalUrl,
  this.HighesQualification,this.TotalCallsToday,this.DocAuthkey,this.MissedCallsToday,this.T2DcallAssignmentMonthally,this.TotalCallsMonthally,
  this.MissedCallsMonthally,this.FirstName,this.LastName,this.Description,this.TotalExperence,this.Country,this.State,this.City,this.Pic,this.ZipCode,
  this.Operator,this.Column1,this.Column2,this.T2DcallAssignmentToday,this.gender,this.DocCreateddate,this.AddressLine1,
    this.AddressLine2,this.MBBSCompletionDate,this.Specialization,this.hospitalId});

   factory DoctorModel.fromJSON(Map<String,dynamic> map){
     return DoctorModel(
         doctorID: map['doctorID'],
       MobileNo: map['MobileNo'],
         hospitalName: map['hospital_name'],
         addressLine1: map['address_line1'],
         addressLine2: map['address_line2'],
       hos_pic_url: map['hos_pic_url'],
       HospitalLogoPath: map['HospitalLogoPath'],
       HospitalUrl: map['HospitalUrl'],
     );
   }



  factory DoctorModel.fromOTPJSON(Map<String,dynamic> map){
  return DoctorModel(
                  T2DcallAssignmentToday: map['T2DcallAssignmentToday'].toString(),
                  TotalCallsToday: map['TotalCallsToday'].toString(),
                  MissedCallsToday: map['MissedCallsToday'].toString(),
                  T2DcallAssignmentMonthally: map['T2DcallAssignmentMonthally'].toString(),
                  TotalCallsMonthally: map['TotalCallsMonthally'].toString(),
                  MissedCallsMonthally: map['MissedCallsMonthally'].toString(),
                  doctorID: map['DocID'],
                  DocAuthkey: map['DocAuthkey'],
                  FirstName: map['FirstName'],
                  LastName: map['LastName'],
                  MobileNo: map['MobileNo'],
                  HighesQualification: map['HighesQualification'],
                  TotalExperence: map['TotalExperence'],
                  Description: map['Description'],
                  addressLine1: map['AddressLine1'],
                  addressLine2: map['AddressLine2'],
                  Country: map['Country'],
                  State: map['State'],
                  City: map['City'],
                  Pic: map['Pic'],
                  ZipCode: map['ZipCode'].toString(),
                  Operator: map['Operator'],
                  Column1: map['Column1'],
                  Column2: map['Column2'],
                  doctorCustomId: map['Column3'],
                  gender: map.containsKey('Gender')?map['Gender']:'',
                  DocCreateddate: map.containsKey('DocCreateddate')?map['DocCreateddate']:'',
                  AddressLine1: map.containsKey('AddressLine1')?map['AddressLine1']:'',
                  AddressLine2: map.containsKey('AddressLine2')?map['AddressLine2']:'',
                  MBBSCompletionDate: map.containsKey('MBBSCompletionDate')?map['MBBSCompletionDate']:'',
                  Specialization: map.containsKey('Specialization')?map['Specialization']:'',
                   hospitalId: map.containsKey('hospitalId')?map['hospitalId']:'',
        );
  }

    Map<String ,String> toMap(){
        var map={
          "T2DcallAssignmentToday": T2DcallAssignmentToday,
          "TotalCallsToday": TotalCallsToday,
          "MissedCallsToday": MissedCallsToday,
          "T2DcallAssignmentMonthally": T2DcallAssignmentMonthally,
          "TotalCallsMonthally": TotalCallsMonthally,
          "MissedCallsMonthally": MissedCallsMonthally,
          "DocID": doctorID,
          "DocAuthkey": DocAuthkey,
          "FirstName": FirstName,
          "LastName": LastName,
          "MobileNo": MobileNo,
          "HighesQualification": HighesQualification,
          "TotalExperence": TotalExperence,
          "Description": Description,
          "AddressLine1": addressLine1,
          "AddressLine2": addressLine2,
          "Country": Country,
          "State": State,
          "City": City,
          "Pic": Pic,
          "ZipCode": ZipCode,
          "Operator": Operator,
          "Column1": Column1,
          "Column2": Column2,
          "Column3": doctorCustomId,
          "Gender": gender,
          "DocCreateddate": DocCreateddate,
          "AddressLine1": AddressLine1,
          "AddressLine2": AddressLine2,
          "MBBSCompletionDate": MBBSCompletionDate,
          "Specialization": Specialization,
          "hospitalId": hospitalId,
        };

        return map;
    }

}