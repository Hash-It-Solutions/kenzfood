import 'package:flutter/material.dart';

import '../utils/ResponsiveInfo.dart';

class Selectcountry extends StatefulWidget {
  const Selectcountry() : super();

  @override
  _SelectcountryState createState() => _SelectcountryState();
}

class _SelectcountryState extends State<Selectcountry> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,

      appBar:  AppBar(
        backgroundColor: Color(0xfff5f4f4),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff05ac54)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Select Country",style: TextStyle(color:Colors.black, fontWeight:FontWeight.bold,fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25),),
        centerTitle: false,
      ),

      body: Stack(


        children: [

          Align(

            alignment: FractionalOffset.topCenter,

            child: Padding(

              padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5):EdgeInsets.all(10):EdgeInsets.all(15),
              child:  ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context,int i){






                    return Column(

                      children: [

                    Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5): EdgeInsets.all(8): EdgeInsets.all(15),
                    child:


                    Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                    ClipOval(child:Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/255px-Flag_of_the_United_Arab_Emirates.svg.png",
                    width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 30:40:55,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 30:40:55,fit: BoxFit.fill,
                    errorBuilder:
                    (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 30:40:55 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 30:40:55,fit: BoxFit.fill
                    );
                    },
                    )),

                    Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?5:7:9:11 ,left:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:13:16:19),

                      child:  Text("UAE",style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 12:13:14:17,color: Colors.black),),

                    )




                    ],


                    )),

                        Container(width: double.infinity,height: 1,color: Colors.black12,)


                      ],

                    );



                  }
              ),
            ),
          )

        ],

      ),


    );
  }
}
