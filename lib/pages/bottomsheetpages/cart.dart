import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../dataproviders/CartDataProvider.dart';
import '../../models/cart_entity.dart';
import '../../utils/LanguageValues.dart';
import '../../utils/ResponsiveInfo.dart';
import '../summary_page.dart';

class Cart extends StatefulWidget {
  const Cart() : super();

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {



  late CartDataProvider cartDataProvider;

  List<CartCartItems> cartItems=[];
  String totalpricetext="",discountamt="",payable="", nodatafound="", language="",mycart="",clearall="",checkout="",totalamount="",delete="",items="",clearmsg="",deletemsg="",yes="",no="",kenz="";

  @override
  void initState() {
    // TODO: implement initState



    cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);

    cartDataProvider.getPostData(context);
    super.initState();
    checkLanguage();
   // getAllItemsFromCart();


    // showTutorial();

  }


  double   price=0;
  double  offerprice=0,totalprice=0,offerpercent=0;

  double totalpricefullcart=0,pricewithoutoffer=0,coupondiscount=0,totalofferpercentage=0;


  @override
  Widget build(BuildContext context) {


     cartDataProvider = Provider.of<CartDataProvider>(context);

    if(cartDataProvider.post.cartItems.length>0)
      {
        // cartItems.clear();
        //
        // cartItems.addAll(cartDataProvider.post.cartItems);

        if(cartDataProvider.post.cartItems.length>0)
        {
          cartItems.clear();

          cartItems.addAll(cartDataProvider.post.cartItems);

          totalpricefullcart=0;
          pricewithoutoffer=0;
          coupondiscount=0;
          totalofferpercentage=0;
          for(int j=0;j<cartItems.length;j++)
          {
            if(cartItems[j].productStock!=null)
            {
              price=double.parse(cartItems[j].productStock.productPrice);
              offerprice=double.parse(cartItems[j].productStock.productOfferPrice);

              int q= int.parse(cartItems[j].quantity);

              if(price!=0&&offerprice!=0) {


                if (price == offerprice) {


                  totalprice=price*q;

                }
                else{

                  totalprice=offerprice*q;

                  offerpercent=((price-offerprice)/price)*100;
                  totalofferpercentage=totalofferpercentage+offerpercent;
                }

                pricewithoutoffer=pricewithoutoffer+(price*q);

                totalpricefullcart=totalpricefullcart+totalprice;
              }


            }





          }

        }

      }



    return Scaffold(


      body: Container(color: Colors.white,

      child: 
      
      
      
      Column(

        children: [



          
          // Expanded(
          //
          //
          //   child:  Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 12):EdgeInsets.only(left: 18):EdgeInsets.only(left: 25),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //
          //       children: [
          //
          //         // Expanded(child:  Text(mycart+" ("+cartItems.length.toString()+" "+items+  ")",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.black),),
          //         // flex: 3,),
          //
          //         Expanded(child:  Container(),
          //           flex: 3,),
          //
          // Expanded(child:  TextButton(onPressed: (){
          //
          //
          //   Widget yesButton = TextButton(
          //       child: Text(yes),
          //       onPressed: () async {
          //
          //         Navigator.pop(context);
          //         clearProductFromCart();
          //
          //
          //
          //       });
          //
          //
          //
          //   Widget noButton = TextButton(
          //     child: Text(no),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   );
          //
          //   // set up the AlertDialog
          //   AlertDialog alert = AlertDialog(
          //     title: Text(kenz),
          //     content: Text(clearmsg),
          //     actions: [yesButton, noButton],
          //   );
          //
          //   // show the dialog
          //   showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return alert;
          //     },
          //   );
          //
          //
          //
          //         }, child: Text(clearall,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.green),),
          //         ),flex: 1),
          //
          //
          //       ],
          //     )
          //
          //
          //               ),
          //   flex: 1,
          // ),



          
          Expanded(
            
   flex: 4,
            
            child: Padding(
              
              padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(top: 5):EdgeInsets.only(top: 10):EdgeInsets.only(top: 15),
              child: (cartItems.length>0)?  ListView.builder(
                  itemCount: cartItems.length,
                  shrinkWrap: true,

                  primary: false,
                  itemBuilder: (BuildContext context,int i){

                    bool ispricesame=false;
                    String imgurl="";
                    offerprice=0;
                    price=0;
                    totalprice=0;

                    if(cartItems[i].productStock!=null)
                    {

                      price=double.parse(cartItems[i].productStock.productPrice);
                     offerprice=double.parse(cartItems[i].productStock.productOfferPrice);

                     int q= int.parse(cartItems[i].quantity);

                      if(price!=0&&offerprice!=0) {
                        if (price == offerprice) {
                          ispricesame=true;

                          totalprice=price*q;

                        }
                        else{

                          totalprice=offerprice*q;

                          offerpercent=((price-offerprice)/price)*100;

                          ispricesame=false;
                        }
                      }


                    }

                    if(cartItems[i].productImages.length>0)
                      {
                        imgurl=cartItems[i].productImages[0].productImageUrl;

                      }

                    return Stack(

                      children: [

                        Align(

                          alignment: FractionalOffset.center,

                          child: Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5): EdgeInsets.all(8): EdgeInsets.all(15),
                              key: UniqueKey(),

                              child: Dismissible(
                                // Each Dismissible must contain a Key. Keys allow Flutter to
                                // uniquely identify widgets.

                                background:Stack(

                                  children: [

                                    Align(

                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Color(0xffEB8888),


                                        ),


                                      ),
                                      alignment: FractionalOffset.center,
                                    ),

                                    Align(

                                        alignment: FractionalOffset.centerRight,

                                        child: Padding(padding: EdgeInsets.all(5),

                                            child: Text("Delete",style: TextStyle(fontSize: 13,color: Colors.white))


                                        )


                                    ),

                                    Align(

                                        alignment: FractionalOffset.centerLeft,

                                        child: Padding(padding: EdgeInsets.all(5),

                                            child: Text("Delete",style: TextStyle(fontSize: 13,color: Colors.white))


                                        )


                                    )
                                  ],
                                ),





                                key: Key(i.toString()),
                                // Provide a function that tells the app
                                // what to do after an item has been swiped away.
                                onDismissed: (direction) {
                                  // Remove the item from the data source.


                                  // Then show a snackbar.

                                  deleteProductFromCart(cartItems[i].productId, i);

                                },


                                child:

                                Card(
                                  elevation: 8,

                                  child:

                                  Row(

                                    children: [

                                      Expanded(child: Container(
                                          width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?  140:175:200,
                                          height:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?  120:150:180,
                                          color: Color(0x5f70c9a2),

                                          child:   Stack(


                                            children: [

                                              Align(

                                                alignment: FractionalOffset.center,

                                                child:     (cartItems[i].productImages.length>0)?




                                                Image.network(imgurl,
                                                  width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:75:90,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:75:90,fit: BoxFit.fill,
                                                  errorBuilder:
                                                      (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                    return Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:75:90 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:75:90,fit: BoxFit.fill
                                                    );
                                                  },
                                                )   :
                                                Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:90:110 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 60:90:110,fit: BoxFit.fill
                                                )  ,
                                              )
                                            ],
                                          )










                                      ),flex: 2,)

                                      ,

                                      Expanded(child:


                                      Column(

                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,


                                        children: [




                                          Padding(padding:
                                          ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(3) :
                                          EdgeInsets.all(5):
                                          EdgeInsets.all(8),
                                            child: Text(

                                              (language.compareTo("en") == 0) ? cartItems[i].productNameEn :
                                              cartItems[i].productNameAr
                                              ,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(

                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: ResponsiveInfo.isMobile(context)
                                                      ? ResponsiveInfo.isSmallMobile(context) ? 12 : 13
                                                      : 18,

                                                  color: Colors.black),
                                            ),


                                          ),



                                          Padding(padding:
                                          ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(3) :
                                          EdgeInsets.all(5):
                                          EdgeInsets.all(8),

                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,

                                                children: [

                                                  Padding(
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

                                                                int q=int.parse(cartItems[i].quantity);

                                                                // if(q>1) {
                                                                int a = q - 1;

                                                                setState(() {
                                                                  cartItems[i].quantity=a.toString();
                                                                });

                                                                decreaseQty(cartItems[i].productId);


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
                                                              child: Text(cartItems[i].quantity.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),

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


                                                                  int q=int.parse(cartItems[i].quantity);
                                                                  int a = q + 1;
                                                                  setState(() {
                                                                    cartItems[i].quantity=a.toString();
                                                                  });

                                                                  increaseQty(cartItems[i].productId);


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
                                                  ),



                                                  (!ispricesame)?     Padding(padding:
                                                  ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(3) :
                                                  EdgeInsets.all(5):
                                                  EdgeInsets.all(8),

                                                      child:   Row(

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
                                                  )) :
                                                  Padding(padding:
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


                                                  )




                                                ],


                                              )






                                          )



                                        ],
                                      )



                                          ,flex: 3),



                                    ],



                                  ),


                                ),














                              )



                          )
                        ),

                        Align(

                          alignment: FractionalOffset.topRight,
                          child: Padding(padding: EdgeInsets.only(right: 10,top: 10),

                            child: (!ispricesame)?
                            Align(

                              child:Container(

                                decoration: BoxDecoration(
                                    color: Color(0xff01713D),

                                    borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                                )
                                ,


                                child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                    ? ResponsiveInfo.isSmallMobile(context)
                                    ?5:7:9),

                                  child:Text(offerpercent.toStringAsFixed(1)+"% off",style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)
                                      ? ResponsiveInfo.isSmallMobile(context)
                                      ?11:13:14, fontFamily: 'Poppins' ),) ,


                                )

                                ,


                              ) ,
                              alignment: FractionalOffset.topRight,
                            ):Container(),



                          ),
                        )
                      ],
                    );



                  }
              ) : Stack(

                children: [

                  Align(
                    alignment: FractionalOffset.center,

                    child:

                    Text("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n  "+nodatafound,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.green)),
                  )
                ],
              ),
            ),
          ),


          (cartItems.length>0)?    Expanded(




    child: Padding(

      padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?EdgeInsets.only(left: 0,right: 0,bottom: 80):EdgeInsets.only(left: 0,right: 0,bottom: 100):EdgeInsets.only(left: 0,right: 0,bottom: 130),
      child: Column(

        children: [



          Expanded(child: Card(

            child:    Column(

                children: [



                  Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?4:7:10),

                    child: Row(

                      children: [


                        Expanded(child: Text(totalpricetext,style: TextStyle(color: Colors.black45,fontSize:ResponsiveInfo.isMobile(context)? 13:16)),flex: 2,),

                        Expanded(child: Text(":"),flex: 1,),

                        Expanded(child: Text(pricewithoutoffer.toStringAsFixed(2)+"Qr ",style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:16)),flex: 2,)



                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?4:7:10),

                    child: Row(

                      children: [


                        Expanded(child: Text(discountamt,style: TextStyle(color: Colors.black45,fontSize:ResponsiveInfo.isMobile(context)? 13:16)),flex: 2,),

                        Expanded(child: Text(":"),flex: 1,),

                        Expanded(child: Text(totalofferpercentage.toStringAsFixed(2)+" %",style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:16)),flex: 2,)



                      ],
                    ),
                  ),


                  // Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?4:7:10),
                  //
                  //   child: Row(
                  //
                  //     children: [
                  //
                  //
                  //       Expanded(child: Text("Coupon Discount",style: TextStyle(color: Colors.black45,fontSize:ResponsiveInfo.isMobile(context)? 13:16)),flex: 2,),
                  //
                  //       Expanded(child: Text(":"),flex: 1,),
                  //
                  //       Expanded(child: Text("0.00",style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:16)),flex: 2,)
                  //
                  //
                  //
                  //     ],
                  //   ),
                  // ),


                  Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?4:7:10),

                    child: Row(

                      children: [


                        Expanded(child: Text(payable,style: TextStyle(color: Colors.black45,fontSize:ResponsiveInfo.isMobile(context)? 13:16)),flex: 2,),

                        Expanded(child: Text(":"),flex: 1,),

                        Expanded(child: Text(totalpricefullcart.toStringAsFixed(2)+" Qr",style: TextStyle(color: Colors.green,fontSize:ResponsiveInfo.isMobile(context)? 13:16)),flex: 2,)



                      ],
                    ),
                  ),




                ]
            ),
            elevation: 5,
          ),flex: 2, ),

          Expanded(child:         Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?4:7:10),

            child:Stack(

    children: [

      Align(

      alignment: FractionalOffset.center,

      child:  Container(

        width:double.infinity,
        height:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?35: 45:70,
        decoration: BoxDecoration(
            color: Color(0xff05ac54),
            border: Border.all(
              color: Color(0xff05ac54),

            ),

            borderRadius:BorderRadius.all(Radius.circular(8))




        ),
        child: TextButton(onPressed: () {



          // addToCart(data[index].productId);

          double totalpricefullcart=0;
          for(int j=0;j<cartItems.length;j++)
          {
            if(cartItems[j].productStock!=null)
            {
              price=double.parse(cartItems[j].productStock.productPrice);
              offerprice=double.parse(cartItems[j].productStock.productOfferPrice);

              int q= int.parse(cartItems[j].quantity);

              if(price!=0&&offerprice!=0) {
                if (price == offerprice) {


                  totalprice=price*q;

                }
                else{

                  totalprice=offerprice*q;


                }
                totalpricefullcart=totalpricefullcart+totalprice;
              }


            }





          }





          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SummaryPage("0",totalpricefullcart,cartItems.length)));




        },
          child: Text(checkout,style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)? 17:26),),





        ),




      ),
      )
    ],


    )



          ),flex: 1, )
        ],
      )






    ),





            flex: 3,






          ):
          Align(
            alignment: FractionalOffset.topCenter,

            child:

            Text("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n  "+nodatafound,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.green)),
          ),
         
        ],


      ),

      ),

    );
  }

  showTutorial()
  {

    SnackBar snackBar=  SnackBar(content: Container(
      //color: Colors.white,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2.0, color: Colors.black), borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 75),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Swipe the item for deletion'),
      ),
    ), backgroundColor: Colors.transparent, elevation: 1000, behavior: SnackBarBehavior.floating,);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }


  getAllItemsFromCart()async
  {

    cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);

    cartDataProvider.getPostData(context);

    setState(() {
      if(cartDataProvider.post.cartItems.length>0)
      {
        cartItems.clear();

        cartItems.addAll(cartDataProvider.post.cartItems);

        totalpricefullcart=0;
        pricewithoutoffer=0;
        coupondiscount=0;
        totalofferpercentage=0;
        for(int j=0;j<cartItems.length;j++)
        {
          if(cartItems[j].productStock!=null)
          {
            price=double.parse(cartItems[j].productStock.productPrice);
            offerprice=double.parse(cartItems[j].productStock.productOfferPrice);

            int q= int.parse(cartItems[j].quantity);

            if(price!=0&&offerprice!=0) {


              if (price == offerprice) {


                totalprice=price*q;

              }
              else{

                totalprice=offerprice*q;

                offerpercent=((price-offerprice)/price)*100;
                totalofferpercentage=totalofferpercentage+offerpercent;
              }

              pricewithoutoffer=pricewithoutoffer+(price*q);

              totalpricefullcart=totalpricefullcart+totalprice;
            }


          }





        }

      }
    });


  }

  increaseQty(int id) async{



    cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);

    String response=await cartDataProvider.increaseQtyCart(context, id.toString());

    if(response.isNotEmpty)
    {




      Map body = json.decode(response);

      if(body!=null) {

        if(body.containsKey("message")) {


          getAllItemsFromCart();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                body["message"]),
          ));
          print(body["message"]);
        }
      }




    }






  }


  decreaseQty(int id) async{


    cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);


    String response=await cartDataProvider.decreaseQtyCart(context, id.toString());

    if(response.isNotEmpty)
    {




      Map body = json.decode(response);

      if(body!=null) {

        if(body.containsKey("message")) {


          getAllItemsFromCart();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                body["message"]),
          ));
          print(body["message"]);
        }
      }




    }






  }

  deleteProductFromCart(int id,int i) async{


    cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);


    String response=await cartDataProvider.getDeletedData(context, id.toString());

    if(response.isNotEmpty)
    {




      Map body = json.decode(response);

      if(body!=null) {

        if(body.containsKey("message")) {



          if(cartItems.length==1)
            {
              clearProductFromCart();
            }
          else {
            getAllItemsFromCart();
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                body["message"]),
          ));
          print(body["message"]);
        }
      }




    }






  }


  clearProductFromCart() async{


    cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);


    String response=await cartDataProvider.clearCartData(context);

    if(response.isNotEmpty)
    {




      Map body = json.decode(response);

      if(body!=null) {

        if(body.containsKey("message")) {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                body["message"]),
          ));
          print(body["message"]);



          setState(() {


            cartDataProvider.post.cartItems.clear();
            cartItems.clear();
          });


          // getAllItemsFromCart();


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

        mycart=lde['mycart_en'];
        clearall=lde['clearall_en'];
        checkout=lde['checkout_en'];
        delete=lde['delete_en'];
        items=lde['items_en'];
        clearmsg=lde['clearmsg_cart_en'];
        deletemsg=lde['deleteitem_cart_en'];
        yes=lde['yes_en'];
        no=lde['No_en'];
        kenz=lde['kenz_food_en'];
        totalamount=lde['Total_amount_en'];
        nodatafound=lde['nodatafound_en'];
        totalpricetext=lde['TotalPrice_en'];
        discountamt=lde['discount_en'];
        payable=lde['total_en'];



      }
      else {

        language=currentlanguage;

        mycart=lde['mycart_ar'];
        clearall=lde['clearall_ar'];
        checkout=lde['checkout_ar'];
        delete=lde['delete_ar'];
        items=lde['items_ar'];
        clearmsg=lde['clearmsg_cart_ar'];
        deletemsg=lde['deleteitem_cart_ar'];
        yes=lde['Yes_ar'];
        no=lde['No_ar'];
        kenz=lde['kenz_food_ar'];
        totalamount=lde['Total_amount_ar'];
        nodatafound=lde['nodatafound_ar'];

        totalpricetext=lde['TotalPrice_ar'];
        discountamt=lde['discount_ar'];
        payable=lde['total_ar'];
      }
    });







  }
}
