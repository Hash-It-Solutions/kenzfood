import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../dataproviders/CartDataProvider.dart';
import '../dataproviders/ProductListBySubCategoryProvider.dart';
import '../dataproviders/ProductStockProvider.dart';
import '../dataproviders/WishlistProvider.dart';
import '../models/productlist_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../utils/ServerConstants.dart';
import 'my_product_details_page.dart';

class Productlisttab extends StatefulWidget {

 final String subcategoryid;
 final String cat_id;

   Productlisttab(this.subcategoryid,this.cat_id) ;

  @override
  _ProductlisttabState createState() => _ProductlisttabState(subcategoryid,cat_id);
}

class _ProductlisttabState extends State<Productlisttab> {

  late String subcategoryid,cat_id;

  late ProductlistEntity ple;
 late ProductListBySubCategoryProvider productListProvider;
 late ProductStockProvider productStockProvider;
  late CartDataProvider cartDataProvider;

  _ProductlisttabState(this.subcategoryid,this.cat_id);

  // List<ProductlistProducts>lsp=[];

  String language="en",addtocart="Add to Cart";

  bool isnormaldelivery=true,isfastdelivery=false;
  String normaldelivery="",fastdelivery="";

  int cartqty=1;

  @override
  void initState() {

    productListProvider = Provider.of<ProductListBySubCategoryProvider>(context, listen: false);

    cartDataProvider = Provider.of<CartDataProvider>(context, listen: false);

    super.initState();

     checkLanguage();
     getProducts();

  }

  List<ProductlistProducts> products=[];

