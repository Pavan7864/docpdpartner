import 'dart:async';

import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/custom_ui/imageView/dotted_border.dart';
import 'package:docpdpartner/model/diagnosis_model.dart';
import 'package:docpdpartner/model/symptomp_model.dart';
import 'package:docpdpartner/option_model.dart';
import 'package:docpdpartner/provider/diagnosis_provider.dart';
import 'package:docpdpartner/provider/my_availibality_provider.dart';
import 'package:docpdpartner/provider/symptomp_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SymptompSearch extends StatefulWidget{
  List<SymptompModel> arrList;
  SymptompSearch(this.arrList);

  @override
  _SymptompSearch createState()=>_SymptompSearch();
}
class _SymptompSearch extends State<SymptompSearch> {

  Timer timer;
  SymptompProvider app;

  @override
  void initState() {
    super.initState();
  }

     @override
  Widget build(BuildContext context) {
    app=SymptompProvider(context,widget.arrList);
    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
       body: SafeArea(
           // ignore: missing_return
           child: WillPopScope(onWillPop: (){
             Navigator.pop(context,app.selectedSymtomps);
           },
           child: ChangeNotifierProvider<SymptompProvider>(
             create:(context)=>app,
             child: Consumer(builder: (context,SymptompProvider model,child){

               return Column(
                 children: <Widget>[
                   Container(
                     padding: const EdgeInsets.all(10),
                     child: Row(
                       children: <Widget>[
                         IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop(model.selectedSymtomps)),
                         Expanded(
                           child: TextView(
                             'Symptoms',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,),

                         ),
                         Container(
                           width:40,
                         )

                       ],
                     ),
                   ),

                   Container(
                     padding: const EdgeInsets.all(10),
                     color: background,
                     child: Card(
                       child: Container(
                         padding: const EdgeInsets.only(left: 20,top: 3,bottom: 3),
                         child: TextField(
                           decoration: InputDecoration(
                             border: InputBorder.none,
                             errorBorder: InputBorder.none,
                             focusedBorder: InputBorder.none,
                             enabledBorder: InputBorder.none,
                             disabledBorder: InputBorder.none,
                             hintText: 'Search Symptoms Name',
                             suffixIcon: Icon(Icons.search,size: 25,color: Theme.of(context).hintColor,),
                             hintStyle: TextStyle(fontWeight: FontWeight.w400,color: Theme.of(context).hintColor,fontSize: 18),
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
                         ),
                       ),

                     ),
                   ),
                   Container(
                       color: background,
                       child: Align(
                           alignment: Alignment.topLeft,
                           child: TextView('Common Symptoms Name',weight: FontWeight.w500,size: 14,colors: Theme.of(context).hintColor,
                             mergin: const EdgeInsets.all(10),))),

                   Expanded(child:model.isLoad?Center(
                     child: CircularProgressIndicator(),
                   ): SingleChildScrollView(
                     child: Container(
                       color: background,
                       padding: const EdgeInsets.only(left: 10,right: 10),
                       child: Wrap(
                         children: model.arrList.map((SymptompModel value){
                           return Container(
                             margin: const EdgeInsets.only(right: 7,bottom: 7),
                             child: InkWell(
                               onTap: (){
                                 model.selected(value);
                               },
                               child: Card(
                                 color: value.isSelected?Colors.white:background,
                                 elevation: 2,
                                 child: Container(
                                   decoration: BoxDecoration(
                                       border: value.isSelected?Border.all(color: Theme.of(context).dividerColor.withOpacity(0.7),width: 1):null
                                   ),
                                   padding: const EdgeInsets.all(10),

                                   child: TextView(value.name,weight: FontWeight.w500,size: 14,),
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
           ),)
       ),
    );
  }
}