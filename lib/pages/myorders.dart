import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../dataproviders/OrderProviders.dart';
import '../models/order_list_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import 'myorderdetails.dart';



class MyordersPage extends StatefulWidget {
  final String title;

  const MyordersPage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Myorders();
}

class _Myorders extends State<MyordersPage> {
   _Myorders() ;


   String nodatafound="", myorders="",orderid="",totalprice="",totalitems="",orderdate="",cancel="",cancelled="",status="",language="";

   late OrderProvider orderProvider;

   List<OrderListOrders> orders=[];


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    orderProvider=Provider.of<OrderProvider>(context, listen: false);
    getOrderList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,

      appBar:  AppBar(
        backgroundColor: Color(0xfff1efef),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color:Color(0xff106e3c)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(myorders,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Color(0xff106e3c)),),
        centerTitle: false,
      ),

      body: Stack(

        children: [





          (orders.length>0) ? Align(

              alignment: FractionalOffset.topCenter,

              child: Padding(

                padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context) ?EdgeInsets.fromLTRB(8,10,8,8):EdgeInsets.fromLTRB(15,15,15,15):EdgeInsets.fromLTRB(20,30,20,20),
                child:  ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context,int i){

                      // double d=0;
                      // double total=0;
                      // // if(double.parse(lcart[i].offerPercent)>0)
                      // //   {
                      // d=double.parse(lcart[i].salespriWithGst);
                      //
                      // //   }
                      // // else{
                      // //   d=double.parse(lcart[i].mrp);
                      // //
                      // // }
                      // int q=int.parse(lcart[i].quantity);
                      // total=d*q;
                      // total=total.roundToDouble();

                      DateTime parsedDate = HttpDate.parse(orders[i].createdAt.toString());

                      // orders[i].status="DELIVERED";
                      return GestureDetector(
                        onTap: (){

                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => Myorderdetails(orders[i])));


                        },

                        child:  Padding(padding: EdgeInsets.only(top:8),

                          child:  Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 0),
                                borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                              ),
                              child: GestureDetector(

                                onTap: (){

                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (_) => Myorderdetails(orders[i])));


                                },

                                child:  Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      GestureDetector(

                                        onTap: (){

                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (_) => Myorderdetails(orders[i])));


                                        },

                                        child:  Row(
                                          children: [
                                            // Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context) ? EdgeInsets.all(10):EdgeInsets.all(16):EdgeInsets.all(22),
                                            //
                                            //
                                            //
                                            //   child:
                                            //
                                            //
                                            //
                                            //   ClipOval(child:Image.network("https://www.whiskaffair.com/wp-content/uploads/2022/03/Bihari-Chicken-Curry-2-3.jpg",
                                            //     width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:90:160,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:90:160,fit: BoxFit.fill,
                                            //     errorBuilder:
                                            //         (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            //       return Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 45:80:120 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 45:80:120,fit: BoxFit.fill
                                            //       );
                                            //     },
                                            //   ))
                                            //
                                            //
                                            //   ,),


                                            Expanded(child:    Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 10,top: 5):EdgeInsets.only(left: 16,top:10):EdgeInsets.only(left: 22,top:13),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [

                                                    SizedBox(


                                                      child:  Text(orderid+" : "+orders[i].id.toString()+"",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 2,),

                                                    ),

                                                    SizedBox(


                                                      child:  Text(totalprice+" : "+orders[i].totalPrice +" Qr",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:12:14,color: Colors.black),maxLines: 2,),

                                                    ),

                                                    SizedBox(


                                                      child:  Text(totalitems+" : "+orders[i].totalQuantity.toString() +" ",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:12:14,color: Colors.black),maxLines: 2,),

                                                    ),

                                                    SizedBox(


                                                      child:  Text(orderdate+" : "+parsedDate.day.toString()+"-"+parsedDate.month.toString()+"-"+parsedDate.year.toString() +" ",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:12:14,color: Colors.black),maxLines: 2,),

                                                    ),

                                                    SizedBox(

                                                      height: 10,


                                                        // child:  Text((orders[i].status.compareTo("CANCELLED")!=0)?status+" : "+orders[i].status : orders[i].status,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:12:14,color:(orders[i].status.compareTo("cancelled")==0)?Colors.redAccent: Colors.black),maxLines: 2,),
                                                        //

                                                      
                                                     
                                                    ),



                                                  ],
                                                )
                                            ),flex: 4, ),

                                            Expanded(child:    Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 10):EdgeInsets.only(left: 16):EdgeInsets.only(left: 22),
                                                child: Icon(Icons.arrow_forward_ios,size: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:20:25,color: Colors.black26,)
                                            ),flex: 1, )



                                          ],
                                        ),),


                                      // (orders[i].status.compareTo("cancelled")!=0)?    Container(
                                      //
                                      //   child: TextButton(
                                      //
                                      //
                                      //     onPressed: ()async {
                                      //
                                      //
                                      //    String cancelResponse=await   orderProvider.cancelFullOrder(context, orders[i].id.toString());
                                      //
                                      //    if(cancelResponse.isNotEmpty)
                                      //    {
                                      //
                                      //
                                      //
                                      //
                                      //      Map body = json.decode(cancelResponse);
                                      //
                                      //      if(body!=null) {
                                      //
                                      //        if(body.containsKey("message")) {
                                      //
                                      //
                                      //          getOrderList();
                                      //
                                      //
                                      //
                                      //
                                      //            ScaffoldMessenger.of(context).showSnackBar(
                                      //                SnackBar(
                                      //                  content: Text(
                                      //                      body["message"]),
                                      //                ));
                                      //            print(body["message"]);
                                      //
                                      //        }
                                      //      }
                                      //
                                      //
                                      //
                                      //
                                      //    }
                                      //    else{
                                      //
                                      //
                                      //
                                      //
                                      //
                                      //    }
                                      //
                                      //
                                      //     },
                                      //     child: Text(cancel,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.redAccent),maxLines: 2,),
                                      //   ),
                                      //
                                      // ) : Container()



                                    ],
                                  ),
                                ) ,
                              )




                          ) ,


                        )


                      );




                    }
                ) ,
              )


          ) :

          Align(
            alignment: FractionalOffset.topCenter,

            child:

            Text("\n\n\n\n\n\n\n\n\n\n\n\n  "+nodatafound,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.green)),
          ),





        ],
      )








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

         myorders=lde['myorder_en'];
         orderid=lde['orderid_en'];
         totalprice=lde['TotalPrice_en'];
         totalitems=lde['Total_items_en'];
         orderdate=lde['OrderDate_en'];
         status=lde['status_en'];
         cancel=lde['cancel_en'];
         cancelled=lde['cancelled_en'];
         nodatafound=lde['nodatafound_en'];


       }
       else {

         language=currentlanguage;

         myorders=lde['myorder_ar'];
         orderid=lde['orderid_ar'];
         totalprice=lde['TotalPrice_ar'];
         totalitems=lde['Total_items_ar'];
         orderdate=lde['OrderDate_ar'];
         status=lde['status_ar'];
         cancel=lde['cancel_ar'];
         cancelled=lde['cancelled_ar'];
         nodatafound=lde['nodatafound_ar'];
       }
     });







   }

  getOrderList() async
  {
    String response= await   orderProvider.getFullOrderList(context);

    print(response);

    Map<String,dynamic>mp=json.decode(response);

    OrderListEntity orderListEntity=OrderListEntity.fromJson(mp);

    setState(() {
      orders.clear();
      orders.addAll(orderListEntity.orders);


    });







  }
}
