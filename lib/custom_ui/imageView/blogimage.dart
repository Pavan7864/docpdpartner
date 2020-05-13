import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:flutter/material.dart';


class BlogImages extends StatelessWidget{
  BlogImages(this.url,this.placeHolder);

  final String url;
  final String placeHolder;

  @override
  Widget build(BuildContext context) {

    if(url!=null&&url != '') {
      var arrimage=url.split("data-srcset=");
      if(arrimage.length>1){
      var arr=arrimage[1].split("?");
      String newUrl=arr[0].replaceAll("\"", "");

      try {
          return InkWell(
              onTap: (){
                // Navigator.pushNamed(context, '/ZoomImage',arguments: {"url" :newUrl});
              },
              child: Container(child: Image.network(ApiClient.imageBaseUrl+newUrl),)
          );
        } catch (e) {
              print(e);
        }
      }
      AssetImage assetImage = AssetImage(placeHolder);
      var image = Image(image: assetImage);
      return Container(child: image);
    }else{
      AssetImage assetImage = AssetImage(placeHolder);
    var image = Image(image: assetImage);
      return Container(child: image);
    }

  }

}