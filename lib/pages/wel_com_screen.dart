import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kenz_market_new/databasehelper/DatabaseHelper.dart';
import 'package:kenz_market_new/databasehelper/DatabaseTables.dart';
import 'package:page_transition/page_transition.dart';

import '../models/category_list_entity.dart';
import '../utils/ResponsiveInfo.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/ServerConstants.dart';
import 'homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:custom_progress_dialog/custom_progress_dialog.dart';

class WelComScreen extends StatefulWidget {
   WelComScreen() : super();

  @override
  _WelComScreenState createState() => _WelComScreenState();
}

class _WelComScreenState extends State<WelComScreen> {

  ProgressDialog _progressDialog = ProgressDialog();

  List<String>arraybanners=["images/kenzcreativeone.png",
  "images/kenztwo.png",
    "images/kenzthree.png"

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    double  height= (MediaQuery.of(context).size.height);
    double  width= (MediaQuery.of(context).size.width);
    return Scaffold(


      body: Container(

        width: double.infinity,
        height: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Expanded(child:


              Padding(

                padding: EdgeInsets.only(top: 60),

                child:  Container(
                    height: (MediaQuery.of(context).size.width) / 1.89349112,
                    width: double.infinity,
                    child: PageIndicatorContainer(
                        length: arraybanners.length,
                        align: IndicatorAlign.bottom,
                        indicatorSpace: 14.0,
                        padding: const EdgeInsets.all(10),
                        indicatorColor: Colors.black12,
                        indicatorSelectorColor: Colors.blueGrey,
                        shape: IndicatorShape.circle(size: 10),
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          // controller: controller,
                          itemBuilder: (BuildContext context, int index) {
                            return
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Container(
                              height: (MediaQuery.of(context).size.width) / 1.69349112,
                            width: double.infinity,
                            child: Card(
                            child:
                            Image.asset(arraybanners[index],width: width,height: (MediaQuery.of(context).size.width) / 1.89349112,fit: BoxFit.fill,)),
                            ),

                                ],

                              );


                          },
                          itemCount: arraybanners.length,
                          // children: nsdwidget,
                        ))),

              ),















            flex: 3,

            ),


            Expanded(child: Column(
              children: [

                Padding(

                  padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?EdgeInsets.all(3) :
                  EdgeInsets.all(5):
                  EdgeInsets.all(8),
                  child:   Container(

                      width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 120:150:180,
                      height:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 50:65:80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)

                        ),

                        color: Color(0xff05ac54),
                        border: Border.all(
                          color: Color(0xff05ac54),

                        ),



                      ),
                      child:   Padding(

                        padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?EdgeInsets.all(3) :
                        EdgeInsets.all(5):
                        EdgeInsets.all(8),
                        child:


                        TextButton(onPressed: () async {



                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString("initial", "viewed");

                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              child:  Homescreen(0),
                              type: PageTransitionType.leftToRightWithFade,
                            ),
                          );


                         // getBanners();




                        },
                          child: Text("Start",style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)? 13:16),),





                        ),)




                  )                 )
              ],

            ),

              flex: 1,

            )





          ],


        ),

      ),

    );
  }


  getBanners()
  async {

    try {

      _progressDialog.showProgressDialog(
          context, textToBeDisplayed: "Please wait for a moment......");



      String url=ServerConstants.baseurl+ServerConstants.getSmallBanners;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        // final item = json.decode(response.body);

        String resp=response.body;
        Map<String, dynamic> data_To_Table = new Map();
        data_To_Table['data'] = resp;

        new DatabaseHelper().insert(data_To_Table, DatabaseTables.SmallBanner);



        // result = BannerEntity.fromJson(item);
      }

      String url1=ServerConstants.baseurl+ServerConstants.get_banners;
      final response1 = await http.get(
        Uri.parse(url1),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response1.statusCode == 200) {
        // final item = json.decode(response.body);

        String resp=response1.body;
        Map<String, dynamic> data_To_Table = new Map();
        data_To_Table['data'] = resp;

        new DatabaseHelper().insert(data_To_Table, DatabaseTables.Bigbanner);

        getCategories();



        // result = BannerEntity.fromJson(item);
      }

    } catch (e) {
      log(e.toString());
    }
  }



  getCategories()async
  {
    try{

      final response = await http.get(
        Uri.parse(ServerConstants.baseurl+ServerConstants.getCategory),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {

        String resp=response.body;

        final item = json.decode(response.body);
        CategoryListEntity categoryListEntity = CategoryListEntity.fromJson(item);


        for (int i = 0; i < categoryListEntity.categories.length; i++) {

        String  url=ServerConstants.baseurl+ServerConstants.get_product+"?category_id="+categoryListEntity.categories[i].id.toString();

        final response = await http.get(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",

          },
        );
        if (response.statusCode == 200) {

          String a=response.body;

          Map<String, dynamic> data_To_Table = new Map();
          data_To_Table['data'] = a;
          data_To_Table['categoryid'] = categoryListEntity.categories[i].id.toString();

          new DatabaseHelper().insert(data_To_Table, DatabaseTables.products);

          // final item = json.decode(response.body);
          // result = ProductlistEntity.fromJson(item);
        }


        }


        Map<String, dynamic> data_To_Table = new Map();
        data_To_Table['data'] = resp;


        new DatabaseHelper().insert(data_To_Table, DatabaseTables.categories);
        // final item = json.decode(response.body);
        // result = CategoryListEntity.fromJson(item);






        getLikeProducts();
      }


    }catch(e)
    {


    }


  }

  getLikeProducts()
  async {
   String url=ServerConstants.baseurl+ServerConstants.get_product;

    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",

      },
    );
    if (response.statusCode == 200) {

      String a=response.body;



      Map<String, dynamic> data_To_Table = new Map();
      data_To_Table['data'] = a;

      new DatabaseHelper().insert(data_To_Table, DatabaseTables.allproducts);

      if(!_progressDialog.isDismissed) {
        _progressDialog.dismissProgressDialog(context);
      }



      // final item = json.decode(response.body);

    }

  }



}
