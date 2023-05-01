import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../config/constant.dart';
import '../dataproviders/CartDataProvider.dart';
import '../dataproviders/WishlistProvider.dart';
import '../models/wishlist_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../utils/ServerConstants.dart';
import 'package:http/http.dart' as http;

import 'loginpage.dart';

class Wishlist extends StatefulWidget {
  const Wishlist() : super();

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  late WishlistDataProvider wishlistDataProvider;
  bool iswishlist=false;

  List<WishlistData> data=[];
  double price=0,offerprice=0,offerpercent=0;
  bool ispricesame  =false;
  late CartDataProvider cartDataProvider;

  String language="",clearall="",addtocart="",wishlist="",yes="",no="",wishlistmsg="",kenz="",nodatafound="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    getAllItemsFromwishlist();
    //need to uncomment
    // wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);
    // cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);
    // wishlistDataProvider.getData(context);
  }

  addToCart(int id) async{


    Map<String,String>mp=new Map();
    mp['quantity']="1";

    var body = json.encode(mp);


    String response=await cartDataProvider.addtoCart(context, id.toString(), body);

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
        }
      }




    }






  }


  @override
  Widget build(BuildContext context) {

    cartDataProvider=Provider.of<CartDataProvider>(context);
    // wishlistDataProvider = Provider.of<WishlistDataProvider>(context);
    //
    // wishlistDataProvider.getSinglePostData(context);
    //
    // if(wishlistDataProvider.post.data.length>0)
    // {
    //   data.clear();
    //
    //   data.addAll(wishlistDataProvider.post.data);
    //
    // }
    // else{
    //
    //   data.clear();
    //
    // }




    return Scaffold(

        resizeToAvoidBottomInset: true,



        body: Stack(

          children: [


            SingleChildScrollView(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [


                  (data.length>0)? TextButton(onPressed: (){


                    Widget yesButton = TextButton(
                        child: Text(yes),
                        onPressed: () async {

                          Navigator.pop(context);
                          clearProductFromWishlist();



                        });



                    Widget noButton = TextButton(
                      child: Text(no),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text(kenz),
                      content: Text(wishlistmsg),
                      actions: [yesButton, noButton],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );



                  }, child: Text(clearall,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.green),),
                  ) :Container(),

                  (data.length>0)?


                  MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child:GridView.builder(
                        physics: ScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.3,
                          mainAxisSpacing: 0.3,
                          childAspectRatio: 0.76
                      ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {

                          String imgurl="";

                          if(data[index].productImages.length>0)
                            {

                              imgurl=data[index].productImages[0].productImageUrl;
                            }


                            try {



                              String url="";

                              if(data[index].productStock!=null)
                              {
                                price=double.parse(data[index].productStock.productPrice);
                                offerprice=double.parse(data[index].productStock.productOfferPrice);




                                if(price!=0&&offerprice!=0) {
                                  if (price == offerprice) {
                                    ispricesame=true;
                                  }
                                  else{

                                    ispricesame=false;
                                    offerpercent=((price-offerprice)/price)*100;
                                  }
                                }


                              }

                              data[index].ispricesame=ispricesame;
                            }on Exception catch (_) {
                              // make it explicit that a SocketException will be thrown if the network connection fails
                              rethrow;
                            }







                          return



                            GestureDetector(
                                onTap: () {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (ctx) => AlertDialog(
                                  //       backgroundColor: Colors.transparent,
                                  //
                                  //       content:MyProductDetailsPage(data[index].productId,1,data[index])
                                  //
                                  //
                                  //
                                  //   ),
                                  // );
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
                                                        Image.network(imgurl, width: ResponsiveInfo.isMobile(context)
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

                                                      (language.compareTo("en") == 0) ? data[index].productNameEn :
                                                      data[index].productNameAr
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

                                                          addToCart(data[index].productId);
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

                                                    child:Container(
                                                      margin: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)
                                                          ? ResponsiveInfo.isSmallMobile(context)
                                                          ?15:22:28,left:ResponsiveInfo.isMobile(context)
                                                          ? ResponsiveInfo.isSmallMobile(context)
                                                          ?10:15:20 ),

                                                      child: Icon(Icons.delete,color: Colors.black,size:ResponsiveInfo.isMobile(context)
                                                          ? ResponsiveInfo.isSmallMobile(context)
                                                          ?20:23:28 ,),


                                                    ) ,

                                                    onTap: ()
                                                    {

                                                      removeFromWishList(data[index].productId.toString());

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
                                                            ?10:11:13, fontFamily: 'Poppins' ),) ,


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







                            );
















                        },
                      )) :


                  Text("\n\n\n\n\n\n\n\n\n "+nodatafound,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.green),






                  )

                  ,




                ],
              ),
            )


          ],


        )








    );
  }

  getAllItemsFromwishlist()
  async {


    try {


      String url=ServerConstants.baseurl+ServerConstants.wishlist;

      String apiToken = await getStringValue("token");
      final response = await http.get(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
        // body: requestdata,

      );


      if (response.statusCode == 200) {
        final item = json.decode(response.body);

        print(url);
        print(response.body);

        WishlistEntity   result = WishlistEntity.fromJson(item);

        if(result.data.length>0)
          {
            setState(() {
              data.clear();
              data.addAll(result.data);


            });



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

            getAllItemsFromwishlist();

          }




        }

      }


      else {



      }
    } catch (e) {
      // log(e.toString());
    }

    // wishlistDataProvider.getData(context);
    //
    // wishlistDataProvider = Provider.of<WishlistDataProvider>(context,listen: false);
    //
    // if(wishlistDataProvider.post.data.length>0)
    // {
    //
    //
    //   setState(() {
    //     data.clear();
    //     data.addAll(wishlistDataProvider.post.data);
    //   });
    //
    //
    //
    // }
    // else{
    //
    //   setState(() {
    //     data.clear();
    //
    //   });
    //
    // }
  }


  removeFromWishList(String id) async
  {
    wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);


    String response=await  wishlistDataProvider.remove(context, id);

    if(response.isNotEmpty)
    {




      Map body = json.decode(response);

      if(body!=null) {

        if(body.containsKey("message")) {



          if(wishlistDataProvider.post.data.length==1)
            {

              setState(() {
                wishlistDataProvider.post.data.clear();
                data.clear();
              });
            }


           getAllItemsFromwishlist();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                body["message"]),
          ));
          print(body["message"]);
        }
      }




    }
  }


  clearProductFromWishlist() async{


    wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);


    String response=await wishlistDataProvider.clearWishlist(context);

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

          //  getAllItemsFromCart();

          setState(() {


            wishlistDataProvider.post.data.clear();
            data.clear();
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
        clearall=lde['clearall_en'];
        wishlistmsg=lde['clearwishlistmg_en'];
        addtocart=lde['addtocart_en'];
        yes=lde['yes_en'];
        no=lde['No_en'];
        kenz=lde['kenz_food_en'];
        nodatafound=lde['nodatafound_en'];
        wishlist=lde['Wishlist_en'];

      }
      else {

        language=currentlanguage;
        clearall=lde['clearall_ar'];
        wishlistmsg=lde['clearwishlistmg_ar'];
        addtocart=lde['addtocart_Ar'];
        yes=lde['Yes_ar'];
        no=lde['No_ar'];
        kenz=lde['kenz_food_ar'];
        nodatafound=lde['nodatafound_ar'];
        wishlist=lde['Wishlist_Ar'];


      }
    });







  }
}
