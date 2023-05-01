import 'package:flutter/material.dart';

import '../../utils/ResponsiveInfo.dart';

class Storepickup extends StatefulWidget {
  const Storepickup() : super();

  @override
  _StorepickupState createState() => _StorepickupState();
}

class _StorepickupState extends State<Storepickup> {
  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        Padding(

          padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5):EdgeInsets.all(10):EdgeInsets.all(15),
          child:  ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context,int i){






                return Column(

                  children: [

                    Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5): EdgeInsets.all(8): EdgeInsets.all(15),
                        child:


                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [



                            Padding(padding: EdgeInsets.all(10),

                              child:  Text("Lulu mall almasco",style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 15:17:19:21,color: Colors.black),),

                            ),

                            Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?5:7:9:11 ,left:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:13:16:19),

                              child:  Icon(Icons.arrow_forward_ios,size:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:20:23:28,color: Colors.green ,)
                            )




                          ],


                        )),

                    Container(width: double.infinity,height: 1,color: Colors.black12,)


                  ],

                );



              }
          ),
        )


      ],

    );
  }
}
