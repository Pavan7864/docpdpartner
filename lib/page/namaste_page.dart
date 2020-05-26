import 'package:docpdpartner/custom_ui/imageView/FullImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NamasteScreen extends StatefulWidget{

  @override
  _NamasteScreen createState()=>_NamasteScreen();
}
class _NamasteScreen extends State<NamasteScreen>{

  var mobileController = new TextEditingController();
  FocusNode _nodeText1 = FocusNode();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();





    @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SafeArea(

            child: ChangeNotifierProvider<LoginProvider>(
              create: (context)=>LoginProvider(context,''),
              child: Consumer(builder: (context,LoginProvider model,child){

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: Container(
                      margin: const EdgeInsets.only(top:50 ,left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ImageViewSize('assets/icon/namste.png',100,100,mergin: const EdgeInsets.only(bottom: 30),),
                          TextView('Dear Doctor,',colors: Theme.of(context).primaryColor,weight: FontWeight.w500,size: 28,),
                          TextView('Welcome to docOPD,',colors: Theme.of(context).primaryColor,weight: FontWeight.w500,size: 28,)

                        ],
                      ),
                    )),

                    Container(
                      margin: const EdgeInsets.only(right: 30,left: 30),
                      child:Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            child: TextView('+91',size: 16,weight: FontWeight.w600,colors: Theme.of(context).hintColor.withOpacity(0.4),),
                          ),
                          SizedBox(width: 30,),
                          Expanded(child: TextField(
                              controller: mobileController,
                               onChanged: (v){
                                 model.setMobile(v);
                                 if(v.length==10){
                                   FocusScope.of(context).requestFocus(FocusNode());
                                 }
                               },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                 focusedBorder: InputBorder.none,
                                  hintText: 'Enter your mobile Number',
                                counterText: '',
                                  hintStyle: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.4),fontSize: 16,fontWeight: FontWeight.w600),

                              ),
                            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.w600),
                             textInputAction: TextInputAction.done,
                             maxLength: 10,
                             keyboardType: TextInputType.numberWithOptions(signed: true,decimal: true)

                          ))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 30,left: 30),
                      child:Row(
                        children: <Widget>[
                          Container(
                           height: 1,
                            width: 50,
                            color: Theme.of(context).hintColor.withOpacity(0.4),
                          ),
                          SizedBox(width: 30,),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Theme.of(context).hintColor.withOpacity(0.4),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 30,left: 30,top: 2),
                      child:Row(
                        children: <Widget>[
                          Container(
                           height: 1,
                          ),
                          SizedBox(width: 30,),
                          Expanded(
                            child: Container(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: TextView(model.isEmpty?'Mobile can\'t be empty':model.isNotValid?'Mobile no. should be 10 digits':'',
                                     size: 11,colors: Colors.red,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),


                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 35,bottom: 40),
                        padding: const EdgeInsets.all(5),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: model.isLoader?CircularProgressIndicator():RaisedButton(
                              onPressed: (){
                                model.validMobile(_scaffoldKey);
                              },
                               color: Theme.of(context).accentColor,
                               splashColor: Theme.of(context).backgroundColor,
                               child: TextView('Next',size: 18,colors: Theme.of(context).backgroundColor,
                                 weight: FontWeight.w600,
                                 padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),),
                          ),
                        ),
                      ),
                    )



                  ],
                );
              }),
            ),


      ),
    );
  }
}