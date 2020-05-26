import 'dart:convert';
import 'dart:io';
import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/NetWorkImage.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/custom_ui/imageView/dotted_border.dart';
import 'package:docpdpartner/model/doctor_model.dart';
import 'package:docpdpartner/model/language_model.dart';
import 'package:docpdpartner/page/language_page.dart';
import 'package:docpdpartner/provider/profile_provider.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class EditProfile extends StatefulWidget{

   @override
   _EditProfile createState()=>_EditProfile();
}

class _EditProfile extends State<EditProfile>{

  DateTime selectedDate = DateTime.now();
  ProfileProvider app;

  bool isLoaded=false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File profile;
  File signature;
  File lincences;
  int type=1; //1-Profile, 2- Signature, 3- Lincences


  Widget optionDialog(BuildContext context){


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white
          ),
          child: Column(
            children: <Widget>[
              TextView('Choose Option',size: 20,mergin: const EdgeInsets.all(10),),

              Container(
                margin: const EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: (){
                    gelleryImage();
                    Navigator.pop(context);
                  },
                  child:  TextView('Gallery',size: 16),
                ),
              ) ,
              MaterialButton(
                onPressed: (){
                  _cameraPreviewWidget();
                  Navigator.pop(context);
                },
                child:  TextView('Camera',size: 16),
              )

            ],
          ),
        ),
      );
    }
    );
  }

  Future gelleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(image !=null) {
      setState(() {
        if (type == 1) {
          profile = image;
          updateImage(image, 'DoctorPic');
        } else if (type == 2) {
          signature = image;
          updateImage(image, 'Signature');
        } else {
          lincences = image;
          updateImage(image, 'Licence');
        }
      });
    }
  }

  Future _cameraPreviewWidget() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if(image !=null) {
      setState(() {
        if (type == 1) {
          profile = image;
          updateImage(image, 'DoctorPic');
        } else if (type == 2) {
          signature = image;
          updateImage(image, 'Signature');
        } else {
          lincences = image;
          updateImage(image, 'Licence');
        }
      });
    }
  }

    @override
  Widget build(BuildContext context) {
      app=ProfileProvider(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldKey,
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
                                    onTap: (){
                                      if(!isLoaded) {
                                        type = 1;
                                        optionDialog(context);
                                      }
                                    },
                                    child: profile!=null?
                                    ClipRRect(
                                      borderRadius: new BorderRadius.circular(40),
                                      child:  Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1),
                                          borderRadius: BorderRadius.all(Radius.circular(40)),

                                        ),
                                        padding: const EdgeInsets.all(1),
                                        child: ClipRRect(
                                          borderRadius: new BorderRadius.circular(40),
                                          child:  Image.file(profile,fit: BoxFit.fill),
                                        ),
                                      ),
                                    )
                                        :CircleImageView(model.doctor==null?'':model.doctor.Pic,80)
                                ),
                                
                                Positioned(
                                    bottom: 10,
                                    right: 0,
                                    child:  type==1&&isLoaded?Center(
                                      child: CircularProgressIndicator(),
                                    ):Container(
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
                            onChanged:(v){
                              model.setAboutUs(v);
                            },
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
                            children: model.arrSpeakLang.map((String value){

                              if(value!='Add'){
                                return Container(
                                  height: 40,
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 10,bottom: 10),
                                  decoration: BoxDecoration(
                                      color: background,
                                      border: Border.all(color: Theme.of(context).hintColor,width: 1)
                                  ),
                                  child:Center(child: TextView(value)),

                                );
                              }else{
                                return InkWell(
                                  onTap: () async {
                                    List<LanguageModel> m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>LanguageScreen(model.arrSelectLang)));
                                    if(m!=null){
                                      model.language(m);
                                    }

                                  },
                                  child: Container(
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

                                  ),
                                );
                              }


                            }).toList(),
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
                              type==2&&isLoaded?Center(
                                child: CircularProgressIndicator(),
                              ):Container(
                                height: 40,
                                width: 50,
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: background,
                                ),
                                child: InkWell(
                                  onTap: (){
                                       if(!isLoaded) {
                                         type = 3;
                                         optionDialog(context);
                                       }
                                  },
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
                                ),

                              ),
                              model.doctor.licences!=null &&model.doctor.licences!='' && lincences==null?Expanded(

                                  child: Container(
                                      height:100,
                                      child: AppImageImage(model.doctor.licences,'assets/icon/placeholder.png'))):lincences==null?Container():Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.only(left: 50),
                                child: Image.file(lincences,fit: BoxFit.fill),
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
                              type==3&&isLoaded?Center(
                                child: CircularProgressIndicator(),
                              ):Container(
                                height: 40,
                                width: 50,
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: background,
                                ),
                                child: InkWell(
                                  onTap: (){

                                    if(!isLoaded) {
                                        type=2;
                                        optionDialog(context);
                                    }
                                  },
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
                                ),

                              ),
                              model.doctor.signature!=null &&model.doctor.signature!='' && signature==null?Expanded(

                                  child: Container(
                                      height:100,
                                      width: 100,child: AppImageImage(model.doctor.signature,'assets/icon/placeholder.png'))):signature==null?Container():Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.only(left: 50),
                                child: Image.file(signature,fit: BoxFit.fill,),
                              )
                            ],
                          ),

                        ),

                        model.isLoaded?Center(
                          child: CircularProgressIndicator(),
                        ):RaisedButton(
                            onPressed: (){
                               model.updateProfile(_scaffoldKey);
                            },
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




  Future updateImage(File file,String fileType) async {

    setState(() {
      type=type;
      isLoaded=true;
    });
    Uri  uri = Uri.parse(ApiClient.API_URL+ApiClient.paDoctorImageUpload);
    var request = new http.MultipartRequest("POST", uri);
    DoctorModel doctor=await MyAppPrefrences.getLogin();

    String name;
    if(type==1)
      name="ABC_DoctorPicture_"+doctor.doctorCustomId+'.jpg';
    else if(type==2)
      name="ABC_DoctorLicence_"+doctor.doctorCustomId+'.jpg';
    else if(type==3)
      name="ABC_DoctorSignature_"+doctor.doctorCustomId+'.jpg';


      var stream = new http.ByteStream(DelegatingStream.typed( file.openRead()));
      var length = await  file.length();
      var multipartFile = new http.MultipartFile('report', stream, length, filename:name);
      request.files.add(multipartFile);

    request.headers['Content-Type']='image/*';
    request.headers['X-Requested-With']='XMLHttpRequest';

    try {
      var response = await request.send();
      String body=await response.stream.bytesToString();
      print(body);
      if(!AppUtils.isEmpty(body)){
        var js=json.decode(body);
        if(js['Status']==1 || js['Status']=='1'){
          if(type==1)
            doctor.Pic=js['url'];
          else if(type==2)
            doctor.licences=js['url'];
          else if(type==3)
            doctor.signature=js['url'];
          MyAppPrefrences.saveLogin(doctor);
        }
      }
    }catch(_){
      print(_);
    }
    if(mounted)
      setState(() {
        isLoaded=false;
      });

  }

}