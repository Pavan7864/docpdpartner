class TimeModel{

   String mondayTiming;
   String tuesdayTiming;
   String wednesdayTiming;
   String thursdayTiming;
   String fridayTiming;
   String saturdayTiming;
   String sundayTiming;

   TimeModel({this.mondayTiming,this.tuesdayTiming,this.wednesdayTiming,this.thursdayTiming,this.fridayTiming,this.saturdayTiming,this.sundayTiming});

   factory TimeModel.fromJSON(Map<String,dynamic> map){
       return TimeModel(
           mondayTiming: map['mondayTiming'],
         tuesdayTiming: map['tuesdayTiming'],
         wednesdayTiming: map['wednesdayTiming'],
         thursdayTiming: map['thursdayTiming'],
         fridayTiming: map['fridayTiming'],
         saturdayTiming: map['saturdayTiming'],
         sundayTiming: map['sundayTiming'],
       );
   }
}