  @override
  Widget build(BuildContext context) {

    checkLanguage();

    productListProvider = Provider.of<ProductListBySubCategoryProvider>(context);



    return
     Stack(

      children: [


        Align(
          alignment: FractionalOffset.topCenter,

          child: Row(

            children: [

              Expanded(child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:15:20),


    child:Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:  (isnormaldelivery)?  Color(0xff01713D) :Colors.green[100],
      ),
      height: ResponsiveInfo.isMobile(context)?55:ResponsiveInfo.isSmallMobile(context)?50:60,
      width: ResponsiveInfo.isMobile(context)?175:ResponsiveInfo.isSmallMobile(context)?160:190,
      child: TextButton(
          onPressed: () async {


            setState(() {
              isnormaldelivery=true;
              isfastdelivery=false;
            });


            getProducts();


          }
          ,
          child: Text(
            normaldelivery,
            style:  TextStyle(
                color: (isnormaldelivery)?  Colors.white : Colors.black45,
                fontFamily: 'poppins',
                fontSize: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?13:18

            ),
          )),
    ) ,


          )



              ,flex: 1),
              Expanded(child:

              Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?10:15:20),


    child:Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:(isfastdelivery)?  Color(0xff01713D) :Colors.green[100],
      ),
      height: ResponsiveInfo.isMobile(context)?55:ResponsiveInfo.isSmallMobile(context)?50:60,
      width: ResponsiveInfo.isMobile(context)?175:ResponsiveInfo.isSmallMobile(context)?160:190,
      child: TextButton(
          onPressed: () async {


            setState(() {
              isnormaldelivery=false;
              isfastdelivery=true;
            });

            getProducts();

          }
          ,
          child: Text(
            fastdelivery,
            style:  TextStyle(
                color:(isfastdelivery)?  Colors.white : Colors.black45,
                fontFamily: 'poppins',
                fontSize: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?13:18

            ),
          )),
    ),


    ),



              flex: 1,),







            ],


          ),



        ),


        (productListProvider.post.products.length>0)?  Align(

          alignment: FractionalOffset.topCenter,

          child: Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?70:85:110),

            child: GridView.builder(

              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:productListProvider.post.products.length,
              itemBuilder: (BuildContext context, int index) {

                double price=0,offerprice=0,offerpercent=0;
                bool ispricesame=false;

                String url="";

                if(productListProvider.post.products[index].productStock.length>0)
                {

                  try {
                    price = double.parse(productListProvider.post.products[index].productStock[0].productPrice);
                    offerprice =
                        double.parse(productListProvider.post.products[index].productStock[0].productOfferPrice);

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

                if(productListProvider.post.products[index].productImages.length>0)
                {

                  url=productListProvider.post.products[index].productImages[0].productImageUrl;

                }

                if (productListProvider.post.products[index].productStock.length > 0) {
                  price = double.parse(
                      productListProvider.post.products[index].productStock[0]
                          .productPrice);
                  offerprice = double.parse(
                      productListProvider.post.products[index].productStock[0]
                          .productOfferPrice);


                  if (price != 0 && offerprice != 0) {
                    if (price == offerprice) {
                      ispricesame = true;
                      productListProvider.post.products[index].ispricesame = ispricesame;
                    }
                    else {
                      ispricesame = false;
                      productListProvider.post.products[index].ispricesame = ispricesame;
                      offerpercent=((price-offerprice)/price)*100;

                    }
                  }
                }

                return





                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                              backgroundColor: Colors.transparent,

                              content:MyProductDetailsPage(productListProvider.post.products[index].id,1,productListProvider.post.products[index])



                          ),
                        );
                      },

                      child: Stack(

                        children: [
                          Stack(


                            children: [

                              Align(

                                child:Card(
                                  color: Color(0xffF1F1F1),

                                  child: Container(
                                    width: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                        .isSmallMobile(context) ? 180 : 195 : 220,
                                    height: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                        .isSmallMobile(context) ? 200 : 215 : 250,
                                    child: Column(

                                      children: [
                                        Padding(padding:
                                        ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                            .isSmallMobile(context) ? EdgeInsets.only(top: 20) :
                                        EdgeInsets.only(top: 25) :
                                        EdgeInsets.only(top: 30),

                                            child: Container(

                                              child:
                                              Image.network(url, width: ResponsiveInfo.isMobile(context)
                                                  ? ResponsiveInfo.isSmallMobile(context)
                                                  ? 65
                                                  : 75
                                                  : 80,
                                                  height: ResponsiveInfo.isMobile(context)
                                                      ? ResponsiveInfo.isSmallMobile(context)
                                                      ? 65
                                                      : 75
                                                      : 80,
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (BuildContext context,
                                                      Object exception, StackTrace? stackTrace) {
                                                    return Image.asset(
                                                        "images/pi.png", width: double.infinity,
                                                        height: ResponsiveInfo.isMobile(context)
                                                            ? ResponsiveInfo.isSmallMobile(context)
                                                            ? 65
                                                            : 75
                                                            : 80,
                                                        fit: BoxFit.fill
                                                    );
                                                  }
                                              ),
                                            )),

                                        Padding(padding:
                                        ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                            .isSmallMobile(context) ? EdgeInsets.all(5) :
                                        EdgeInsets.all(8) :
                                        EdgeInsets.all(13),

                                          child: Text(

                                            (language.compareTo("en") == 0) ? productListProvider.post.products[index].productNameEn :
                                            productListProvider.post.products[index].productNameAr
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




                                        Padding(padding:EdgeInsets.only(left:ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                            .isSmallMobile(context) ?10:13:17,

                                          right: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                              .isSmallMobile(context) ?10:13:17,

                                          top: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                              .isSmallMobile(context) ?5:8:12,

                                        ),

                                            child:





                                            GestureDetector(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: [

                                                  Expanded(child: (ispricesame) ? Padding(padding:
                                                  ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                                      .isSmallMobile(context) ? EdgeInsets.all(3) :
                                                  EdgeInsets.all(5) :
                                                  EdgeInsets.all(8),

                                                    child: Text(
                                                      price.toString() + " Qr",
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(

                                                          fontFamily: 'poppins',
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: ResponsiveInfo.isMobile(context)
                                                              ? ResponsiveInfo.isSmallMobile(context) ? 12 : 13
                                                              : 18,

                                                          color: Color(0xff01713D)),
                                                    ),


                                                  ) : Padding(padding:
                                                  ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                                      .isSmallMobile(context) ? EdgeInsets.all(3) :
                                                  EdgeInsets.all(5) :
                                                  EdgeInsets.all(8),

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
                                                                    ? 12
                                                                    : 13
                                                                    : 18,


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
                                                                    ? 12
                                                                    : 13
                                                                    : 18,

                                                                color: Color(0xff01713D)),
                                                          ),

                                                        ],


                                                      )


                                                  ),flex: 3,)

                                                  ,

                                                  Expanded(child: Container(
                                                    decoration: BoxDecoration(

                                                        color: Color(0xff01713D),
                                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                                    ),


                                                    width: ResponsiveInfo.isMobile(context)
                                                        ? ResponsiveInfo.isSmallMobile(context) ?25:28:33,
                                                    height: ResponsiveInfo.isMobile(context)
                                                        ? ResponsiveInfo.isSmallMobile(context) ?25:28:33,

                                                    child: Padding(

                                                      padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                                          ? ResponsiveInfo.isSmallMobile(context) ?3:5:7),
                                                      child: Icon(Icons.add,size: 15,color: Colors.white,),

                                                    ),



                                                  ),flex: 1,)






                                                ],

                                              ),

                                              onTap: (){

                                                addToCart(productListProvider.post.products[index].id,1,productListProvider.post.products[index]);
                                              },
                                            )



                                        )




                                      ],
                                    ),


                                  ),


                                ),
                                alignment: FractionalOffset.center,
                              ),

                              Align(
                                  alignment: FractionalOffset.topLeft,
                                  child:SizedBox(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        GestureDetector(

                                          child:  Container(
                                            margin: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)
                                                ? ResponsiveInfo.isSmallMobile(context)
                                                ?15:22:28,left:ResponsiveInfo.isMobile(context)
                                                ? ResponsiveInfo.isSmallMobile(context)
                                                ?10:15:20 ),

                                            child: Icon(Icons.favorite_outline,color: ( productListProvider.post.products[index].inWishlist)?Colors.red:Colors.black,size:ResponsiveInfo.isMobile(context)
                                                ? ResponsiveInfo.isSmallMobile(context)
                                                ?20:23:28 ,),


                                          ) ,

                                          onTap: () async {

                                            if(!productListProvider.post.products[index].inWishlist)
                                            {

                                              WishlistDataProvider   wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);


                                              String response=await  wishlistDataProvider.addWishlist(context, productListProvider.post.products[index].id.toString());

                                              if(response.isNotEmpty)
                                              {




                                                Map body = json.decode(response);

                                                if(body!=null) {

                                                  if(body.containsKey("message")) {

                                                    setState(() {


                                                      productListProvider.post.products[index].inWishlist=true;
                                                 ProductlistProducts p=     productListProvider.post.products[index];


                                                     productListProvider.post.products.removeAt(index);
                                                     productListProvider.post.products.add(p);

                                                      //  getLikeProducts();

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

                                              WishlistDataProvider     wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);

                                              String response=await  wishlistDataProvider.remove(context, productListProvider.post.products[index].id.toString());

                                              if(response.isNotEmpty)
                                              {




                                                Map body = json.decode(response);

                                                if(body!=null) {

                                                  if(body.containsKey("message")) {

                                                    setState(() {


                                                      productListProvider.post.products[index].inWishlist=false;
                                                      //   getLikeProducts();

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





                                        ,

                                        (!ispricesame)?
                                        Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)
                                            ? ResponsiveInfo.isSmallMobile(context)
                                            ?13:18:20,right:ResponsiveInfo.isMobile(context)
                                            ? ResponsiveInfo.isSmallMobile(context)
                                            ?3:5:8 ),

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
                                                  ?9:11:13, fontFamily: 'Poppins' ),) ,


                                            )

                                            ,


                                          ) ,



                                        )

                                            :Container()
                                      ],
                                    ),
                                    width: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                        .isSmallMobile(context) ? 180 : 195 : 220,
                                  )





                              ),

                              // Align(
                              //   alignment: FractionalOffset.topRight,
                              //   child: ,
                              //
                              // ),





                            ],
                          )

                        ],
                      )







                  )





                ;









              },   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.3,
                mainAxisSpacing: 0.3,
                childAspectRatio: 0.76
            ),),



          ),

        ) :

        Stack(

          children: [

            Align(
              alignment: FractionalOffset.center,

              child:        CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 5,

              ),

            )
          ],
        )




      ],


    )
    ;



  }





  getProducts()async
  {

    String normalfast="";

    if(isnormaldelivery)
      {
        normalfast="normal";
      }
    else if (isfastdelivery) {

      normalfast="fast";
    }


   productListProvider.getPostDatabyDeliverytype(context,cat_id,ServerConstants.subcategoryidparam,normalfast,subcategoryid);



    // setState(() {
    //   if(post.products.length>0)
    //   {
    //
    //     lsp.clear();
    //
    //     for(int i=0;i<post.products.length;i++)
    //     {
    //
    //       if(post.products[i].status.toString().compareTo("enable")==0)
    //       {
    //
    //         lsp.add(post.products[i]);
    //       }
    //
    //
    //
    //     }
    //
    //
    //
    //
    //
    //
    //   }
    //   else{
    //
    //     lsp.clear();
    //   }
    // });

  }



  checkLanguage()async
  {

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();

    language=currentlanguage;

    if (currentlanguage.compareTo("en") == 0) {

      language=currentlanguage;

      addtocart=lde['addtocart_en'];
      normaldelivery=lde['Normaldelivery_en'];
      fastdelivery=lde['Fastdelivery_en'];



    }
    else {

      addtocart=lde['addtocart_Ar'];

      normaldelivery=lde['Normaldelivery_Ar'];
      fastdelivery=lde['Fastdelivery_Ar'];
    }





  }

  addToCart(int id,int qty, ProductlistProducts productlistProducts) async{
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

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.transparent,

        content:MyProductDetailsPage(id,qty,productlistProducts)



      ),
    );














    // Map<String,String>mp=new Map();
    // mp['quantity']=qty.toString();
    //
    // var body = json.encode(mp);
    //
    //
    // String response=await cartDataProvider.addtoCart(context, id.toString(), body);
    //
    // if(response.isNotEmpty)
    // {
    //
    //
    //
    //
    //   Map body = json.decode(response);
    //
    //   if(body!=null) {
    //
    //     if(body.containsKey("message")) {
    //       // setState(() {
    //       //   iswishlist=true;
    //       // });
    //
    //
    //
    //
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text(
    //             body["message"]),
    //       ));
    //       print(body["message"]);
    //     }
    //   }
    //
    //
    //
    //
    // }






  }


}
