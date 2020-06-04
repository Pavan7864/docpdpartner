import 'package:docpdpartner/custom_ui/imageView/FullImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/main.dart';
import 'package:docpdpartner/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget{
  final Object arguments;
  OTPScreen(this.arguments);
  @override
  _OTPScreen createState()=>_OTPScreen();
}
class _OTPScreen extends State<OTPScreen>{

   String mobile;
   LoginProvider _app;
   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

   FocusNode otpFoucs = FocusNode();

   KeyboardActionsConfig _buildConfig(BuildContext context) {
     return KeyboardActionsConfig(
       keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
       keyboardBarColor: Colors.grey[200],
       nextFocus: true,
       actions: [
         KeyboardAction(
           focusNode: otpFoucs,
           onTapAction: () async {
             FocusScope.of(context).requestFocus(FocusNode());
           },
         )
       ],
     );
   }

  @override
  Widget build(BuildContext context) {
    final  Map<String, Object> data = widget.arguments;
    mobile=data['mobile'].toString();
   _app= LoginProvider(context,mobile);



    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SafeArea(
            top: true,
          child: KeyboardActions(
            config: _buildConfig(context),
            child: ChangeNotifierProvider<LoginProvider>(
              create: (context)=>_app,
              child: Consumer(builder: (context,LoginProvider model,child){


                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Container(
                       padding: const EdgeInsets.all(10),
                       child: Row(
                         children: <Widget>[
                           IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                           Expanded(
                             child: TextView(
                               'OTP',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,
                             ),
                           ),
                           Container(
                             width:40,
                           )
                         ],
                       ),
                     ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            TextView(mobile,colors: Theme.of(context).primaryColor,weight: FontWeight.w500,size: 26,align: TextAlign.center,),
                            TextView('Please enter code sent to your mobile number',colors: Theme.of(context).primaryColor,align: TextAlign.center,
                              weight: FontWeight.w400,size: 13,mergin: const EdgeInsets.only(top: 5),)

                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(right: 50,left: 50,top: 150),
                      child:Row(
                        children: <Widget>[

                          Expanded(child: TextField(
                            onChanged: (v){
                              model.setOTP(v);
                              if(v.length==4){
                                FocusScope.of(context).requestFocus(FocusNode());
                              }
                            },
                            focusNode: otpFoucs,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Code',
                              counterText: '',
                              hintStyle: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.4),letterSpacing: 1,fontSize: 16,fontWeight: FontWeight.w600),

                            ),
                            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,letterSpacing: 35,fontWeight: FontWeight.w600),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            maxLengthEnforced: true,
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 50,left: 50),
                      child:Row(
                        children: <Widget>[

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
                      margin: const EdgeInsets.only(right: 50,left: 50,top: 2),
                      child:Row(
                        children: <Widget>[

                          Expanded(
                            child: Container(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: TextView(model.isEmpty?'OTP can\'t be empty':model.isNotValid?'OTP should be 4 digits':'',
                                  size: 11,colors: Colors.red,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(right: 50,top: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: model.isOTPResend?CircularProgressIndicator():InkWell(
                           onTap:(){
                             model.resendOTP(_scaffoldKey);
                           },
                          child: TextView('Resend code ?',
                            size: 16,colors: Theme.of(context).hintColor,),
                        ),
                      ),
                    ),


                    Container(
                      margin: const EdgeInsets.only(right: 35,bottom: 50,top:100),
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: model.isLoader?CircularProgressIndicator():RaisedButton(
                          onPressed:(){
                            model.validOTP(_scaffoldKey);
                          },
                          color: Theme.of(context).accentColor,
                          splashColor: Theme.of(context).backgroundColor,
                          child: TextView('Verify',size: 18,colors: Theme.of(context).backgroundColor,
                            weight: FontWeight.w600,
                            padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),),
                        ),
                      ),
                    )



                  ],
                );
              }),
            ),
          )

      ),
    );
  }

   _showSnackBar() {
     Scaffold.of(context).showSnackBar(SnackBar(
       content: Text("OTP resend successfully",style: TextStyle(color: Colors.green),),
     ));
   }


}