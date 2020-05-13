import 'package:flutter/material.dart';

class TextView extends StatelessWidget{
  TextView(this.str,{this.line,this.colors,this.size,this.mergin,this.align,this.decoration,this.padding,this.background,this.weight,this.onPress,this.fontName});

    final String str;
    Function onPress;
     String fontName="Roboto";
     int line=0;
    Color colors=Colors.black;
    Color background=Colors.white;
     double size=12;
    FontWeight weight=FontWeight.w500;
     EdgeInsets mergin=EdgeInsets.all(0);
     EdgeInsets padding=EdgeInsets.all(0);
     TextAlign align=TextAlign.start;
  TextDecoration decoration = TextDecoration.none;

  @override
  Widget build(BuildContext context) {

    InkWell inkWell = InkWell(
       onTap: onPress,
       child: Text(str,
         style: TextStyle(
           fontFamily:fontName,
           fontWeight:weight,
           color: colors,
           decoration: decoration,
           fontSize: size,
             wordSpacing: 1,
             letterSpacing: 0.2

         ),
         textAlign: align,),
    );
    if(line!=0){
      inkWell = InkWell(
        onTap: onPress,
        child: Text(

          str,maxLines: line,
          style: TextStyle(
            fontFamily:fontName,
            fontWeight:weight,
            color: colors,
            decoration: decoration,
            fontSize: size,
            wordSpacing: 1,
            letterSpacing: 0.2,
          ),

          textAlign: align,),
      );
    }
    return Container(child: inkWell,margin: mergin,padding: padding);
  }

}