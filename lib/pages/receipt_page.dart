import 'package:flutter/material.dart';


import '../utils/ResponsiveInfo.dart';
import 'myorders.dart';

class ReceiptPage extends StatefulWidget {

  String responsecode;


   ReceiptPage(this.responsecode) ;

  @override
  _ReceiptPageState createState() => _ReceiptPageState(responsecode);


}

class _ReceiptPageState extends State<ReceiptPage> {

  String responsecode;

  _ReceiptPageState(this.responsecode);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTime();
  }




  @override
  Widget build(BuildContext context) {


    return
      WillPopScope(
        onWillPop: _onBackPressed,

    child:  Scaffold(

      resizeToAvoidBottomInset : false,

      body: Container(

        width: double.infinity,
        height: double.infinity,

        child:    Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,


          children: [


            Text((responsecode.compareTo("1")==0)?"Success" : "Failed",textAlign: TextAlign.center,style: TextStyle(
                color: (responsecode.compareTo("1")==0)?Colors.green :Colors.red,
                fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 20:23:26:31),)

            ,

            Text((responsecode.compareTo("1")==0)?"We received your purchase request we will be in touch shortly!" : "Something Wrong .. ",textAlign: TextAlign.center,style: TextStyle(color:(responsecode.compareTo("1")==0)? Colors.green : Colors.red,fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:16:19:22),)


          ],

        ),

      )




    )
      );
  }

  Future<bool> _onBackPressed() async {



    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

    // Navigator.pushReplacement(context, MaterialPageRoute(
    //     builder: (context) => MyHomePage(title: "Home page",)
    // )
    // );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                MyordersPage(title: 'Orders',)),
            );

    return true ;
  }


  startTime() async {

    await Future.delayed(Duration(seconds: 3));

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) =>
              MyordersPage(title: 'Orders',)),
    );





  }
}
