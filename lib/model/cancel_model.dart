class CancelModel{
   String cancelReason="";
   CancelModel({this.cancelReason});

   factory CancelModel.fromJSON(Map<String,dynamic> map){

     return CancelModel(
         cancelReason: map['cancelReason']
     );
   }
}