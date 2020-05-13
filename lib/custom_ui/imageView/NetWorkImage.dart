import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:flutter/material.dart';


class AppImageImage extends StatelessWidget{
  AppImageImage(this.url,this.placeHolder,{this.mergin,this.padding,this.fit,this.height,this.weight});

  final String url;
  final String placeHolder;
  BoxFit fit = BoxFit.none;
  EdgeInsets mergin=EdgeInsets.all(0);
  EdgeInsets padding=EdgeInsets.all(0);

  double height=0;
  double weight=0;
  @override
  Widget build(BuildContext context) {

    if(url!=null&&url != '') {
//      var arrimage=url.split("?");
//      String newUrl=arrimage[0];

      try {
        return Container(child: Image.network(ApiClient.imageBaseUrl+url,fit: fit,),margin: mergin,padding: padding,);
      } catch (e) {

      }
      AssetImage assetImage = AssetImage(placeHolder);
      var image = Image(image: assetImage, width: weight,
          fit: fit,
          height: height);
      return Container(child: image,margin: mergin,padding: padding,);
    }else{
      AssetImage assetImage = AssetImage(placeHolder);
    var image = Image(image: assetImage, width: weight,
          fit: fit,
          height: height);
      return Container(child: image,margin: mergin,padding: padding,);
    }

  }

}