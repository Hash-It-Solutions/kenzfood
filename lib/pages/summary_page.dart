

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenz_market_new/pages/receipt_page.dart';
import 'package:kenz_market_new/pages/user_address.dart';

import 'package:provider/provider.dart';

import '../config/constant.dart';
import '../dataproviders/AddressProvider.dart';
import '../dataproviders/OrderProviders.dart';
import '../models/address_entity.dart';
import '../models/delivery_charge_data_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';

import '../utils/ServerConstants.dart';
import 'package:http/http.dart' as http;

import '../utils/Staticvalues.dart';
import 'loginpage.dart';
import 'myorders.dart';
class SummaryPage extends StatefulWidget {

   String productid="0";
   double totalprice=0;
   int count=0;


   SummaryPage(this.productid,this.totalprice,this.count) ;

  @override
  _SummaryPageState createState() => _SummaryPageState(productid,totalprice,count);
}

class _SummaryPageState extends State<SummaryPage> {

  String productid="0";
  double totalprice=0,total=0;
  int count=0;


  late AddressDataProvider addressDataProvider;

  _SummaryPageState(this.productid, this.totalprice,this.count);

  List<AddressData> data=[];

  String selectedAddressid="0";

  int addressselectedindex=0;

  late OrderProvider orderProvider;
  String response ="";
  Map body=new Map();
  String  selectpaymentmethod="", items="", selectaddress="", returndata="",language="",totalitems="",placeorder="",totalpricelang="",deliverycharge="",amounttopay="",address="",change="",continuetopayment="";

  // List<PaymentMethods>? paymentMethods=[];
  // String doordelivery="Door Delivery",pickup="Pick Up";

  int code=1;

  String currentdate="",current_time="";
  List<PaymentMethods>? paymentMethods=[];

  int paymentmethode=-1;

  double delcharge=0,couponcodeamount=0;

  String failure="",failuremsg="", congratulations="",yourordermsg="",trackyourorder="", kenzfood="",apply="",couponcode="", checkout="", deliveryaddress="",edit="",select="",deliverymethode="",doord_elivery="",pick_up="",applycoupon="",couponcodeapplied="",paynow="",cashondelivery="";


  TextEditingController couponcdecontroller=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    MFSDK.init(Staticvalues.liveepaymenttoken2, MFCountry.QATAR, MFEnvironment.LIVE);
    MFSDK.setUpAppBar(isShowAppBar: false);
    total=totalprice;

    addressDataProvider = Provider.of<AddressDataProvider>(context, listen: false);
    // addressDataProvider = Provider.of<AddressDataProvider>(context);



    addressDataProvider.getAddressList(context);

