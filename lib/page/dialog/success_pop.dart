import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:flutter/material.dart';

class SuccessPopUp extends StatelessWidget{
String msg;
 SuccessPopUp(this.msg);

    @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: WillPopScope(
        onWillPop: () {},
        child: Container(
          height: 350,
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 0,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                        top: 50,
                        bottom:16,
                        left: 16,
                        right: 16,
                      ),
                      margin: EdgeInsets.only(top:30),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: const Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // To make the card compact
                        children: <Widget>[
                          Text(
                            "Success",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            padding: const EdgeInsets.only(left: 35,right: 35),
                            child: Text(
                              msg,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),

                          SizedBox(height: 25.0),

                        ],
                      ),
                    ),

                    Positioned(
                        left: 16,
                        right: 16,
                        child: ImageViewSize('assets/icon/tick.png', 60,60,)
                    )
                  ],
                ),
              ),
              Expanded(
                child: IconButton(icon: Icon(Icons.close,color: Colors.white,size: 40,), onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context,1);
                }),
              )
            ],
          ),
        ),
      ),
    );;
  }
}