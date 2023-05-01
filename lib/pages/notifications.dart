import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kenz_market_new/models/product_details_entity.dart';

import 'package:provider/provider.dart';

import '../config/constant.dart';
import '../dataproviders/NotificationProvider.dart';
import '../models/notification_list_entity.dart';
import '../models/productlist_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../utils/ServerConstants.dart';
import 'package:http/http.dart' as http;

import 'my_product_details_page.dart';
class Notifications extends StatefulWidget {
  const Notifications() : super();

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  late NotificationDataProvider notificationDataProvider;
  List<NotificationListData> data=[];
  String language="",nnotifications="",nodatafound="";

  @override
  void initState() {

    super.initState();

    notificationDataProvider=Provider.of<NotificationDataProvider>(context, listen: false);

    getNotifications();
checkLanguage();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff05ac54),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>  Navigator.pop(context, {"added": 1}) ,
        ),
        title: Text(
          nnotifications,
          style: TextStyle(
              fontSize: ResponsiveInfo.isMobile(context)
                  ? ResponsiveInfo.isSmallMobile(context)
                  ? 12
                  : 16
                  : 20,
              color: Colors.white),
        ),
        centerTitle: false,
      ),

      body: Container(

        width: double.infinity,
        height: double.infinity,

        child: Stack(

          children: [

            (data.length>0)?  ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(

                    child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?8:12:15),

                      child:Card(
                          elevation: 4,

                          child: Container(
                            width: double.infinity,
                            height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?80 :90:120,

                            child: ListTile(
                                leading: Image.network(data[index].imageUrl,width: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?60:80:100, height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?60:80:100,errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                      "images/pi.png", width: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?60:80:100, height:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 60:80:100, fit: BoxFit.fill
                                  );
                                }
                                ),
                                title:  Text(
                                  data[index].title,
                                  style: TextStyle(color: Colors.black, fontSize: 15),
                                ),
                                subtitle: Text(data[index].message)),

                          )




                      ) ,
                    ),

                    onTap: (){

getProductDetails(data[index].productid);


                    },
                  )




                    ;
                }) :  Align(
              alignment: FractionalOffset.topCenter,

              child:

              Text("\n\n\n\n\n\n\n\n\n\n\n\n\n\n  "+nodatafound,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.green)),
            ),


          ],


        ),


      ),

    );
  }
  checkLanguage()async
  {

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();



    setState(() {
      language=currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {

        language=currentlanguage;

        nnotifications=lde['notification_en'];
        nodatafound=lde['nodatafound_en'];



      }
      else {

        language=currentlanguage;


        nnotifications=lde['notification_ar'];
        nodatafound=lde['nodatafound_ar'];
      }
    });







  }

  getNotifications() async{

    String d=await notificationDataProvider.getPostData(context);
    print(d);

    final item = json.decode(d);

    NotificationListEntity entity=NotificationListEntity.fromJson(item);

    if(entity.data.length>0)
      {

        setState(() {
      data.clear();
      data.addAll(entity.data);
        });

      }


  }


  getProductDetails(String id)
  async {
    late  String result="";
    try {
      String apiToken = await getStringValue("token");

      String url = ServerConstants.baseurl + ServerConstants.get_product+"?product_id="+id;

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

        ProductlistEntity entity=ProductlistEntity.fromJson(item);

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
              backgroundColor: Colors.transparent,

              content:MyProductDetailsPage(entity.products[0].id,1,entity.products[0])

          ),
        );





      }
    }catch(e)
    {

    }

  }
}
