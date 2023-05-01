import 'dart:convert';

import 'package:flutter/material.dart';

import '../config/constant.dart';
import '../models/vouchers_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../utils/ServerConstants.dart';
import 'package:http/http.dart' as http;

class VoucherList extends StatefulWidget {
   VoucherList() ;

  @override
  _VoucherListState createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {

  List<VouchersCoupons> coupons=[];

  String voucherstitle="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVouchersData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,

      appBar:  AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xff01713D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(voucherstitle,style: TextStyle(color: Color(0xff01713D),fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 16:18:21:25),),
        centerTitle: false,



      ),

      body: Stack(


        children: [


          Align(

            alignment: FractionalOffset.topCenter,

            child:ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(padding: EdgeInsets.all(6),




                    child: Stack(

                      children: [

                        Align(
                            alignment: FractionalOffset.center,

                            child:       Container(

                              width: double.infinity,
                              height: (MediaQuery.of(context).size.width)/2.9,

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/vg.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),

                            )

                        ),


                        Align(

                          alignment: FractionalOffset.center,

                          child:       Container(

                            width: double.infinity,
                            height: (MediaQuery.of(context).size.width)/3,


                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [


                                Expanded(child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                child: Image.asset("images/ticket.png"),

                                ),flex: 1,),


                                Expanded(child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Column(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [

                                      Padding(padding: EdgeInsets.all(7),

                                        child: Text(coupons[index].couponName,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:15:17,color: Color(
                                            0xff000000)),),

                                      ),

                                      Padding(padding: EdgeInsets.all(7),

                                        child: Text("Coupon Code : "+coupons[index].couponCode,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 8:10:12:14,color: Color(
                                            0xff212121)),),

                                      ),
                                      (!coupons[index].activeStatus)?  Padding(padding: EdgeInsets.all(7),

                                        child: Text("Not Available",style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 8:10:12:14,color: Color(
                                            0xffb91f1f)),),

                                      ) : Container()
                                    ],



                                  ),


                                ),flex: 2,)





                              ],


                            ),
                          ),


                        )



                      ],
                    )






                    ,



                  )





                   ;
                }),



          )





        ],


      ),




    );
  }



  getVouchersData()
  async {
    late  String result="";
    try {
      String apiToken = await getStringValue("token");

      String url = ServerConstants.baseurl + ServerConstants.getCoupons;

      final response = await http.get(
        Uri.parse(url),

        headers: {
          'Content-Type': 'application/json',

          ServerConstants.tokenKey: apiToken
        },


      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = response.body;

        VouchersEntity entity=VouchersEntity.fromJson(item);


        setState(() {

          coupons.clear();
          coupons.addAll(entity.coupons);

        });




      }
    }catch(e)
    {

    }

  }


  Future<void> checkLanguage() async {

    String currentlanguage=await LanguageDatas.checkLanguage();

    setState(() {

      if (currentlanguage.compareTo("en") == 0) {

        voucherstitle="Vouchers";
      }
      else{

        voucherstitle="قسائم";

      }


    });












  }
}
