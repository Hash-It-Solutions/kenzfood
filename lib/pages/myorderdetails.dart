import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../dataproviders/AddressProvider.dart';
import '../dataproviders/OrderProviders.dart';
import '../models/address_entity.dart';
import '../models/order_details_entity.dart';
import '../models/order_list_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';


class Myorderdetails extends StatefulWidget {

  OrderListOrders orders;


   Myorderdetails(this.orders) ;

  @override
  _MyorderdetailsState createState() => _MyorderdetailsState(orders);
}

class _MyorderdetailsState extends State<Myorderdetails> with TickerProviderStateMixin {

  OrderListOrders orders;
  String myorders="",orderid="",totalpricelang="",totalitems="",orderdate="",cancel="",cancelled="",status="",language="",orderdetails="",addresslang="",itemsinorder="",quantity="";

  late OrderProvider orderProvider;
  late AddressDataProvider addressDataProvider;
  List<OrderDetailsOrderDetails> orderDetails=[];

  late AddressData addressData;

  _MyorderdetailsState(this.orders);
  late AnimationController controller;
  bool determinate = false;
  double   price=0;
  double  offerprice=0,totalprice=0;

  String address="";
  String deliveryaddress="Delivery Address";

  String mobile="",city="",postalcode="",mobilenumber="",telephonenumber="",addressline1="",addressline2="",orderstatus="";

  String ordered="Ordered",delivered="Delivered",outofdelivery="Out of Delivery",pending="Pending";
  double ordervalue=1,deliveredvalue=0,outofdliveryvalue=0,pendingvalue=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    orderProvider=Provider.of<OrderProvider>(context, listen: false);
    addressDataProvider=Provider.of<AddressDataProvider>(context, listen: false);
    getOrderDetails(orders.id.toString());

    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat();

    controller
      ..forward(from: controller.value)
      ..repeat();

  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    double width = screenSize.width;
    double height=screenSize.height;

    DateTime parsedDate = HttpDate.parse(orders.createdAt.toString());



    return Scaffold(

        resizeToAvoidBottomInset: true,

        appBar:  AppBar(
          backgroundColor: Color(0xffedeeee),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff05ac54)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(orderid+": "+orders.id.toString(),style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:16:20,color: Color(0xff05ac54)),),

          elevation: 0,

          actions: [

            (orders.status.toString().compareTo("ORDERED")==0 ||
                orders.status.toString().compareTo("PENDING")==0)?   Padding(padding: EdgeInsets.all(10),


            child: TextButton(onPressed: () async {


              String cancelResponse=await   orderProvider.cancelFullOrder(context, orders.id.toString());

              if(cancelResponse.isNotEmpty)
              {




                Map body = json.decode(cancelResponse);

                if(body!=null) {

                  if(body.containsKey("message")) {


                    setState(() {

                      orders.status="CANCELLED";

                    });

                    // getOrderDetails(orders.id.toString());



                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              body["message"]),
                        ));
                    print(body["message"]);

                  }
                }




              }
              else{





              }


            },

