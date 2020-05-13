import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InnerWebPage extends StatefulWidget{
  final String url;
  InnerWebPage(this.url);

    @override
   _InnerWebPage createState()=>_InnerWebPage();
}

class _InnerWebPage extends State<InnerWebPage>{
  final Completer<WebViewController> _controller = Completer<WebViewController>();

    @override
  Widget build(BuildContext context) {

    return  Scaffold(
        body:Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left:10,top: 35,bottom: 10),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),


                ],
              ),
            ),
           Expanded(child:  Builder(builder: (BuildContext context) {
             return WebView(
               initialUrl: 'https://docs.google.com/gview?embedded=true&url=${widget.url}',
               javascriptMode: JavascriptMode.unrestricted,
               onWebViewCreated: (WebViewController webViewController) {
                 _controller.complete(webViewController);
               },

               // ignore: prefer_collection_literals
               javascriptChannels: <JavascriptChannel>[
                 _toasterJavascriptChannel(context),
               ].toSet(),
               navigationDelegate: (NavigationRequest request) {
//              if (request.url.startsWith('https://www.youtube.com/')) {
//                print('blocking navigation to $request}');
//                return NavigationDecision.prevent;
//              }
//              print('allowing navigation to $request');
                 return NavigationDecision.navigate;
               },
               onPageStarted: (String url) {
                 print('Page started loading: $url');
               },
               onPageFinished: (String url) {
                 print('Page finished loading: $url');
               },
               gestureNavigationEnabled: true,
             );
           }))
          ],
        ),

      );
    }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}