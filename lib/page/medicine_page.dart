import 'dart:async';

import 'package:docpdpartner/adapter/selected_medicine_adapter.dart';
import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/custom_ui/imageView/dotted_border.dart';
import 'package:docpdpartner/model/diagnosis_model.dart';
import 'package:docpdpartner/model/medicine_model.dart';
import 'package:docpdpartner/option_model.dart';
import 'package:docpdpartner/page/add_medicine_page.dart';
import 'package:docpdpartner/provider/diagnosis_provider.dart';
import 'package:docpdpartner/provider/medicine_provider.dart';
import 'package:docpdpartner/provider/my_availibality_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicineSearch extends StatefulWidget{
  List<MedicineModel> arrList=[];
  MedicineSearch(this.arrList);

  @override
  _MedicineSearch createState()=>_MedicineSearch();
}
class _MedicineSearch extends State<MedicineSearch> {

  Timer timer;
  MedicineProvider app;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

     @override
  Widget build(BuildContext context) {
    app=MedicineProvider(context,widget.arrList,globalKey);
    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
       key: globalKey,
       body: SafeArea(
           child: WillPopScope(
             // ignore: missing_return
             onWillPop: (){
                Navigator.pop(context,app.arrSelectedMedicine);
             },
             child: ChangeNotifierProvider<MedicineProvider>(
               create:(context)=>app,
               child: Consumer(builder: (context,MedicineProvider model,child){

                 return Column(
                   children: <Widget>[
                     Container(
                       padding: const EdgeInsets.all(10),
                       child: Row(
                         children: <Widget>[
                           IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: (){
                             Navigator.pop(context,model.arrSelectedMedicine);
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

                     Container(
                       padding: const EdgeInsets.all(10),
                       color: background,
                       child: Card(
                         child: Container(
                           padding: const EdgeInsets.only(left: 10,top: 3,bottom: 3),
                           child: Row(
                             children: <Widget>[
                               Container(
                                 width: 80,
                                 margin: const EdgeInsets.only(right: 5),
                                 child: DropdownButtonHideUnderline(
                                   child: new DropdownButton<String>(
                                     isExpanded: true,
                                     value: model.medicineType,
                                     iconEnabledColor: Theme.of(context).accentColor,
                                     hint: Text('Generic',style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.w500,fontSize: 12),),
                                     items: ['Generic','Allopathy'].map((String value) {
                                       return new DropdownMenuItem<String>(
                                         value: value,
                                         child: Text(value,style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 12),),
                                       );
                                     }).toList(),
                                     onChanged: (v){
                                       if(v=='Generic'){
                                         model.setMedicineType(v,1);
                                       }else{
                                         model.setMedicineType(v,2);
                                       }
                                     },
                                   ),
                                 ),
                               ),
                               Expanded(child: TextField(
                                 decoration: InputDecoration(
                                   border: InputBorder.none,
                                   errorBorder: InputBorder.none,
                                   focusedBorder: InputBorder.none,
                                   enabledBorder: InputBorder.none,
                                   disabledBorder: InputBorder.none,
                                   hintText: 'Search Medication Name',
                                   suffixIcon: Icon(Icons.search,size: 25,color: Theme.of(context).hintColor,),
                                   hintStyle: TextStyle(fontWeight: FontWeight.w400,color: Theme.of(context).hintColor,fontSize: 14),
                                 ),
                                 onChanged: (v){
                                   if(v.length>0){
                                     if(timer!=null){
                                       timer.cancel();
                                     }
                                     timer=new Timer(Duration(milliseconds: 800), (){
                                       model.search(v);
                                     });
                                   }else if(timer!=null){
                                     timer.cancel();
                                   }
                                 },
                                 style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                               ))
                             ],
                           ),
                         ),

                       ),
                     ),
                     Container(
                         color: background,
                         child: Align(
                             alignment: Alignment.topLeft,
                             child: TextView('See Medication (${model.arrSelectedMedicine.length})',weight: FontWeight.w500,size: 14,colors: Theme.of(context).hintColor,
                               mergin: const EdgeInsets.all(10),))),

                     Container(
                       height: 105,
                       child: ListView.builder(
                           itemCount: model.arrSelectedMedicine.length,
                           scrollDirection: Axis.horizontal,
                           itemBuilder: (context,index){
                             return SelectedMedicineAdapter(model.arrSelectedMedicine[index],model.removeSelected);
                           }),
                     ),


                     Container(
                         color: background,
                         child: Align(
                             alignment: Alignment.topLeft,
                             child: TextView('Common Medication Name',weight: FontWeight.w500,size: 14,colors: Theme.of(context).hintColor,
                               mergin: const EdgeInsets.all(10),))),

                     Expanded(child:model.isLoad?Center(
                       child: CircularProgressIndicator(),
                     ): SingleChildScrollView(
                       child: Container(
                         color: background,
                         padding: const EdgeInsets.only(left: 10,right: 10),
                         width: MediaQuery.of(context).size.width,
                         child: Wrap(
                           children: model.arrMedicine.map((MedicineModel value){
                             return Container(
                               margin: const EdgeInsets.only(right: 7,bottom: 7),
                               child: InkWell(
                                 onTap: () async {
                                   if(!value.isSelected) {
                                     MedicineModel m = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedicineScreen(value)));
                                     if (m != null)
                                       model.selected(m);
                                   }
                                 },
                                 child: Card(
                                   color: value.isSelected?Colors.white:background,
                                   elevation: 2,
                                   child: Container(
                                     decoration: BoxDecoration(
                                         border: value.isSelected?Border.all(color: Theme.of(context).dividerColor.withOpacity(0.7),width: 1):null
                                     ),
                                     padding: const EdgeInsets.all(10),

                                     child: TextView(value.name,weight: FontWeight.w500,size: 12,),
                                   ),
                                 ),
                               ),
                             );
                           }).toList(),
                         ),
                       ),
                     ))




                   ],
                 );
               }),
             ),
           )
       ),
    );
  }
}