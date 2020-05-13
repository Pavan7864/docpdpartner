import 'dart:async';

import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/days_medicine.dart';
import 'package:docpdpartner/model/medicine_model.dart';
import 'package:docpdpartner/model/routes_model.dart';
import 'package:docpdpartner/provider/add_medicine_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMedicineScreen extends StatefulWidget{
  MedicineModel medicineModel;
 AddMedicineScreen(this.medicineModel);

  @override
  _AddMedicineScreen createState()=>_AddMedicineScreen();
}
class _AddMedicineScreen extends State<AddMedicineScreen> {

  var timeArray=['BBF','AC','WF','HS','PC'];
  Timer timer;
  var app=AddMedicineProvider();

  @override
  void initState() {
    super.initState();
  }

     @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
       body: SafeArea(
           child: ChangeNotifierProvider<AddMedicineProvider>(
             create:(context)=>app,
          child: Consumer(builder: (context,AddMedicineProvider model,child){

            return Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: (){
                         Navigator.pop(context);
                      }),
                      Expanded(
                        child: TextView(
                          'Search & Add Medication',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,),

                      ),
                      Container(
                        width:30,
                      )

                    ],
                  ),
                ),

                Expanded(child: Container(
                  color: background,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 2,
                          child:Row(
                            children: <Widget>[
                              Expanded(child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  TextView('Medication Name',size: 12,weight: FontWeight.w400,colors: Theme.of(context).hintColor.withOpacity(0.7),
                                  mergin: const EdgeInsets.only(left: 10,top: 20),),
                                  TextView(widget.medicineModel.name??'',size: 14,weight: FontWeight.w500,colors: Theme.of(context).primaryColor,
                                    mergin: const EdgeInsets.only(left: 10,top: 5,bottom: 20),)
                                ],
                              )),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Center(
                                  child: Row(
                                    children: <Widget>[
                                      ImageViewSize('assets/icon/doctor_change.png',35,35,mergin: const EdgeInsets.only(right: 5),),
                                      TextView('Change\nMedication',size: 10,weight: FontWeight.w500,colors: Theme.of(context).hintColor,)
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),

                      TextView('Doses Amount and Unit',size: 14,weight: FontWeight.w500,colors: Theme.of(context).primaryColor,
                        mergin: const EdgeInsets.only(left: 12,top: 10,bottom: 10),),
                      
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                            child: Column(
                              children: <Widget>[

                                Row(
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/calendar.png',20,20,),
                                    TextView('How Many Days',size: 14,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      mergin: const EdgeInsets.only(left: 8),),
                                  ],
                                ),

                                Container(
                                  height: 140,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: GridView.count(
                                      crossAxisCount: 5,
                                      childAspectRatio: 1.25,
                                      physics: NeverScrollableScrollPhysics(),
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                      children: model.daysList.map((MedicineDay value) {
                                        return InkWell(
                                            onTap: (){
                                                  model.selectDay(value.index);
                                            },
                                          child: Card(
                                            elevation: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                   color: value.index==model.selectedDayPosition?Colors.white:background,
                                                  border: value.index==model.selectedDayPosition?Border.all(color: Theme.of(context).dividerColor,width: 1):null
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    TextView(value.days,size: 12,weight: FontWeight.w400,colors: Theme.of(context).hintColor.withOpacity(0.7),mergin: const EdgeInsets.only(top:3),),
                                                    TextView(value.times,size: 14,weight: FontWeight.w700,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.only(top:3),),
                                                  ],
                                                ),
                                              ),
                                          ),
                                        );
                                      }).toList()),
                                ),

                                Row(
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/frequency.png',20,20,),
                                    TextView('Frequency',size: 14,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      mergin: const EdgeInsets.only(left: 8),),
                                  ],
                                ),

                                Container(
                                  height: 150,
                                  margin: const EdgeInsets.only(top: 10,bottom: 20),
                                  child: GridView.count(
                                      crossAxisCount: 4,
                                      childAspectRatio: 1.20,
                                      physics: NeverScrollableScrollPhysics(),
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                      children: model.daysFrequency.map((MedicineDay value) {
                                        return InkWell(
                                          onTap: (){
                                            model.setfaq(value.index);
                                          },
                                          child: Card(
                                            elevation: 2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: value.index==model.selectedFrequency?Colors.white:background,
                                                  border: value.index==model.selectedFrequency?Border.all(color: Theme.of(context).dividerColor,width: 1):null
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Expanded(child: TextView(value.days,size: 10,align: TextAlign.center,line: 2,weight: FontWeight.w400,colors: Theme.of(context).hintColor.withOpacity(0.7),mergin: const EdgeInsets.only(top:3,left: 5,right: 5),)),
                                                  TextView(value.times,size: 14,weight: FontWeight.w700,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.only(top:3,bottom: 10),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList()),
                                ),

                                Row(
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/timeclock.jpg',20,20,),
                                    TextView('Select Time',size: 14,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      mergin: const EdgeInsets.only(left: 8),),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10,bottom: 0),
                                  child: Row(
                                    children: <Widget>[

                                      InkWell(
                                        onTap: (){
                                          model.timeSelect(0);
                                        },
                                        child: Card(
                                          elevation: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: 0==model.selectTime?Colors.white:background,
                                                border: 0==model.selectTime?Border.all(color: Theme.of(context).dividerColor,width: 1):null
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                TextView('Before Breakfast',size: 10,align: TextAlign.center,line: 2,weight: FontWeight.w400,colors: Theme.of(context).hintColor.withOpacity(0.7),mergin: const EdgeInsets.only(top:5,left: 5,right: 5),),
                                                TextView('BBF',size: 14,weight: FontWeight.w700,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.only(top:3,bottom: 5),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      InkWell(
                                        onTap: (){
                                          model.timeSelect(1);
                                        },
                                        child: Card(
                                          elevation: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: 1==model.selectTime?Colors.white:background,
                                                border: 1==model.selectTime?Border.all(color: Theme.of(context).dividerColor,width: 1):null
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                TextView('Before Meals',size: 10,align: TextAlign.center,line: 2,weight: FontWeight.w400,colors: Theme.of(context).hintColor.withOpacity(0.7),mergin: const EdgeInsets.only(top:5,left: 5,right: 5),),
                                                TextView('AC',size: 14,weight: FontWeight.w700,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.only(top:3,bottom: 5),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(child: InkWell(
                                        onTap: (){
                                          model.timeSelect(2);
                                        },
                                        child: Card(
                                          elevation: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: 2==model.selectTime?Colors.white:background,
                                                border: 2==model.selectTime?Border.all(color: Theme.of(context).dividerColor,width: 1):null
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                TextView('With Meal',size: 10,align: TextAlign.center,line: 2,weight: FontWeight.w400,colors: Theme.of(context).hintColor.withOpacity(0.7),mergin: const EdgeInsets.only(top:5,left: 5,right: 5),),
                                                TextView('WF',size: 14,weight: FontWeight.w700,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.only(top:3,bottom: 5),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),

                                      Expanded(child: InkWell(
                                        onTap: (){
                                          model.timeSelect(3);
                                        },
                                        child: Card(
                                          elevation: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: 3==model.selectTime?Colors.white:background,
                                                border: 3==model.selectTime?Border.all(color: Theme.of(context).dividerColor,width: 1):null
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                TextView('Bed Time',size: 10,align: TextAlign.center,line: 2,weight: FontWeight.w400,colors: Theme.of(context).hintColor.withOpacity(0.7),mergin: const EdgeInsets.only(top:5,left: 5,right: 5),),
                                                TextView('HS',size: 14,weight: FontWeight.w700,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.only(top:3,bottom: 5),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),

                                    ],
                                  ),

                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10,bottom: 20),
                                  child: Row(
                                    children: <Widget>[

                                      InkWell(
                                        onTap: (){
                                          model.timeSelect(4);
                                        },
                                        child: Card(
                                          elevation: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: 4==model.selectTime?Colors.white:background,
                                                border: 4==model.selectTime?Border.all(color: Theme.of(context).dividerColor,width: 1):null
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                TextView('After Meals',size: 10,align: TextAlign.center,line: 2,weight: FontWeight.w400,colors: Theme.of(context).hintColor.withOpacity(0.7),mergin: const EdgeInsets.only(top:5,left: 10,right: 10),),
                                                TextView('PF',size: 14,weight: FontWeight.w700,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.only(top:3,bottom: 5),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),


                                      Expanded(child: Container()),
                                      Expanded(child: Container()),


                                    ],
                                  ),

                                ),

                                Row(
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/routes.png',20,20,),
                                    TextView('Route of Administration',size: 14,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      mergin: const EdgeInsets.only(left: 8),),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10,bottom: 20),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        border: Border.all(color:background,width: 1)
                                      ),
                                      padding: EdgeInsets.only(left:20.0,right: 20),
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonHideUnderline(
                                        child: new DropdownButton<RoutesModel>(
                                          isExpanded: true,
                                          value: model.selectedRoute,
                                          iconEnabledColor: Theme.of(context).accentColor,
                                          hint: Text('Select Route',style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.w500),),
                                          items: model.listRoutes.map((RoutesModel value) {
                                            return new DropdownMenuItem<RoutesModel>(
                                              value: value,
                                              child: Text(value.title,style: TextStyle(color:Theme.of(context).primaryColor),),
                                            );
                                          }).toList(),
                                          onChanged: (v){
                                            model.clickRoute(v);
                                          },
                                        ),
                                      )
                                  ),
                                ),

                                Row(
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/doses.png',20,20,colors: Colors.black26,),
                                    TextView('Doses From',size: 14,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      mergin: const EdgeInsets.only(left: 8),),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10,bottom: 20),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                          border: Border.all(color:background,width: 1)
                                      ),
                                      padding: EdgeInsets.only(left:20.0,right: 20),
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonHideUnderline(
                                        child: new DropdownButton<RoutesModel>(
                                          isExpanded: true,
                                          value: model.selectedDoes,
                                          iconEnabledColor: Theme.of(context).accentColor,
                                          hint: Text('Select Doses',style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.w500),),
                                          items: model.arrDoas.map((RoutesModel value) {
                                            return new DropdownMenuItem<RoutesModel>(
                                              value: value,
                                              child: Text(value.title,style: TextStyle(color:Theme.of(context).primaryColor),),
                                            );
                                          }).toList(),
                                          onChanged: (v){
                                            model.clickDoes(v);
                                          },
                                        ),
                                      )

                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      TextView('Notes',size: 14,weight: FontWeight.w500,colors: Theme.of(context).primaryColor,
                        mergin: const EdgeInsets.only(left: 12,top: 5,bottom: 20),),


                      Container(
                        margin: const EdgeInsets.only(right: 15,bottom: 50,left: 15),
                        color: Colors.white,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(left: 10,right: 10,top: 7,bottom: 7)
                          ),

                          onChanged: (v){
                            model.setNotes(v);
                          },
                          style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 15,fontWeight: FontWeight.w400),
                        ),
                      ),



                      Container(
                        child: MaterialButton(
                          onPressed: (){
                            validation(context);
                          },
                          color: Colors.grey,
                          child: TextView('Save Medication',weight: FontWeight.w500,colors:Colors.black,size:20,padding: const EdgeInsets.only(top: 10,bottom: 10),),
                        ),
                      )

                    ],

                  ),
                ))



              ],
            );
       }),
       )),
    );
  }

   validation(BuildContext context){
      if(app.selectedDayPosition==-1){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("How many days is required"),
        ));
      }else if(app.selectedFrequency==-1){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Medication frequency is required"),
        ));
      }else if(app.selectTime==-1){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Medication time is required"),
        ));
      }else if(app.selectedRoute==null){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Route of administration is required"),
        ));
      }else if(app.selectedDoes==null){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Medication doses is required"),
        ));
      }else {
         widget.medicineModel.howManyDay=app.daysList[app.selectedDayPosition];
         widget.medicineModel.frequencyDay=app.daysFrequency[app.selectedFrequency];
         widget.medicineModel.selectTime=timeArray[app.selectTime];
         widget.medicineModel.selectroute=app.selectedRoute;
         widget.medicineModel.selectDoes=app.selectedDoes;
         widget.medicineModel.notes=app.notes;
         Navigator.pop(context,widget.medicineModel);
      }
   }
}