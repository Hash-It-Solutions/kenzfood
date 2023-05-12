import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/constant.dart';
import '../databasehelper/DatabaseHelper.dart';
import '../databasehelper/DatabaseTables.dart';
import '../dataproviders/CartDataProvider.dart';
import '../dataproviders/WishlistProvider.dart';
import '../models/productlist_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';

class MyProductDetailsPage extends StatefulWidget {

  int id;
  int qty;
  ProductlistProducts productlistProducts;

   MyProductDetailsPage(this.id,this.qty,this.productlistProducts) ;

  @override
  _MyProductDetailsPageState createState() => _MyProductDetailsPageState(id,qty,productlistProducts);
}

class _MyProductDetailsPageState extends State<MyProductDetailsPage> {


  int id;
  int qty;
  ProductlistProducts productlistProducts;
  late CartDataProvider cartDataProvider;

  _MyProductDetailsPageState(this.id,this.qty,this.productlistProducts) ;

  String language="",addtocart="";

  String doordelivery="Door Delivery",pickup="Pick Up",usertype="user",unitqty="Unit Quantity",unit="Unit";

  int code=1;

  String currentdate="",current_time="",wholesalecount="",wholesaleunit="";


  int paymentmethode=-1;
  late WishlistDataProvider wishlistDataProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    cartDataProvider = Provider.of<CartDataProvider>(context, listen: false);
    getUserType();


