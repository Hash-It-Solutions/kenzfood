import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../utils/ResponsiveInfo.dart';

class ResorceWeb extends StatefulWidget {

  String url;

   ResorceWeb(this.url) : super();

  @override
  _ResorceWebState createState() => _ResorceWebState(url);
}

class _ResorceWebState extends State<ResorceWeb> {


  String url;

  _ResorceWebState(this.url);





  // late WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //
    //         print(progress);
    //       },
    //       onPageStarted: (String url) {
    //
    //         print("page loaded : "+url);
    //
    //       },
    //       onPageFinished: (String url) {
    //
    //         print("page finished : "+url);
    //       },
    //       onWebResourceError: (WebResourceError error) {
    //
    //         print("page error : "+error.toString());
    //       },
    //       onNavigationRequest: (NavigationRequest request) {
    //         // if (request.url.startsWith('https://www.youtube.com/')) {
    //         //   return NavigationDecision.prevent;
    //         // }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(url));
  }



  @override
  Widget build(BuildContext context) {
      return Scaffold(

        appBar:       AppBar(
          backgroundColor: Color(0xfff1efef),
    elevation: 0,
    leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_new, color:Color(0xff106e3c)),
    onPressed: () => Navigator.pop(context),
    ),
    title: Text("",style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Color(0xff106e3c)),),
    centerTitle: false,
    ),


        // body:  WebView(
        //   initialUrl: url,
        // )


      );




  }
}
