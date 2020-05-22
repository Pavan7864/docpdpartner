import 'dart:async';

import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/investigation_model.dart';
import 'package:docpdpartner/page/missed_call_page.dart';
import 'package:docpdpartner/page/patchology_view.dart';
import 'package:docpdpartner/page/redology_view.dart';
import 'package:docpdpartner/provider/investigation_provider.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestigationScreen extends StatefulWidget{
  InvestigationScreen(this.arrSelected);

  List<InvestigationModel> arrSelected;

  @override
  _InvestigationScreen createState()=>_InvestigationScreen();
}
class _InvestigationScreen extends State<InvestigationScreen> with SingleTickerProviderStateMixin{

  Timer timer;
  TabController tabController;
  InvestigationProvider app;

  @override
  void initState() {
    super.initState();
    tabController=new TabController(length: 2, vsync: this);
  }

     @override
  Widget build(BuildContext context) {
     app=InvestigationProvider(context,widget.arrSelected);
    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
       body: SafeArea(
           child: WillPopScope(
             // ignore: missing_return
             onWillPop: (){
                 Navigator.of(context).pop(app.selectedInvestigation);
           },
            child:  ChangeNotifierProvider<InvestigationProvider>(
              create: (context)=>app,
              child: Consumer(builder: (context,InvestigationProvider model,child){
                return Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop(model.selectedInvestigation)),
                          Expanded(
                            child: TextView(
                              'Search & Add Investigation',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,
                            ),

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
                              hintText: 'Search Investigation Name',
                              suffixIcon: Icon(Icons.search,size: 25,color: Theme.of(context).hintColor,),
                              hintStyle: TextStyle(fontWeight: FontWeight.w400,color: Theme.of(context).hintColor,fontSize: 18),
                            ),
                            onChanged: (v){
                              if(v.length>0){
                                if(timer!=null){
                                  timer.cancel();
                                }
                                timer=new Timer(Duration(milliseconds: 800), (){
                                  model.searchInvestigation(v);
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
                            child: TextView('Common Investigation Name',weight: FontWeight.w500,size: 14,colors: Theme.of(context).hintColor,
                              mergin: const EdgeInsets.all(10),))),

                    Expanded(child:  model.isLoadRdiology?Center(
                      child: CircularProgressIndicator(),
                    ): SingleChildScrollView(
                      child: Container(
                        color: background,
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          children: model.arrInvestigation.map((InvestigationModel value){
                            return Container(
                              margin: const EdgeInsets.only(right: 7,bottom: 7),
                              child: InkWell(
                                onTap: (){
                                  model.selectInvestigation(value);
                                },
                                child: Card(
                                  color: value.isSelected?Colors.white:background,
                                  elevation: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: value.isSelected?Border.all(color: Theme.of(context).dividerColor.withOpacity(0.7),width: 1):null
                                    ),
                                    padding: const EdgeInsets.all(10),

                                    child: TextView(value.itemName,weight: FontWeight.w500,size: 12,),
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