    addToHistory(productlistProducts);
  }

  getUserType()
  async {

    String usertpe = await getStringValue("user_tye");

    setState(() {

      if(usertpe.isNotEmpty)
      {
        if(usertpe.compareTo("wholesale")==0)
        {

          usertype="wholesale";
        }
        else{
          usertype="normal";
        }



      }
      else{
        usertype="normal";

      }

    });


  }


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double price=0,offerprice=0,offerpercent=0;
    bool ispricesame=false;

    String url="";

    if(productlistProducts.productStock.length>0)
    {

      try {
        price = double.parse(productlistProducts.productStock[0].productPrice);
        offerprice =
            double.parse(productlistProducts.productStock[0].productOfferPrice);

        if (price != 0 && offerprice != 0) {
          if (price == offerprice) {
            ispricesame = true;
          }
          else {
            ispricesame = false;
          }
        }
      }on Exception catch (_) {
        // make it explicit that a SocketException will be thrown if the network connection fails
        rethrow;
      }


    }

    if(productlistProducts.productImages.length>0)
    {

      url=productlistProducts.productImages[0].productImageUrl;

    }

    if (productlistProducts.productStock.length > 0) {

      wholesalecount=   productlistProducts.productStock[0].wholesaleCount.toString();
      wholesaleunit=   productlistProducts.productStock[0].wholesaleUnit.toString();

      price = double.parse(
          productlistProducts.productStock[0]
              .productPrice);
      offerprice = double.parse(
          productlistProducts.productStock[0]
              .productOfferPrice);


      if (price != 0 && offerprice != 0) {
        if (price == offerprice) {
          ispricesame = true;
          productlistProducts.ispricesame = ispricesame;
        }
        else {
          ispricesame = false;
          productlistProducts.ispricesame = ispricesame;
          offerpercent=((price-offerprice)/price)*100;

        }
      }
    }


    return


  Container(

          width: width,
          height: height,
          // height: (MediaQuery.of(context).size.height),

          child:Stack(

            children: [


              Align(

                alignment: FractionalOffset.topRight,
                child: Padding(padding: EdgeInsets.all(10),

                    child: GestureDetector(

                      child: Image.asset("images/close.png",width: 30,height: 30,fit: BoxFit.fill,),

                      onTap: (){

                        Navigator.pop(context);
                      },

                    )


                ),

              ),


              Align(

                alignment: FractionalOffset.topCenter,

                child: Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?40:50:60),

                  child:



                  Card(




                      child:  Column(

                          children: [

                            Stack(

                              children: [

                                Align(

                                  alignment: FractionalOffset.topRight,
                                  child:                         Container(
                                      margin: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                          ? ResponsiveInfo.isSmallMobile(context)
                                          ?2:5:8),

                                      child: GestureDetector(

                                        child:  Icon(Icons.favorite_outline,color:(productlistProducts.inWishlist)?Colors.red: Colors.black,size:ResponsiveInfo.isMobile(context)
                                            ? ResponsiveInfo.isSmallMobile(context)
                                            ?20:23:28 ,),

                                        onTap: () async {

                                          if(!productlistProducts.inWishlist)
                                          {

                                            wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);


                                            String response=await  wishlistDataProvider.addWishlist(context, productlistProducts.id.toString());

                                            if(response.isNotEmpty)
                                            {




                                              Map body = json.decode(response);

                                              if(body!=null) {

                                                if(body.containsKey("message")) {

                                                  setState(() {

                                                    ProductlistProducts p=productlistProducts;

                                                    p.inWishlist=true;


                                                    // w.insert(j, Container(width: 30,height: 30,color: Colors.red,));

                                                    // products.removeAt(a);
                                                    // products.insert(a,p);
                                                    //
                                                    //
                                                    // getProductsByCategory( categori, products);

                                                  });
                                                  // getAllItemsFromCart();

                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    content: Text(
                                                        body["message"]),
                                                  ));
                                                  print(body["message"]);
                                                }
                                              }




                                            }
                                          }
                                          else{

                                            wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);

                                            String response=await  wishlistDataProvider.remove(context, productlistProducts.id.toString());

                                            if(response.isNotEmpty)
                                            {




                                              Map body = json.decode(response);

                                              if(body!=null) {

                                                if(body.containsKey("message")) {

                                                  setState(() {


                                                    ProductlistProducts p=productlistProducts;

                                                    p.inWishlist=false;

                                                  });




                                                  // getAllItemsFromCart();

                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    content: Text(
                                                        body["message"]),
                                                  ));
                                                  print(body["message"]);
                                                }
                                              }




                                            }

                                          }



                                        },
                                      )





                                  ),
                                )

                              ],
                            ),




                            (productlistProducts.productImages.length>0)?
                            Image.network(productlistProducts.productImages[0].productImageUrl,fit: BoxFit.fill, width: (MediaQuery
                                .of(context)
                                .size
                                .width), height: (MediaQuery
                                .of(context)
                                .size
                                .width) / 2.2,

                                errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                      "images/pi.png",  fit: BoxFit.fill
                                  );
                                }

                            ) : Image.asset(
                                "images/pi.png", width: (MediaQuery
                                .of(context)
                                .size
                                .width), height: (MediaQuery
                                .of(context)
                                .size
                                .width) / 2, fit: BoxFit.fill
                            )

                            ,

                            Container(child:  Padding(padding: EdgeInsets.all(10),
                                child: SingleChildScrollView(

                                    child: Text((language.compareTo("en")==0)?productlistProducts.productDescEn :productlistProducts.productDescAr ,style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:17),maxLines: 10,)

                                )




                            ),height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?150:200:250,),






                            (usertype.compareTo("wholesale")==0)?     Padding(padding:
                                ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                    .isSmallMobile(context) ? EdgeInsets.all(2) :
                                EdgeInsets.all(4) :
                                EdgeInsets.all(6),

                                  child: Text(
                                    unitqty+" : "+wholesalecount,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(

                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.normal,
                                        fontSize: ResponsiveInfo.isMobile(context)
                                            ? ResponsiveInfo.isSmallMobile(context) ? 11 : 12
                                            : 14,

                                        color: Color(0xff01713D)),
                                  ),


                                ) : Container(),

                                (usertype.compareTo("wholesale")==0)?   Padding(padding:
                                ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                    .isSmallMobile(context) ? EdgeInsets.all(2) :
                                EdgeInsets.all(4) :
                                EdgeInsets.all(6),

                                  child: Text(
                                    unit+" : "+wholesaleunit,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(

                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.normal,
                                        fontSize: ResponsiveInfo.isMobile(context)
                                            ? ResponsiveInfo.isSmallMobile(context) ? 11 : 12
                                            : 14,

                                        color: Color(0xff01713D)),
                                  ),


                                ) : Container(),





                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Expanded(child: (ispricesame) ? Padding(padding:
                                ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                    .isSmallMobile(context) ? EdgeInsets.all(2) :
                                EdgeInsets.all(4) :
                                EdgeInsets.all(6),

                                  child: Text(
                                    price.toString() + " Qr",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(

                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.normal,
                                        fontSize: ResponsiveInfo.isMobile(context)
                                            ? ResponsiveInfo.isSmallMobile(context) ? 11 : 12
                                            : 14,

                                        color: Color(0xff01713D)),
                                  ),


                                ) : Padding(padding:
                                ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                    .isSmallMobile(context) ? EdgeInsets.all(2) :
                                EdgeInsets.all(4) :
                                EdgeInsets.all(6),

                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [

                                        Text(
                                          price.toString() + " Qr",
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              decoration: TextDecoration.lineThrough,

                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.normal,
                                              fontSize: ResponsiveInfo.isMobile(context)
                                                  ? ResponsiveInfo.isSmallMobile(context)
                                                  ? 11 : 12
                                                  : 14,


                                              color: Color(0xff01713D)),
                                        ),

                                        Text(
                                          "  " + offerprice.toString() + " Qr",
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(

                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.normal,
                                              fontSize: ResponsiveInfo.isMobile(context)
                                                  ? ResponsiveInfo.isSmallMobile(context)
                                                  ? 11 : 12
                                                  : 14,

                                              color: Color(0xff01713D)),
                                        ),

                                      ],


                                    )


                                ),flex: 2,)

                                ,
                                Container(child: Text("  /  ",style:TextStyle(color: Colors.black45) ,),),

                                Expanded(child:Padding(
                                  child:   Container(




                                    child:

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Container(

                                          decoration: BoxDecoration(

                                              color: Color(0xba01713d),
                                              borderRadius: BorderRadius.only(topLeft:  Radius.circular(5),bottomLeft: Radius.circular(5))
                                          ),


                                          width: ResponsiveInfo.isMobile(context)
                                              ? ResponsiveInfo.isSmallMobile(context) ?25:28:33,
                                          height: ResponsiveInfo.isMobile(context)
                                              ? ResponsiveInfo.isSmallMobile(context) ?25:28:33,


                                          child:GestureDetector(


                                            child:Icon(Icons.remove,size: 15,color: Colors.white,) ,

                                            onTap: (){

                                              if(qty!=1)
                                              {
                                                setState(() {
                                                  qty--;




                                                });

                                              }

                                            },
                                          )





                                          ,



                                        ),

                                        Container(


                                          decoration: BoxDecoration(

                                            color: Color(0xfff4f5f4),
                                            borderRadius: BorderRadius.all(Radius.circular(0)),
                                            border: Border.all(
                                              color: Color(0xff01713D),
                                            ),
                                          ),

                                          width: ResponsiveInfo.isMobile(context)
                                              ? ResponsiveInfo.isSmallMobile(context) ?35:40:50,
                                          height: ResponsiveInfo.isMobile(context)
                                              ? ResponsiveInfo.isSmallMobile(context) ?25:28:33,

                                          child: Padding(

                                            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                                ? ResponsiveInfo.isSmallMobile(context) ?3:5:7),
                                            child: Text(qty.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),

                                          ),



                                        ),



                                        Container(

                                          decoration: BoxDecoration(

                                              color: Color(0xba01713d),
                                              borderRadius: BorderRadius.only(topRight:  Radius.circular(5),bottomRight: Radius.circular(5))
                                          ),


                                          width: ResponsiveInfo.isMobile(context)
                                              ? ResponsiveInfo.isSmallMobile(context) ?25:28:33,
                                          height: ResponsiveInfo.isMobile(context)
                                              ? ResponsiveInfo.isSmallMobile(context) ?25:28:33,


                                          child: GestureDetector(

                                            child: Icon(Icons.add,size: 15,color: Colors.white,),

                                            onTap: (){


                                                setState(() {
                                                  qty++;




                                                });



                                            },
                                          )








                                        )


                                      ],
                                    ),





                                  ),
                                  padding:      ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                      .isSmallMobile(context) ? EdgeInsets.all(3) :
                                  EdgeInsets.all(5) :
                                  EdgeInsets.all(8),
                                )





                                  ,flex: 2,)






                              ],

                            ),

                            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:15:25),

                              child:    Container(

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:  Color(0xff01713D)
                                ),
                                height: ResponsiveInfo.isMobile(context)?55:ResponsiveInfo.isSmallMobile(context)?40:50,
                                width: ResponsiveInfo.isMobile(context)?175:ResponsiveInfo.isSmallMobile(context)?160:190,
                                child: TextButton(
                                    onPressed: () async {

                                      Map<String,String>mp=new Map();
                                      mp['quantity']=qty.toString();

                                      var body = json.encode(mp);


                                      String response=await cartDataProvider.addtoCart(context, id.toString(), body);

                                      if(response.isNotEmpty)
                                      {




                                        Map body = json.decode(response);

                                        if(body!=null) {

                                          if(body.containsKey("message")) {
                                            // setState(() {
                                            //   iswishlist=true;
                                            // });




                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                  body["message"]),
                                            ));
                                            print(body["message"]);
                                          }
                                        }




                                      }



                                    }
                                    ,
                                    child: Text(
                                      addtocart,
                                      style:  TextStyle(
                                          color: Colors.white ,
                                          fontFamily: 'poppins',
                                          fontSize: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?13:18

                                      ),
                                    )),
                              ),

                            )








                          ]
                      )








                  ),

                ),

              )

            ],
          ),


    );
  }

  checkLanguage()async
  {

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();

    language=currentlanguage;

    setState(() {

      if (currentlanguage.compareTo("en") == 0) {

        language=currentlanguage;

        addtocart=lde['addtocart_en'];
        unit=lde['unit_en'];
        unitqty=lde['unitqty_en'];



      }
      else {
        language=currentlanguage;
        addtocart=lde['addtocart_Ar'];
        unit=lde['unit_ar'];
        unitqty=lde['unitqty_ar'];
      }

    });







  }

  addToHistory(ProductlistProducts product)async{
    List<Map<String, dynamic>> a =
    await new DatabaseHelper().queryAllRows(DatabaseTables.History);


    String idp="0";

    bool isHistoryexist=false;

    for (Map ab in a) {
      print(ab.length.toString() + " \n");
      print("data \n");


      int id = ab["keyid"];
      String data = ab["data"];

      var jsondata = jsonDecode(data);

      idp = jsondata['id'].toString();

      print(jsondata);


      if (idp.compareTo(product.id.toString()) == 0) {
        isHistoryexist = true;
        break;
      }
    }

    if(!isHistoryexist) {
      Map<String, dynamic> assetdata = new Map();
      assetdata['id'] =product.id ;
      assetdata['product'] = product.toJson();
      var js = json.encode(assetdata);
      Map<String, dynamic> data_To_Table = new Map();
      data_To_Table['data'] = js.toString();
      new DatabaseHelper().insert(data_To_Table, DatabaseTables.History);
    }




  }
}