              child: Text(cancel,style: TextStyle(color: Colors.red,fontSize:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:16 ),),



            ),

            ):Container()

          ],


        ),
        body: Container(
            color: Color(0xffedeeee),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Expanded(child:   Padding(

                padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.fromLTRB(5,10,5,5) : EdgeInsets.fromLTRB(15,15,15,10):EdgeInsets.fromLTRB(20,20,20,15),

                child:
                ListView.builder(
                    itemCount: orderDetails.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context,int i){

                      bool ispricesame=false;
                      String imgurl="";

                      if(orderDetails[i].productStock!=null)
                      {
                        price=double.parse(orderDetails[i].productStock.productPrice);
                        offerprice=double.parse(orderDetails[i].productStock.productOfferPrice);

                        int q= int.parse(orderDetails[i].itemQuantity);

                        if(price!=0&&offerprice!=0) {
                          if (price == offerprice) {
                            ispricesame=true;

                            totalprice=price*q;

                          }
                          else{

                            totalprice=offerprice*q;

                            ispricesame=false;
                          }
                        }


                      }

                      if(orderDetails[i].productImages.length>0)
                      {
                        imgurl=orderDetails[i].productImages[0].productImageUrl;

                      }




                      return   Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 0),
                            borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                          ),
                          child:    Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child:  Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context) ? EdgeInsets.all(10):EdgeInsets.all(16):EdgeInsets.all(22),



                                        child:



                                        (orderDetails[i].productImages.length>0)? ClipOval(child:Image.network(imgurl,
                                          width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:90:160,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:90:160,fit: BoxFit.fill,
                                          errorBuilder:
                                              (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 45:80:120 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 45:80:120,fit: BoxFit.fill
                                            );
                                          },
                                        ))   :      Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 45:80:120 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 45:80:120,fit: BoxFit.fill
                                        )                            ),flex: 1,


                                    ),

                                    Expanded(child: Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.fromLTRB(0, 10, 0, 0):EdgeInsets.fromLTRB(0, 16, 0, 0):EdgeInsets.fromLTRB(0, 22, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            SizedBox(
                                              width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 120:130:140,
                                              child:  Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(2):EdgeInsets.all(5):EdgeInsets.all(10),
                                                child: Text( (language.compareTo("en")==0)? orderDetails[i].productNameEn : orderDetails[i].productNameAr,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?11:12:14,color: Colors.black),),
                                              ),
                                            ),



                                            (ispricesame)?   Padding(padding:
                                            ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(3) :
                                            EdgeInsets.all(5):
                                            EdgeInsets.all(8),

                                              child: Text(
                                                price.toString()+" Qr",
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(

                                                    fontFamily: 'poppins',
                                                    fontWeight: FontWeight.normal,
                                                    fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?12:13:18 ,

                                                    color:  Colors.black),
                                              ),


                                            ) : Padding(padding:
                                            ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(3) :
                                            EdgeInsets.all(5):
                                            EdgeInsets.all(8),

                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,

                                                  children: [

                                                    Text(
                                                      price.toString()+" Qr",
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          decoration: TextDecoration.lineThrough,

                                                          fontFamily: 'poppins',
                                                          fontWeight: FontWeight.normal,
                                                          fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?12:13:18 ,


                                                          color:  Colors.black),
                                                    ),

                                                    Text(
                                                      "  "+offerprice.toString()+" Qr",
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(

                                                          fontFamily: 'poppins',
                                                          fontWeight: FontWeight.normal,
                                                          fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?12:13:18 ,

                                                          color:  Colors.black),
                                                    ),

                                                  ],


                                                )






                                            )


                                            ,
                                            Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(2):EdgeInsets.all(5):EdgeInsets.all(10),
                                                child: Text(quantity+" : "+orderDetails[i].itemQuantity.toString(),style: ResponsiveInfo.isMobile(context)?TextStyle(fontSize: 13,color: Colors.black)     :TextStyle(fontSize: 22,color: Colors.black),
                                                )
                                            ),

                                          ],
                                        )
                                    ),flex: 2,)


                                  ],
                                ),

                              ],
                            ),
                          )
                      );
                    }
                ) ,),flex: 1, ),

              Expanded(child: Padding(

                  padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.fromLTRB(5,5,5,5) : EdgeInsets.fromLTRB(10,10,10,10):EdgeInsets.fromLTRB(15,10,15,15),

                  child:

                  Column(

                    children: [




                   Container(

                            width: double.infinity,


                            child:Card(
                                elevation: 5,
                                // shape: RoundedRectangleBorder(
                                //   side: BorderSide(color: Colors.white70, width: 0),
                                //   borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                                // ),
                                child:


                                Column(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [


Padding(padding: EdgeInsets.all(10),

child:Text(deliveryaddress,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?16:19,color:Color(0xff05ac54)  )) ,

),





                                    Container(

                                        child:

                                        GestureDetector(

                                          onTap: (){




                                          },

                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [


                                                  Padding(

                                                    padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.fromLTRB(14,10,14,5) : EdgeInsets.fromLTRB(23,10,23,10):EdgeInsets.fromLTRB(32,10,32,15),




                                                    child:  Text(address,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.black),maxLines: 15,),


                                                  ),



                                                ],
                                              )
                                                ,flex: 2, ),






                                            ],
                                          ),)





                                    ) ,

                                  ],
                                )








                            )  ,
                          ),


                      Container(

                        width: double.infinity,
                        height: ResponsiveInfo.isMobile(context)?110:140,


                        child:Card(
                            elevation: 5,
                            // shape: RoundedRectangleBorder(
                            //   side: BorderSide(color: Colors.white70, width: 0),
                            //   borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                            // ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Padding(padding: EdgeInsets.all(5),

                                  child: Text(
                                    orderstatus,
                                    style: TextStyle(fontSize: 15),
                                  ),

                                )
                                 ,
                                const SizedBox(height: 11),


                              Padding(padding: EdgeInsets.only(left: 5,right: 5),

                                child: (orders.status.toString().compareTo("CANCELLED")!=0)? Row(

                                  children: [

                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        LinearProgressIndicator(
                                          value: ordervalue,
                                          semanticsLabel: 'Linear progress indicator',
                                          color: Colors.black38,
                                        ),

                                        Padding(padding: EdgeInsets.all(5),

                                            child:  Text(ordered,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?9:12:15,color: Color(
                                                0xff939292)),))

                                      ],
                                    ),flex: 1,),
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        LinearProgressIndicator(
                                          value: pendingvalue,
                                          semanticsLabel: 'Linear progress indicator',
                                          color: Colors.black38,
                                        ),

                                        Padding(padding: EdgeInsets.all(5),

                                            child:   Text(pending,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?9:12:15,color: Color(
                                                0xff939292)),))

                                      ],
                                    ),flex: 1,),
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        LinearProgressIndicator(
                                          value: outofdliveryvalue,
                                          semanticsLabel: 'Linear progress indicator',
                                          color: Colors.black38,
                                        ),

                                        Padding(padding: EdgeInsets.all(5),

                                            child:   Text(outofdelivery,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?9:12:15,color: Color(
                                                0xff939292)),))

                                      ],
                                    ),flex: 1,),
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        LinearProgressIndicator(
                                          value: deliveredvalue,
                                          semanticsLabel: 'Linear progress indicator',
                                          color: Colors.black38,
                                        ),

                                        Padding(padding: EdgeInsets.all(5),

                                            child:   Text(delivered,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?9:12:15,color: Color(
                                                0xff939292)),))

                                      ],
                                    ),flex: 1,)





                                  ],
                                ) : Container(

                                  child:Text(
                                    cancelled,
                                    style: TextStyle(fontSize: 15,color: Colors.red),

                                  ) ,

                                ),

                                )











                          // Padding(padding: EdgeInsets.all(5),
                          //
                          //   child:
                          //   Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //
                          //         children: [
                          //         Text(" Placed",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?9:12:15,color: Color(
                          //             0xff939292)),),
                          //
                          //
                          //           Text(" Delivered",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?9:12:15,color: Color(0xff939292)),),
                          //
                          //       ],))




                              ],
                            ),












                        )  ,
                      )







                    ],


                  )





              ),flex: 1,)







              ,










              // Padding(
              //
              //   padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.fromLTRB(5,5,5,5) : EdgeInsets.fromLTRB(10,10,10,10):EdgeInsets.fromLTRB(15,15,15,15),
              //
              //   child: Text(itemsinorder,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?12:14 ),textAlign: TextAlign.left,),
              // ),







            ],
          )
        )






        );


  }


  getOrderDetails(String id) async
  {

    String response=await   orderProvider.getFullOrderDetails(context, orders.id.toString());

    print(response);

    Map<String,dynamic>mp=json.decode(response);

    OrderDetailsEntity detailsEntity=OrderDetailsEntity.fromJson(mp);

    getAddressList(detailsEntity.orderDetails[0].addressId.toString());





    setState(() {

      if(orders.status.toString().compareTo("ORDERED")==0)
      {

        ordervalue=1;
        ordervalue=0;
        outofdliveryvalue=0;
        deliveredvalue=0;
      }

   else   if(orders.status.toString().compareTo("PENDING")==0)
      {

pendingvalue=1;
ordervalue=1;
outofdliveryvalue=0;
deliveredvalue=0;
      }
      else   if(orders.status.toString().compareTo("OUT_FOR_DELIVERY")==0)
      {

        pendingvalue=1;
        ordervalue=1;
        outofdliveryvalue=1;
        deliveredvalue=0;
      }

      else   if(orders.status.toString().compareTo("DELIVERED")==0)
      {

        pendingvalue=1;
        ordervalue=1;
        outofdliveryvalue=1;
        deliveredvalue=1;
      }


orderDetails.clear();
orderDetails.addAll(detailsEntity.orderDetails);
    });

  }


  getAddressList(String id) async
  {


    AddressEntity addressEntity=await addressDataProvider.getAddress(context);


    if(addressEntity.data.length>0)
      {

        // addressData=addressEntity.data

        for(int i=0;i<addressEntity.data.length;i++)
          {

            if(addressEntity.data[i].id.toString().compareTo(id)==0) {
              addressData = addressEntity.data[i];

              setState(() {

                address=addressData.addressLine1+"\n"+addressData.addressLine2+"\n"+
                       mobile+" : "+ addressData.mobile.toString()+"\n"+
                       city+" : "+addressData.city.toString()+"\n"+
                postalcode+" : "+addressData.postalCode.toString();



              });

              break;



            }



          }

      }

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

        totalpricelang=lde['Total_amount_en'];
        totalitems=lde['Total_items_en'];
        orderdate=lde['OrderDate_en'];

        orderdetails=lde['Order_detail_en'];
        orderid=lde['orderid_en'];
        addresslang=lde['Address_en'];
        itemsinorder=lde['itemsinorder_en'];
        quantity=lde['qty_en'];
        deliveryaddress=lde['deliveryaddr_en'];

        mobile=lde['mobile_en'];

        city=lde['city_en'];

        postalcode=lde['postalcode_en'];

        orderstatus=lde['orderstatus_en'] ;

        ordered=lde['ordered_en'];
        delivered=lde['delivered_en'];
        outofdelivery=lde['outofdelivery_en'];

      pending=lde['pending_en'];
        cancel=lde['cancel_en'];
        cancelled=lde['cancelled_en'];



      }
      else {

        language=currentlanguage;

        myorders=lde['myorder_ar'];

        totalpricelang=lde['Total_amount_ar'];
        totalitems=lde['Total_items_ar'];
        orderdate=lde['OrderDate_ar'];

        orderdetails=lde['Order_detail_ar'];
        orderid=lde['orderid_ar'];
        addresslang=lde['Address_ar'];
        itemsinorder=lde['itemsinorder_ar'];
        quantity=lde['qty_ar'];

        deliveryaddress=lde['deliveryaddr_ar'];


        mobile=lde['mobile_ar'];

        city=lde['city_ar'];

        postalcode=lde['postalcode_ar'];
        orderstatus=lde['orderstatus_ar'] ;

        ordered=lde['ordered_ar'];
        delivered=lde['delivered_ar'];
        outofdelivery=lde['outofdelivery_ar'];

        pending=lde['pending_ar'];
        cancel=lde['cancel_ar'];
        cancelled=lde['cancelled_ar'];
      }
    });







  }

}
