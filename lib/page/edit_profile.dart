import 'package:docpdpartner/adapter/prescription.dart';
import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/custom_ui/imageView/dotted_border.dart';
import 'package:docpdpartner/provider/home_provider.dart';
import 'package:docpdpartner/provider/patient_provider.dart';
import 'package:docpdpartner/provider/profile_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget{

   @override
   _EditProfile createState()=>_EditProfile();
}

class _EditProfile extends State<EditProfile>{

  DateTime selectedDate = DateTime.now();
  ProfileProvider app;

    @override
  Widget build(BuildContext context) {
      app=ProfileProvider(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:SafeArea(
          top: true,
          child: ChangeNotifierProvider<ProfileProvider>(
             create: (context)=>app,
            child: Consumer(builder: (context,ProfileProvider model,child){
              String mobile= model.doctor.MobileNo??'';
              String name= model.doctor==null?'':model.doctor.LastName==null || model.doctor.FirstName==null?'':model.doctor.LastName==null?model.doctor.FirstName:model.doctor.FirstName+' '+model.doctor.LastName;
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                        Expanded(
                          child: TextView(
                            'Edit Profile',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,
                          ),

                        ),


                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[

                        Container(
                          color: Color(0xfff1f1f1),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 30,bottom: 30),
                          child: Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: <Widget>[
                                InkWell(
                                    onTap:(){


                                    },
                                    child: CircleImageView(model.doctor==null?'':model.doctor.Pic!=null?model.doctor.Pic:'https://image.freepik.com/free-photo/doctor-smiling-with-stethoscope_1154-36.jpg',80)
                                ),
                                
                                Positioned(
                                    bottom: 10,
                                    right: 0,
                                    child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Icon(Icons.edit,color: Theme.of(context).dividerColor,size: 12,),
                                ))
                              ],
                            ),
                          ),
                        ),

                        TextView('About',size: 14,weight: FontWeight.w400, colors: Theme.of(context).hintColor,
                          mergin: const EdgeInsets.only(top: 20,bottom: 5,left: 15),),

                        Container(
                          margin: const EdgeInsets.only(right: 15,bottom: 5,left: 15),

                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: TextEditingController(text: model.doctor.Description??''),
                            maxLines: 4,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(left: 10,right: 10,top: 7,bottom: 7)
                            ),
                            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 15,fontWeight: FontWeight.w400),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(right: 15,top: 20,left: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(child:  TextField(
                                    controller: TextEditingController(text:name ),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Full Name'
                                  ),
                                onChanged: model.setName,
                              )),
                               Container(width: 10,),
                              Expanded(child: TextField(
                                enabled: false,
                                controller: TextEditingController(text:mobile),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mobile Number'
                                ),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                onChanged: model.setMobile,
                              )),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(right: 15,top: 20,left: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(child:  InkWell(
                                onTap: (){
                                  selectDob(context);
                                },
                                child: TextField(
                                    enabled: false,
                                    controller: TextEditingController(text:AppUtils.setDate( model.dobDate)),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'D.O.B',
                                       suffixIcon: ImageViewSize('assets/icon/calendar.png',12,12)

                                    ),

                                ),
                              )),
                              Container(width: 10,),
                              Expanded(child: TextField(
                                enabled: false,
                                controller: TextEditingController(text:'${model.doctor.City??''} (${model.doctor.State??''})'),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Location'
                                ),
                                textInputAction: TextInputAction.done,
                              )),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(right: 15,top: 20,left: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextView('Completed MBBS',size: 13,weight: FontWeight.w500,colors: Theme.of(context).hintColor
                                    ,mergin: const EdgeInsets.only(left: 2,bottom: 8),),
                                  InkWell(
                                    onTap: (){
                                      selectMBBSDate(context);
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller: TextEditingController(text:AppUtils.setDate( model.completedMBBSDate)),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '',
                                          suffixIcon: ImageViewSize('assets/icon/calendar.png',12,12)

                                      ),

                                    ),
                                  ),
                                ],
                              )),
                              Container(width: 10,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextView('Start a Practice',size: 13,weight: FontWeight.w500,colors: Theme.of(context).hintColor
                                    ,mergin: const EdgeInsets.only(left: 2,bottom: 8),),
                                  InkWell(
                                    onTap: (){
                                      selectPractice(context);
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller: TextEditingController(text:AppUtils.setDate( model.practiceDate)),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '',
                                          suffixIcon: ImageViewSize('assets/icon/calendar.png',12,12)

                                      ),

                                    ),
                                  ),
                                ],
                              )),


                            ],
                          ),
                        ),

                        TextView('Select Language',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                          mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 30),),

                        Container(
                          margin: const EdgeInsets.only(left: 15,top: 10),
                          child: Wrap(
                            children: <Widget>[
                                Container(
                                    height: 40,
                                    width: 100,
                                  decoration: BoxDecoration(
                                    color: background,
                                    border: Border.all(color: Theme.of(context).hintColor,width: 1)
                                  ),
                                  child:Center(child: TextView('Hindi')),

                                ),
                                Container(
                                    height: 40,
                                    width: 50,
                                   margin: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    color: background,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                     Container(
                                       height: 40,
                                       width: 50,
                                        child:  Icon(Icons.add,size: 30,),
                                      ),
                                      Container(
                                          height: 40,
                                          width: 50,
                                          child: DashedRect(color: Theme.of(context).hintColor, strokeWidth: 2.0, gap: 3.0,)),

                                    ],
                                  ),

                                )
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 15,bottom: 8,top: 30),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: TextView('Select Gender',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,)),
                              InkWell(
                                onTap: (){
                                  model.setGender("Male");
                                },
                                child: ImageViewSize('assets/icon/male.png',50,50,
                                  colors: model.doctor==null?Colors.grey:model.doctor.gender=="Male"?Theme.of(context).dividerColor:Colors.grey,),
                              ),
                              InkWell(
                                onTap: (){
                                  model.setGender("Female");
                                },
                                child: ImageViewSize('assets/icon/female.png',50,50,mergin: const EdgeInsets.only(left: 15,right: 15),
                                 colors: model.doctor==null?Colors.grey:model.doctor.gender=="Female"?Theme.of(context).dividerColor:Colors.grey),
                              )

                            ],
                          ),
                        ),

                        TextView('Upload your doctor license image',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                          mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 30),),


                        Container(
                          margin: const EdgeInsets.only(left: 15,right: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).hintColor,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.attach_file,size: 30,color: Theme.of(context).hintColor,),
                              Container(height: 45,width: 1,color: Theme.of(context).hintColor ,margin: const EdgeInsets.only(left: 10,right: 20),),
                              Container(
                                height: 40,
                                width: 50,
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: background,
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 40,
                                      width: 50,
                                      child:  Icon(Icons.add,size: 30,),
                                    ),
                                    Container(
                                        height: 40,
                                        width: 50,
                                        child: DashedRect(color: Theme.of(context).hintColor, strokeWidth: 2.0, gap: 3.0,)),

                                  ],
                                ),

                              )
                            ],
                          ),

                        ),


                        TextView('Upload your singnature image',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                          mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 30),),


                        Container(
                          margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).hintColor,width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.attach_file,size: 30,color: Theme.of(context).hintColor,),
                              Container(height: 45,width: 1,color: Theme.of(context).hintColor ,margin: const EdgeInsets.only(left: 10,right: 20),),
                              Container(
                                height: 40,
                                width: 50,
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: background,
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 40,
                                      width: 50,
                                      child:  Icon(Icons.add,size: 30,),
                                    ),
                                    Container(
                                        height: 40,
                                        width: 50,
                                        child: DashedRect(color: Theme.of(context).hintColor, strokeWidth: 2.0, gap: 3.0,)),

                                  ],
                                ),

                              )
                            ],
                          ),

                        ),

                        RaisedButton(
                            onPressed: (){},
                           color: background,
                           padding: const EdgeInsets.only(top: 12,bottom: 12),
                           child: TextView('Update',colors: Theme.of(context).primaryColor,size: 18,weight: FontWeight.w600,),
                        )


                      ],
                    ),
                  ),




                ],
              );
            },),
          )
      ) ,
    );
  }



  Future<Null> selectDob(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:  DateTime(selectedDate.year-15, selectedDate.month,selectedDate.day),
        firstDate:DateTime(selectedDate.year-70, 8),
        lastDate: DateTime(selectedDate.year-15, selectedDate.month,selectedDate.day)
    );
    if (picked != null && picked != selectedDate)
           app.setDob(picked) ;

  }


  Future<Null> selectMBBSDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year-70, 8),
        lastDate: selectedDate
    );
    if (picked != null && picked != selectedDate)
          app.setMbbsDate(picked) ;

  }


  Future<Null> selectPractice(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year-70, 8),
        lastDate: selectedDate
    );
    if (picked != null && picked != selectedDate)
         app.setPracticeDate(picked) ;
  }

}