    orderProvider=Provider.of<OrderProvider>(context, listen: false);
    setCurrentDateTime();
    getFirstAddress();
    initiatePayment();



  }


  setCurrentDateTime()
  {

    DateTime dtnow=DateTime.now();

    setState(() {
      currentdate=dtnow.day.toString()+"-"+dtnow.month.toString()+"-"+dtnow.year.toString();

      String dt =  DateFormat("hh:mm a").format(dtnow);
      current_time=dt;


    });


  //  showReciptDialog("1");

  }



  initiatePayment()
  async {
    String user_tye = await getStringValue("user_tye");

    if(user_tye.compareTo("wholesale")!=0) {
      var request = new MFInitiatePaymentRequest(
          totalprice, MFCurrencyISO.QATAR_QAR);

      MFSDK.initiatePayment(request, MFAPILanguage.EN,
              (MFResult<MFInitiatePaymentResponse> result) =>
          {

            if(result.isSuccess()) {
              showPaymentMethodes(result)
            }
            else
              {
                print(result.error?.message)
              }
          });
    }
  }





  @override
  Widget build(BuildContext context) {

    // addressDataProvider = Provider.of<AddressDataProvider>(context);
    //
    // AddressEntity ade= addressDataProvider.addressEntity;
    //
    //
    // if(ade!=null) {
    //   if (ade.data.length > 0) {
    //
    //     data.clear();
    //
    //
    //     data.addAll(ade.data);
    //
    //     selectedAddressid=data[0].id.toString();
    //
    //     getDeliveryCharges(data[0].postalCode);
    //
    //   }
    // }





    return Scaffold(

        resizeToAvoidBottomInset: false,

        appBar:  AppBar(
          backgroundColor: Color(0xffe9ecea),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.green),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(checkout,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Colors.green),),
          centerTitle: false,
        ),

      body:

          Stack(

            children: [

              Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xffeeecec),

              ),

              Column(
                children: [

                  Expanded(flex: 4, child:Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5) : EdgeInsets.all(8):EdgeInsets.all(12),

                      child: SingleChildScrollView(


                        child: Column(

                            children: [
                              Padding(padding: EdgeInsets.all(5),

                                  child: Container(

                                    width: double.infinity,
                                    height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?140:175:210,
                                    color: Colors.white,

                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [


                                        Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),

                                            child: Row(

                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [

                                                Text(deliveryaddress,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Color(0xff01713D
                                                ),fontWeight: FontWeight.bold),),


                                                TextButton(onPressed:() async {
                                                  Map results = await Navigator.of(context)
                                                      .push(new MaterialPageRoute<dynamic>(
                                                    builder: (BuildContext context) {
                                                      return new UserAddress(
                                                          "1"
                                                      );
                                                    },
                                                  ));
                                                  if (results != null &&
                                                      results.containsKey('added')) {
                                                    setState(() {
                                                      var acc_selected =
                                                      results['added'];

                                                      int acs =
                                                      acc_selected as int;

                                                      if(acs!=0) {
                                                        getAddress(acs);
                                                      }




                                                    });
                                                  }

                                                }, child:  Text( (data.length>0)? edit:select,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Color(0xff01713D),fontWeight: FontWeight.normal),),
                                                )


                                              ],
                                            )







                                        ),


                                        (data.length>0)?  Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 8) : EdgeInsets.only(left: 12): EdgeInsets.only(left: 17),


                                            child: Text(data[addressselectedindex].name+"\n"+data[addressselectedindex].addressLine1+"\n"+data[addressselectedindex].addressLine2+"\n"+data[addressselectedindex].mobile+"",maxLines:3,style: TextStyle(color: Colors.black54,fontFamily: 'Poppins',fontSize:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12: 14:16),),









                                        ) :    Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),

                                            child:

                                            Container(







                                              child:     Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),
                                                  child:Row(

                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,

                                                    children: [

                                                      Expanded(child: Text("No data Found",maxLines: 1,style: TextStyle(color: Colors.black45,fontSize:ResponsiveInfo.isMobile(context)? 13:15),),flex: 3,),



                                                    ],


                                                  )) ,

                                            )





                                        ),


                                      ],
                                    ),
                                  )










                              ),

                              Padding(padding: EdgeInsets.all(5),

                                  child: Container(

                                    width: double.infinity,

                                    color: Colors.white,

                                    child:  Column(

                                      children: [


                                        Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),

                                            child: Column(

                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [

                                                Padding(padding: EdgeInsets.all(5),

                                                  child:  Text(deliverymethode,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Color(0xff01713D),fontWeight: FontWeight.bold),),


                                                ),

                                                ListTile(
                                                  title:  Text(doord_elivery),
                                                  leading: Radio(
                                                    value: 1,
                                                    groupValue: code,
                                                    onChanged: ( value) {
                                                      setState(() {
                                                        code = value as int;
                                                      });
                                                    },
                                                  ),
                                                ),




                                                ListTile(
                                                  title:  Text(pick_up),
                                                  leading: Radio(
                                                    value: 2,
                                                    groupValue: code,
                                                    onChanged: ( value) {
                                                      setState(() {
                                                        code = value as int;
                                                      });
                                                    },
                                                  ),
                                                ),

                                                (code==1)?    Padding(padding: EdgeInsets.only(right: 5,left: 50),

                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [



                                                        GestureDetector(


                                                          child: Container(
                                                              decoration: BoxDecoration(


                                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                border: Border.all(
                                                                  color: Color(0xff01713D),
                                                                ),

                                                              ),

                                                              width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?85:100:115,

                                                              child: Padding(

                                                                padding: EdgeInsets.all(5),
                                                                child:   Row(
                                                                  children: [

                                                                    Icon(Icons.calendar_month,size: 15,color: Colors.green,),

                                                                    Text(" "+currentdate,style: TextStyle(fontSize: 12,color: Colors.green),textAlign: TextAlign.center,)



                                                                  ],


                                                                ),
                                                              )




                                                          ),

                                                          onTap: (){

                                                            displayDatePicker(context);
                                                          },
                                                        )



                                                        ,

                                                        GestureDetector(

                                                          child: Padding(padding: EdgeInsets.only(left: 10),


                                                            child: Container(
                                                                decoration: BoxDecoration(


                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                  border: Border.all(
                                                                    color: Color(0xff01713D),
                                                                  ),                                                    ),

                                                                width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?85:100:115,

                                                                child: Padding(

                                                                  padding: EdgeInsets.all(5),
                                                                  child:   Row(
                                                                    children: [

                                                                      Icon(Icons.access_time_rounded,size: 15,color: Colors.green,),

                                                                      Text(" "+current_time,style: TextStyle(fontSize: 12,color: Colors.green),textAlign: TextAlign.center,)



                                                                    ],


                                                                  ),
                                                                )




                                                            ),


                                                          ),

                                                          onTap: () async {
                                                            TimeOfDay? time = await getTime(
                                                              context: context,
                                                              title: "Select remind Time",
                                                            );
                                                            String period = time!.period == DayPeriod.am ? 'AM' : 'PM';
                                                            String min=time!.minute.toString();

                                                            if(time!.minute>=10)
                                                            {
                                                              min=time!.minute.toString();
                                                            }
                                                            else{

                                                              min="0"+time!.minute.toString();
                                                            }

                                                            int t=0;

                                                            if(time!.hour>12)
                                                            {

                                                              t=time!.hour-12;
                                                            }
                                                            else{

                                                              t=time!.hour;
                                                            }


                                                            setState(() {
                                                              current_time= t.toString()+":"+min+" "+period;
                                                            });

                                                          },
                                                        )









                                                      ],



                                                    )

                                                ):Container(),











                                              ],
                                            )







                                        ),





                                      ],
                                    ),
                                  )


                              ),


                              Padding(padding: EdgeInsets.all(5),

                                  child: Container(

                                      width: double.infinity,

                                      color: Colors.white,

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [


                                          Padding(padding: EdgeInsets.all(10),

                                            child:  Text(selectpaymentmethod,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Color(0xff01713D),fontWeight: FontWeight.bold),),


                                          ),
                                          Padding(padding: EdgeInsets.all(5),


                                            child:   MediaQuery.removePadding(context: context, child: ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              itemBuilder: (ctx, index) {
                                                return GestureDetector(
                                                  onTap: (){
                                                   // Navigator.pop(context);
                                                    setState(() {
                                                      paymentmethode = paymentMethods![index]!.paymentMethodId!.toInt();
                                                    });


                                                  },
                                                  child:    ListTile(
                                                      leading: Radio(
                                                        value: paymentMethods![index]!.paymentMethodId!.toInt(),
                                                        groupValue: paymentmethode,
                                                        onChanged: ( value) {
                                                          setState(() {
                                                            paymentmethode = value as int;
                                                          });
                                                        },
                                                      ),
                                                      title: Row(

                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.network(paymentMethods![index]!.imageUrl.toString(),width: 40,height: 40,fit: BoxFit.fill,),

                                                          Text( (language.compareTo("en")==0)?  paymentMethods![index]!.paymentMethodEn.toString() : paymentMethods![index]!.paymentMethodAr.toString(),style: TextStyle(fontSize: 13,fontFamily: 'Poppins'),),

                                                        ],
                                                      )



                                                  ),
                                                );
                                              },
                                              itemCount: paymentMethods!.length,
                                            ),
removeTop: true,
                                              removeRight: true,
removeLeft: true,
                                              removeBottom: true,




                                            )



                                            ,

                                          ),

                                          Padding(padding: EdgeInsets.all(5),


                                            child:     ListTile(
                                                leading: Radio(
                                                  value: 0,
                                                  groupValue: paymentmethode,
                                                  onChanged: ( value) {
                                                    setState(() {
                                                      paymentmethode = value as int;
                                                    });
                                                  },
                                                ),
                                                title: Row(

                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset("images/money.png",width: 40,height: 40,fit: BoxFit.fill,),

                                                    Text( cashondelivery,style: TextStyle(fontSize: 13,fontFamily: 'Poppins'),),

                                                  ],
                                                )



                                            ),

                                          )
                                        ],
                                      )



                                  )


                              )





                            ]














                        ),
                      )








                  )),

                  Expanded(child:

                  Column(

                    children: [


                  Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 10,right: 10,top: 5) : EdgeInsets.only(left: 16,right: 16,top: 8):EdgeInsets.only(left: 24,right: 24,top: 10),

                    child:GestureDetector(


                      child: Container(
                        color: Color(0xffffffff),
                        height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?50:60:70,

                        child:Row(



                          children: [

                            Expanded(child: Padding(padding: EdgeInsets.all(5),


                              child: SizedBox(
                                width: ResponsiveInfo.isMobile(context)?25:35,height:ResponsiveInfo.isMobile(context)?25:35,

                                child: Image.asset("images/couponcodebig.png",width: ResponsiveInfo.isMobile(context)?23:33,height:ResponsiveInfo.isMobile(context)?23:33 ,fit: BoxFit.contain,) ,
                              )


                              ,

                            ),flex: 1,)

                            ,

                            Expanded(child:       Padding(padding: EdgeInsets.all(5),

                              child:  Text(applycoupon,textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(0xff01713D),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),



                            ),flex: 7,)




                          ],


                        ) ,







                      ),

                      onTap: (){


                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(kenzfood,style: TextStyle(fontSize: 14,fontFamily: 'Poppins'),),

                            content: Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?10:20),

                                child:
                                Container(

                                  margin:  EdgeInsets.only(left:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:18:22,right:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:18:22 ),
                                  padding:  EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffE2E2E2),


                                      ),

                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))
                                  ),

                                  child: TextField(



                                    controller: couponcdecontroller,
                                    keyboardType: TextInputType.text,

                                    style:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? TextStyle(fontSize: 15, height: 1.3,color: Colors.black,fontFamily: 'Roboto'):TextStyle(fontSize: 18, height: 1.5,color: Colors.black,fontFamily: 'Roboto') : TextStyle(fontSize: 20, height: 1.5,color: Colors.black,fontFamily: 'Roboto') : TextStyle(fontSize: 24, height: 1.5,color: Colors.black,fontFamily: 'Roboto'),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(fontFamily: 'Poppins',fontSize: ResponsiveInfo.isMobile(context)?13:ResponsiveInfo.isSmallMobile(context)?11:15,color: Color(0xffD0D0D0)),



                                      hintText: '  '+couponcode,
                                    ),


                                  ),

                                )




                            ),





                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {



                                  if(couponcdecontroller.text.isNotEmpty)
                                    {


                                     // applycouponcode(couponcdecontroller.text.toString());

                                      try {


                                        Map<String,dynamic>mp=new Map();
                                        mp['coupon_code']=couponcdecontroller.text.toString().trim();
                                        mp['price']=totalprice;

                                        var bod = json.encode(mp);


                                        String apiToken = await getStringValue("token");

                                        String url = ServerConstants.baseurl + ServerConstants.applycoupon;

                                        final response = await http.post(
                                          Uri.parse(url),

                                          headers: {
                                            'Content-Type': 'application/json',

                                            ServerConstants.tokenKey: apiToken
                                          },

                                          body: bod,
                                        );

                                        if(response.statusCode==200) {
                                          final item = json.decode(response.body);

                                          print(response.body);


                                          setState(() {

                                            double d=item['new_total_price'];

                                            couponcodeamount=totalprice-d;


                                            totalprice = item['new_total_price'];
                                          });

                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                                "Coupon code applied "),
                                          ));


                                          Navigator.pop(context);
                                        }

                                      }
                                      catch(e){



                                      }


                                    }
                                  else{

                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Enter Coupon Code"),
                                    ));



                                  }



                                },
                                child: Text(apply,style: TextStyle(fontSize: 14,fontFamily: 'Poppins')),
                              ),

                            ],
                          ),
                        );


                      },


                    )





                  ),

                      Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 10,right: 10,top: 5) : EdgeInsets.only(left: 16,right: 16,top: 8):EdgeInsets.only(left: 24,right: 24,top: 10),

                          child:

                          Container(
                            color: Color(0xffffffff),


                            child: Column(

                              children: [

                                Padding(



                                  padding: EdgeInsets.all(8),
                                  child:  Row(

                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      Expanded(child: Text(totalpricelang,textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,)

                                      ,

                                      Expanded(child: Text(":",textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,),


                                      Expanded(child: Text(" Qr "+total.toStringAsFixed(2),textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,)





                                    ],

                                  ),
                                ),

                                Padding(



                                  padding: EdgeInsets.all(8),
                                  child:  Row(

                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      Expanded(child: Text(deliverycharge,textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,)

                                      ,

                                      Expanded(child: Text(":",textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,),


                                      Expanded(child: Text("Qr "+delcharge.toStringAsFixed(2),textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,)





                                    ],

                                  ),
                                ),

                                Padding(



                                  padding: EdgeInsets.all(8),
                                  child:  Row(

                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      Expanded(child: Text(couponcodeapplied,textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,)

                                      ,

                                      Expanded(child: Text(":",textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,),


                                      Expanded(child: Text("Qr "+couponcodeamount.toStringAsFixed(2),textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),flex: 1,)





                                    ],

                                  ),
                                ),

                                Padding(



                                  padding: EdgeInsets.all(8),
                                  child:  Row(

                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      Text(amounttopay+" : Qr "+totalprice.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                          0xff111111),fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),



                                      Container(
                                          width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 80:90:100,
                                          height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?30:35:40,
                                          decoration: BoxDecoration(

                                            color: Color(0xff01713D),
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            border: Border.all(
                                              color: Color(0xff01713D),
                                            ),
                                          ),

                                          child: TextButton(


                                            onPressed: () {

                                              if(data.length>0)
                                              {
                                                if(paymentmethode!=-1) {
                                                  createInvoice(paymentmethode);
                                                }
                                                else{

                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please select payment methode"),
                                                  ));
                                                }
                                              }
                                              else{

                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please select an address"),
                                                ));

                                              }








                                            },
                                            child: Text(paynow,textAlign: TextAlign.center,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 11:13:14:16,color: Color(
                                                0xffffffff),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),

                                          )





                                      )






                                    ],

                                  ),
                                )
                              ],


                            )







                          )),

                    ],
                  )



                    ,








                    flex: 3, )








                ],
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

        totalitems=lde['Total_items_en'];
        totalpricelang=lde['TotalPrice_en'];
        deliverycharge=lde['deliverycharge_en'];
        amounttopay=lde['amounttopay_en'];
        address=lde['Address_en'];
        change=lde['Change_en'];
        continuetopayment=lde['continuetopayment_en'];
        placeorder=lde['PlaceOrder_en'];
        selectaddress=lde['selectaddress_en'];
        items=lde['items_en'];
        selectpaymentmethod=lde['selectpaymentmetho_en'];
        // deliveryaddress=lde['deliveryaddr_en'];
        edit=lde['edit_en'];
        select=lde['select_en'];
        doord_elivery=lde['door_delivery_en'];
        pick_up=lde['pickup_en'];
        applycoupon=lde['applycoupon_en'];
        couponcodeapplied=lde['couponcodeapplied_en'];
        cashondelivery=lde['cashondelivery_en'];
        amounttopay=lde['amounttopay_en'];
        paynow=lde['paynow_en'];
        checkout=lde['checkout_en'];
        deliverymethode=lde['deliverymethode_en'];
        deliveryaddress=lde['deliveryaddr_en'];
        kenzfood=lde['kenz_food_en'];
        couponcode=lde['couponcode_en'];
        apply=lde['apply_en'];
        congratulations=lde['congratulations_en'];
        yourordermsg=lde['orderplaced_en'];
        trackyourorder=lde['trackyourorder_en'];

        failure=lde['failure_en'];
        failuremsg=lde['failuremsg_en'];


      }
      else {

        language=currentlanguage;

        failure=lde['failure_ar'];
        failuremsg=lde['failuremsg_ar'];

        congratulations=lde['congratulations_ar'];
        yourordermsg=lde['orderplaced_ar'];
        trackyourorder=lde['trackyourorder_ar'];


        apply=lde['apply_ar'];
        couponcode=lde['couponcode_ar'];
        kenzfood=lde['kenz_food_ar'];
        deliveryaddress=lde['deliveryaddr_ar'];
        checkout=lde['checkout_ar'];
        deliverymethode=lde['deliverymethode_ar'];
        paynow=lde['paynow_ar'];
        amounttopay=lde['amounttopay_ar'];
        cashondelivery=lde['cashondelivery_ar'];
        couponcodeapplied=lde['couponcodeapplied_ar'];
        applycoupon=lde['applycoupon_ar'];
        pick_up=lde['pickup_ar'];
        doord_elivery=lde['door_delivery_ar'];
        select=lde['select_ar'];
        edit=lde['edit_ar'];
        // deliveryaddress=lde['deliveryaddr_en'];
        totalitems=lde['Total_items_ar'];
        totalpricelang=lde['TotalPrice_ar'];
        deliverycharge=lde['deliverycharge_ar'];
        amounttopay=lde['amounttopay_ar'];
        address=lde['Address_ar'];
        change=lde['Change_ar'];
        continuetopayment=lde['continuetopayment_ar'];
        placeorder=lde['PlaceOrder_ar'];
        selectaddress=lde['selectaddress_ar'];
        items=lde['items_ar'];
        selectpaymentmethod=lde['selectpaymentmetho_ar'];
      }
    });







  }



  showPaymentMethodes(MFResult<MFInitiatePaymentResponse> result)
  {

    if(result!.response!.paymentMethods!.length>0)
      {


        setState(() {
          paymentMethods?.clear();
          paymentMethods?.addAll(result!.response!.paymentMethods!);
        });




//          showDialog(
//             context: context,
//             builder: (BuildContext context) {
//           return SimpleDialog(
//             title: Text(selectpaymentmethod),
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemBuilder: (ctx, index) {
//                     return GestureDetector(
//                 onTap: (){
//                   Navigator.pop(context);
//
// createInvoice(result!.response!.paymentMethods![index]!.paymentMethodId!.toInt());
//
//                 },
//                       child:    ListTile(
//                         leading: Image.network(result!.response!.paymentMethods![index]!.imageUrl.toString(),width: 50,height: 50,fit: BoxFit.fill,),
//                         title: Text( (language.compareTo("en")==0)?  result!.response!.paymentMethods![index]!.paymentMethodEn.toString() : result!.response!.paymentMethods![index]!.paymentMethodAr.toString()),
//                         trailing: Icon(Icons.arrow_forward_ios),
//                       ),
//                     );
//                   },
//                   itemCount: result!.response!.paymentMethods!.length,
//                 ),
//               )
//             ],
//           );
//         },
//     );



      }


  }


  createInvoice(int paymentmethodeId)
  async {
    Map transaction_id_data = new Map();

    if(paymentmethode!=0) {
      var body = null;
      var request = new MFExecutePaymentRequest(paymentmethodeId, totalprice);


      MFSDK.executePayment(context, request,
          (language.compareTo("en") == 0) ? MFAPILanguage.EN : MFAPILanguage.AR,
          onInvoiceCreated: (String invoiceId) =>
          {
            print("invoiceId: " + invoiceId)
          },
          onPaymentResponse: (String invoiceId,
              MFResult<MFPaymentStatusResponse> result) async =>
          {
            if(result.isSuccess()) {
              // print(result.response?.toJson().toString())

              if(result.response!.invoiceStatus.toString().compareTo("Paid") ==
                  0)
                {

                transaction_id_data["transaction_id"] = invoiceId,

                if(code == 1)
                {
                transaction_id_data["delivery_type"] = "door delivery",
                transaction_id_data["delivery_time"] =
                currentdate + " " + current_time,


                }
                else
                {
                transaction_id_data["delivery_type"] = "Pickup",

                },
                // chnages needed

                body = json.encode(transaction_id_data),


                response = await orderProvider.placeOrder(
                context,
                data[addressselectedindex].id.toString(), body),

                if (response.isNotEmpty) {
                body = json.decode(response),

                if (body != null) {
                if (body.containsKey("message")) {
                if (body.containsKey("return")) {
                returndata = body['return']
                    .toString(),

                if (returndata.compareTo("success") == 0) {
                // Navigator.push(
                // context, MaterialPageRoute(
                // builder: (_) => ReceiptPage("1")))

                showReciptDialog("1")
                }
                else
                {
                // Navigator.push(
                // context, MaterialPageRoute(
                // builder: (_) => ReceiptPage("0")))


                  showReciptDialog("0")

                },

                //
                // ScaffoldMessenger.of(context).showSnackBar(
                // SnackBar(
                // content: Text(
                // body["message"]),
                // )),
                print(body["message"])
                }
                }
                }
                },


                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result.error!.message.toString()))),
                }
              else
                {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Payment Failed")),
                  )
                }
            }
            else
              {


                transaction_id_data["transaction_id"] = invoiceId,

                if(code == 1)
                  {
                    transaction_id_data["delivery_type"] = "door delivery",
                    transaction_id_data["delivery_time"] =
                        currentdate + " " + current_time,


                  }
                else
                  {
                    transaction_id_data["delivery_type"] = "Pickup",

                  },
                // chnages needed

                body = json.encode(transaction_id_data),


                response = await orderProvider.placeOrder(
                    context,
                    data[addressselectedindex].id.toString(), body),

                if (response.isNotEmpty) {
                  body = json.decode(response),

                  if (body != null) {
                    if (body.containsKey("message")) {
                      if (body.containsKey("return")) {
                        returndata = body['return']
                            .toString(),

                        if (returndata.compareTo("success") == 0) {
                     showReciptDialog("1")
                        }
                        else
                          {
                            showReciptDialog("0")
                          },


                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //           body["message"]),
                        //     )),
                        print(body["message"])
                      }
                    }
                  }
                },


                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result.error!.message.toString())),


                ),
                // Navigator.push(
                //     context, MaterialPageRoute(
                //     builder: (_) => ReceiptPage("1")))

              }
          });
    }
    else{

      transaction_id_data["transaction_id"] = "";

    if(code == 1)
    {
    transaction_id_data["delivery_type"] = "door delivery";
    transaction_id_data["delivery_time"] =
    currentdate + " " + current_time;

    // transaction_id_data["delivery_time"] =
    //     currentdate + " " + "07:16";
    }
    else
    {
    transaction_id_data["delivery_type"] = "Pickup";

    }
    // chnages needed

   String body = json.encode(transaction_id_data);


    response = await orderProvider.placeOrder(
    context,
    data[addressselectedindex].id.toString(), body);

    if (response.isNotEmpty) {
   var body = json.decode(response);

    if (body != null) {
    if (body.containsKey("message")) {
    if (body.containsKey("return")) {
    returndata = body['return']
        .toString();

    if (returndata.compareTo("success") == 0) {
    // Navigator.push(
    // context, MaterialPageRoute(
    // builder: (_) => ReceiptPage("1")));

      showReciptDialog("1");
    }
    else
    {
    // Navigator.push(
    // context, MaterialPageRoute(
    // builder: (_) => ReceiptPage("0")));

      showReciptDialog("0");

    }


    // ScaffoldMessenger.of(context).showSnackBar(
    // SnackBar(
    // content: Text(
    // body["message"]),
    // ));
    print(body["message"]);
    }
    }
    }
    }













    }
  }


  showReciptDialog(String status)
  {

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: Text("Kenz Market",style: TextStyle(fontSize: 14,fontFamily: 'Poppins'),),

        content: Container(
          width:double.infinity,
          height: 350,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              (status.compareTo("1")==0)?     Padding(padding: EdgeInsets.all(15),

                child: Text(congratulations,style: TextStyle(fontSize: 20,fontFamily: 'Poppins',color: Colors.green,decoration: TextDecoration.underline,)),
              ) : Padding(padding: EdgeInsets.all(15),

                child: Text(failure,style: TextStyle(fontSize: 20,fontFamily: 'Poppins',color: Colors.red,decoration: TextDecoration.underline,)),
              ),
              (status.compareTo("1")==0)?     Padding(padding: EdgeInsets.all(15),

                child: Text(yourordermsg,style: TextStyle(fontSize: 15,fontFamily: 'Poppins',color: Colors.black38),textAlign: TextAlign.center,),
              ) :

              Padding(padding: EdgeInsets.all(15),

                child: Text(failuremsg,style: TextStyle(fontSize: 15,fontFamily: 'Poppins',color: Colors.black38),textAlign: TextAlign.center,),
              )
              ,


              (status.compareTo("1")==0)?    Padding(padding: EdgeInsets.all(15),

                child:GestureDetector(
                  onTap: (){


                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MyordersPage(title: 'Orders',)),
                    );
                  },

                  child:Text(trackyourorder,style: TextStyle(fontSize: 20,fontFamily: 'Poppins',color: Colors.green,decoration: TextDecoration.underline,)),

                )


                              ) : Container()

            ],
          )
        )










      ),
    );

  }



  getAddress(int acs)
  {


    addressDataProvider.getAddressList(context);
    // addressDataProvider = Provider.of<AddressDataProvider>(context);
    addressDataProvider = Provider.of<AddressDataProvider>(context,listen: false);
    AddressEntity ade= addressDataProvider.addressEntity;


    if(ade!=null) {
      if (ade.data.length > 0) {

        int addresindex=0;


        for(int i=0;i<data.length;i++)
        {
          if(acs==data[i].id)
          {

           addresindex=i;
            break;
          }


        }


        setState(() {
          data.clear();

          data.addAll(ade.data);


          addressselectedindex=addresindex;

          getDeliveryCharges(data[addresindex].postalCode);





        });


      }
    }





  }


  Future displayDatePicker(BuildContext context) async
  {


    DateTime dateTime=DateTime.now();

    DateTime selected = DateTime.now();
    DateTime initial = DateTime(2000);
    DateTime last = DateTime(2025);

    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: dateTime,
      lastDate: last,
    );

    if (date != null) {

      String  reminddate = date.toLocal().toString().split(" ")[0];
      DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(reminddate);
      String min=tempDate.month.toString();
      if(tempDate.month>=10)
      {
        min=tempDate.month.toString();
      }
      else{

        min="0"+tempDate.month.toString();
      }

      setState(() {
        currentdate = tempDate.day.toString()+"-"+min+"-"+tempDate.year.toString();




      });
    }
  }

  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    return time;
  }


  getDeliveryCharges(String postalcode)
  async {
    String url=ServerConstants.baseurl+ServerConstants.getDeliverycharges+"?zipcode="+postalcode;

    final response = await http.get(
      Uri.parse(url),

      headers: {
        'Content-Type':'application/json',

      },


    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);


      DeliveryChargeDataEntity chargeDataEntity=DeliveryChargeDataEntity.fromJson(item);

      if(chargeDataEntity!=null)
        {

          double d=chargeDataEntity.normalCharge;


          setState(() {
     delcharge=d;

     totalprice=totalprice+d;

          });



        }





    }

  }

  Future<void> getFirstAddress() async {

    late  AddressEntity result;
    try {

      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.addAddress;

      final response = await http.get(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },


      );
      if (response.statusCode == 200) {

        print(url);
        print(response.body);

        final item = json.decode(response.body);
        result=AddressEntity.fromJson(item);

        AddressEntity ade= result;


        if(ade!=null) {
          if (ade.data.length > 0) {




            setState(() {
              data.clear();

              data.addAll(ade.data);


              addressselectedindex=0;


              addressselectedindex=0;

              getDeliveryCharges(data[0].postalCode);




            });


          }
        }


      }
      else if(response.statusCode==401){

        Map results = await Navigator.of(context)
            .push(new MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return new NewLoginpage();
          },
        ));
        if (results != null &&
            results.containsKey('loggedin')) {

          var loggedin =
          results['loggedin'];

          int logdata =
          loggedin as int;

          if(logdata==1)
          {

            getFirstAddress();

          }




        }

      }




      else {

        print(response);

      }
    } catch (e) {

    }


  }

  Future<void> applycouponcode(String coupon) async {

    try {


      Map<String,dynamic>mp=new Map();
      mp['coupon_code']=coupon.trim();
      mp['price']=totalprice;

      var bod = json.encode(mp);


      String apiToken = await getStringValue("token");

      String url = ServerConstants.baseurl + ServerConstants.applycoupon;

      final response = await http.post(
        Uri.parse(url),

        headers: {
          'Content-Type': 'application/json',

          ServerConstants.tokenKey: apiToken
        },

        body: bod,
      );

      if(response.statusCode==200) {
        final item = json.decode(response.body);

        print(response.body);


        setState(() {

          double d=item['new_total_price'];

          couponcodeamount=totalprice-d;


          totalprice = item['new_total_price'];
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Coupon code applied "),
        ));
      }

    }
    catch(e){


    }

  }


}
