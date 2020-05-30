import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/option_model.dart';
import 'package:docpdpartner/provider/my_availibality_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAvailability extends StatefulWidget{

  @override
  _MyAvailability createState()=>_MyAvailability();
}
class _MyAvailability extends State<MyAvailability> {



  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  MyAvailibality _app;
  bool hideButton=false;
  @override
  void initState() {
    super.initState();
  }

     @override
  Widget build(BuildContext context) {
    _app=MyAvailibality(context,_scaffoldKey);
    return Scaffold(
      key: _scaffoldKey,
       backgroundColor: Theme.of(context).backgroundColor,
       body: SafeArea(
           child: ChangeNotifierProvider<MyAvailibality>(
             create:(context)=>_app,
          child: Consumer(builder: (context,MyAvailibality model,child){

            return Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                      Expanded(
                        child: TextView(
                          'My Availability',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,),

                      ),


                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                  color: background,

                  child: Row(
                    children: <Widget>[
                      Expanded(child: Card(
                        elevation: 3,
                        child: Row(
                          children: <Widget>[
                            Expanded(child: DropdownButtonHideUnderline(
                              child: new DropdownButton<OptionModel>(
                                isExpanded: true,
                                value: model.selectedType,
                                hint: TextView('Select Availability',size: 14,align: TextAlign.center,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                                  padding: const EdgeInsets.only(top: 15,bottom: 15,left: 5),),
                                items: model.list.map((OptionModel value) {
                                  return new DropdownMenuItem<OptionModel>(
                                    value: value,
                                    child: TextView(value.name,size: 14,align: TextAlign.start,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      padding: const EdgeInsets.only(top: 15,bottom: 15,left: 5),),
                                  );
                                }).toList(),
                                onChanged: model.selectMyAvailability,
                              ),
                            )),

                          ],
                        ),
                      )),

                      Expanded(child: Row(
                        children: <Widget>[
                          Expanded(child: InkWell(
                            onTap:(){
                              model.selectOpenTime(context, true);
                            },
                            child: Card(
                              elevation: 3,
                              child: TextView(model.startTime??'Start Time',size: 14,align: TextAlign.center,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                padding: const EdgeInsets.only(top: 15,bottom: 15,left: 5),),
                            ),
                          )),
                          Expanded(child: InkWell(
                            onTap:(){
                              model.selectOpenTime(context, false);
                            },
                            child: Card(
                              elevation: 3,
                              child: TextView(model.endTime??'End Time',size: 14,align: TextAlign.center,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                padding: const EdgeInsets.only(top: 15,bottom: 15,left: 5),),
                            ),
                          ))

                        ],
                      ))
                    ],
                  ),
                ),

                Expanded(child:model.loadData?Center(
                  child: CircularProgressIndicator(),
                ):ListView.builder(
                    itemCount: model.avalibleArray.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      var day=model.avalibleArray[index];
                      return Container(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                        color: background,

                        child: Row(
                          children: <Widget>[
                            Expanded(child: Card(
                              elevation: 3,
                              color: day.isSelected?Theme.of(context).dividerColor:Colors.white,
                              child:  TextView(day.name,size: 14,align: TextAlign.center,weight: FontWeight.w500,
                                colors: day.isSelected?Colors.white:Theme.of(context).hintColor,
                                padding: const EdgeInsets.only(top: 15,bottom: 15,left: 5),),
                            )),

                            Expanded(child: Row(
                              children: <Widget>[
                                Expanded(child: InkWell(
                                  onTap:(){
                                    if(model.myAvailability==1 && (model.oneDay==index || model.oneDay==-1)){
                                       model.isSelect(index);
                                    }
                                    if(day.isSelected)
                                      model.selectTime(context, index, true);
                                  },
                                  child: Card(
                                    elevation: 3,
                                    child: TextView(day.startTime??'',size: 14,align: TextAlign.center,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      padding: const EdgeInsets.only(top: 15,bottom: 15,left: 5),),
                                  ),
                                )),
                                Expanded(child: InkWell(
                                  onTap:(){
                                    if(model.myAvailability==1 && (model.oneDay==index || model.oneDay==-1)){
                                      model.isSelect(index);
                                    }
                                    if(day.isSelected)
                                       model.selectTime(context, index, false);
                                  },
                                  child: Card(
                                    elevation: 3,
                                    child: TextView(day.endTime??'',size: 14,align: TextAlign.center,weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      padding: const EdgeInsets.only(top: 15,bottom: 15,left: 5),),
                                  ),
                                ))

                              ],
                            ))
                          ],
                        ),
                      );
                    }
                ))


              ],
            );
       }),
       )),
       bottomNavigationBar: Container(
         height: 50,
         child: hideButton?Center(
           child: CircularProgressIndicator(),
         ): RaisedButton(
           onPressed: (){
             setState(() {
               hideButton=true;
             });
             _app.setAvailability((){
                setState(() {
                  hideButton=false;
                });
             });
           },
           color: background,
           padding: const EdgeInsets.only(top: 12,bottom: 12),
           child: TextView('Update',colors: Theme.of(context).primaryColor,size: 18,weight: FontWeight.w600,),
         ),
       ),
    );
  }
}