import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';


import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../databasehelper/DatabaseHelper.dart';
import '../databasehelper/DatabaseTables.dart';
import '../dataproviders/CartDataProvider.dart';

import '../dataproviders/ProductImageProvider.dart';
import '../dataproviders/ProductListByCategoryProvider.dart';
import '../dataproviders/ProductStockProvider.dart';

import '../dataproviders/WishlistProvider.dart';
import '../models/productlist_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../utils/ServerConstants.dart';
import 'package:page_indicator/page_indicator.dart';

import 'homescreen.dart';
import 'my_product_details_page.dart';

class ProductDetailsPage extends StatefulWidget {

  final ProductlistProducts product;

  final String categoryid;


   ProductDetailsPage(this.product, this.categoryid) ;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState(product,categoryid);
}







class _ProductDetailsPageState extends State<ProductDetailsPage> {


  ProductlistProducts product;

  late String categoryid;

  late ProductImageProvider productimageListProvider;
  late ProductStockProvider productStockProvider;
  late ProductListByCategoryProvider productListProvider;
  late CartDataProvider cartDataProvider;

  late WishlistDataProvider wishlistDataProvider;

  List<Widget> nsdwidget = [];


  List<ProductlistProducts>lsp=[];

  _ProductDetailsPageState(this.product,this.categoryid);

  List<ProductlistProducts> products=[];


    String language="en",addtocart="Add to Cart",price="Price",moreinfo="More Info",buynow="Buy Now",youmaylike="You May Like";

  int cartcount=0;
  @override
  void initState() {
    // TODO: implement initState
    checkLanguage();


    super.initState();
    wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);

    productimageListProvider = Provider.of<ProductImageProvider>(context, listen: false);
    productStockProvider=Provider.of<ProductStockProvider>(context, listen: false);
    productListProvider = Provider.of<ProductListByCategoryProvider>(context, listen: false);

    cartDataProvider = Provider.of<CartDataProvider>(context, listen: false);




    productStockProvider.getPostData(context, product.id.toString());
    productimageListProvider.getPostData(context, product.id.toString());



    checkWishList(product.id.toString());

    addToHistory(product);
    getCart();
    getCategoryProduct();
  }

  bool iswishlist=false;

  int qty=1;
  List<ProductlistProducts> products_similar=[];
  double productprice = 0,
      offerprice = 0;

  @override
  Widget build(BuildContext context) {

    productimageListProvider = Provider.of<ProductImageProvider>(context);

    productStockProvider = Provider.of<ProductStockProvider>(context);

    productListProvider=Provider.of<ProductListByCategoryProvider>(context);

    double  height= (MediaQuery.of(context).size.height);
    double  width= (MediaQuery.of(context).size.width);

    Size screenSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;



    for (var i = 0; i < product.productImages.length; i++) {
      nsdwidget.add(Container(
        height: (MediaQuery.of(context).size.width) / 1.89349112,
        width: double.infinity,
        child: Card(
            child:
            Image.network(product.productImages[i].productImageUrl,fit: BoxFit.fill,

                errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image.asset(
                      "images/pi.png",  fit: BoxFit.fill
                  );
                }

            )),
      ));
    }

    Widget getNetWorkWidget(int p) {
      return nsdwidget[p];
    }

    if( product.productImages.length>0)
      {
        print("Product Image : "+product.productImages[0].productImageUrl);
      }
    else{
      print("Product Image : No data");

    }

    if(productStockProvider.post.productStocks.length>0) {
      String pro_price = productStockProvider.post.productStocks[0]
          .productPrice;
      String offer_frice = productStockProvider.post.productStocks[0]
          .productOfferPrice;



      if (pro_price.isNotEmpty && offer_frice.isNotEmpty) {
        productprice = double.parse(pro_price);
        offerprice = double.parse(offer_frice);
      }
    }


    return
      Scaffold(

        resizeToAvoidBottomInset: true,

        appBar:  AppBar(
          backgroundColor: Color(0xffffffff),
          elevation: 5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.green,size: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?20:25:30,),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text((language.compareTo("en")==0)?product.productNameEn:product.productNameAr,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Colors.black),),
          centerTitle: false,
          actions: [

            Container(

              width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?45:60:75,
              height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?45:60:75,

              child: Stack(
                children: [

                  Align(

                    alignment: FractionalOffset.center,

                    child:  IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.black38,size:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?20:25:30),
                      onPressed: () =>         Navigator.of(context).pushReplacement(
                        PageTransition(
                          child:  Homescreen(1),
                          type: PageTransitionType.leftToRightWithFade,
                        ),
                      ),
                    ),

                  ),

                  (cartcount>0)?  Align(
                      alignment: FractionalOffset.center,
                      child: GestureDetector(

                        child:     Padding(

                          padding: EdgeInsets.only(bottom:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 10 :13:17, left:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 3 :4:5 ),
                          child: Container(
                            // margin: EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:20:25),
                            width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?35:45:60,
                            height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?35:45:60,


                            child: Text(cartcount.toString(),textAlign: TextAlign.center,  style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 13:16:19,color: Colors.redAccent,fontWeight: FontWeight.bold),


                            ),
                          ),



                        ),

                        onTap: (){

                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              child:  Homescreen(1),
                              type: PageTransitionType.leftToRightWithFade,
                            ),
                          );


                        },
                      )

                  ) :Container()

                ],

              ),
            )



          ],



        ),


        body: Container(
          color: Colors.white60,

            child:

            Column(

              children: [

                Expanded(



                  child: SingleChildScrollView(


                    child:     Column(

                      children: [



                        Stack(


                          children: [


                            Align(
                              alignment: FractionalOffset.topCenter,

                              child:( product.productImages.length>0)?

                              Container(
                                  height: (MediaQuery.of(context).size.width) / 1.89349112,
                                  width: double.infinity,

                                  child:PageIndicatorContainer(
                                      length: product.productImages.length,
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
                                          return getNetWorkWidget(index);
                                        },
                                        itemCount: product.productImages.length,
                                        // children: nsdwidget,
                                      )))


                                  : Container(
                                height: (MediaQuery.of(context).size.width) / 1.89349112,
                                width: double.infinity,
                                child: Image.asset(
                                    "images/pi.png", width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width), height: (MediaQuery
                                    .of(context)
                                    .size
                                    .width) / 1.89349112, fit: BoxFit.fill
                                ) ,



                              ),



                            ),

                            Align(
                                alignment: FractionalOffset.topRight,

                                child: (!iswishlist)?


                                Padding(

                                    padding: ResponsiveInfo.isMobile(context)?EdgeInsets.all(5):EdgeInsets.all(11),
                                    child:

                                        GestureDetector(

                                          onTap: (){


addToWishList(product.id.toString());
                                          },
                                          child:  Container(
                                              decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    color: Colors.black,

                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              child:  Padding(

                                                  padding: ResponsiveInfo.isMobile(context)?EdgeInsets.all(5):EdgeInsets.all(11),

                                                  child:



                                                  Icon( Icons.favorite,
                                                    color:Colors.white,

                                                    size:ResponsiveInfo.isMobile(context)? 24.0:36.0,)


                                              )
                                          ) ,
                                        )


                                )


                                    :

                                Padding(

                                    padding: ResponsiveInfo.isMobile(context)?EdgeInsets.all(5):EdgeInsets.all(11),
                                    child:
                                    GestureDetector(

                                        onTap: (){

                                          removeFromWishList(product.id.toString());

                                        },
                                        child:


                                    Container(
                                        decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                            color: Colors.black,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        child:  Padding(

                                            padding: ResponsiveInfo.isMobile(context)?EdgeInsets.all(5):EdgeInsets.all(11),

                                            child:



                                            Icon( Icons.favorite,
                                              color:Colors.redAccent,

                                              size:ResponsiveInfo.isMobile(context)? 24.0:36.0,)


                                        )
                                    ))
                                )

                            )



                          ],


                        ),

                        (productStockProvider.post.productStocks.length>0)? Card(

                            child: Container(

                              width: double.infinity,


                              child: Column(

                                children: [

                                  Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),

                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Expanded(child: Text(price,style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:17),),flex: 1,),

                                        Expanded(child: Text(":",style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:17),),flex: 1,)
                                        ,

                                        (productprice!=offerprice)?   Expanded(child: Row(

                                          children: [

                                            Expanded(child: Text(productStockProvider.post.productStocks[0].productPrice+" Qr",style: TextStyle( decoration: TextDecoration.lineThrough,color: Colors.black38,fontSize:ResponsiveInfo.isMobile(context)?13:17),),flex: 1,),

                                            Expanded(child: Text(productStockProvider.post.productStocks[0].productOfferPrice+" Qr",style: TextStyle( color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)?13:17),),flex: 1,),

                                          ],

                                        )




                                          ,flex: 1,) :    Expanded(child: Text(productStockProvider.post.productStocks[0].productPrice+" Qr",style: TextStyle( color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)?13:17),),flex: 1,),


                                      ],


                                    ),
                                  ),



                                  Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),

                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        // Expanded(child: Text(moreinfo,style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:17),),flex: 1,),
                                        //
                                        // Expanded(child: Text(":",style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 17:26),),flex: 1,)
                                        // ,

                                        Expanded(child: Text((language.compareTo("en") == 0)?product.productDescEn : product.productDescAr,style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 13:17),maxLines: 10,)




                                          ,flex: 1,)

                                      ],


                                    ),
                                  ),

                                  Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),

                                      child:
                                  Container(

                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xff3d3b3a),
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)?15:30))
                                    ),
                                    child: SizedBox(
                                      width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?140:165:190,
                                      height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?55:65:80,
                                      child:     Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(onPressed: () {

                                            int q=qty;

                                            if(q>1) {
                                              int a = q - 1;

                                              setState(() {
                                                qty=a;
                                              });


                                              // changeQty(i,a);
                                              // checkStockAvailability(int.parse(lcart[i].stockid), a, i,int.parse(lcart[i].cartid),lcart[i].shopId,lcart[i].productid);



                                            }


                                          },
                                            child: Text("-",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.black),),
                                          ),
                                          Text(qty.toString(),style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Color(0xff05ac54)),),
                                          TextButton(onPressed: () {
                                            int q=qty;
                                            int a = q + 1;
                                            setState(() {
                                              qty=a;
                                            });
                                            // // changeQty(i,a);
                                            // checkStockAvailability(int.parse(lcart[i].stockid), a, i,int.parse(lcart[i].cartid),lcart[i].shopId,lcart[i].productid);

                                          },
                                            child: Text("+",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.black),),
                                          ),
                                        ],
                                      ),
                                    )



                                  ) ),

                            Padding(padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),

                              child:
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [


                                      Padding(padding:ResponsiveInfo.isMobile(context)? EdgeInsets.fromLTRB(0, 10, 10, 10):EdgeInsets.fromLTRB(0, 20, 20, 20),
                                          child:  Container(

                                            width:ResponsiveInfo.isMobile(context)? 200:260,
                                            height:ResponsiveInfo.isMobile(context)? 50:90,
                                            decoration: BoxDecoration(
                                                color: Color(0xff05ac54),
                                                border: Border.all(
                                                  color: Color(0xff05ac54),
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)?20:40))


                                            ),
                                            child: TextButton(onPressed: () {


                                              addToCart(product.id,qty);

                                              // Navigator.pushReplacement(context, MaterialPageRoute(
                                              //     builder: (context) => MyHomePage(title: "Signup",)
                                              // )
                                              // );

                                              //  checkStockAvailability(0);


                                            },
                                              child: Text(addtocart,style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)? 13:16),),





                                            ),




                                          )),
                                    ],


                                  ))





                                ],


                              ),




                            ),




                          ) :

                          Card(

                            child: Container(

                              width: width,
                              height: width/1.896,

                            ),
                          )




                ,

                        (lsp.length>0) ?   Padding( padding:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8) : EdgeInsets.all(12): EdgeInsets.all(17),

          child:Text(youmaylike,textAlign : TextAlign.start,style: TextStyle(color: Colors.black,fontSize:ResponsiveInfo.isMobile(context)? 16:22),),) : Container(),






                        (lsp.length>0) ?   Container(

                              height:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?  340:395:455,
                              child: ListView(
                                scrollDirection: Axis.horizontal,

                                children: List.generate(
                                  lsp.length,
                                      (i) => GestureDetector(
                                    child:Padding(padding: ResponsiveInfo.isMobile(context)? EdgeInsets.all(5):EdgeInsets.all(15),

                                        child:



                                                Card(
                                                  elevation: 4,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),



                                                  child:Container(
                                                    height:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 250:280:340 ,
                                                    width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 210:250:300 ,


                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                            child:  (lsp[i].productImages.length>0)?Image.network(lsp[i].productImages[0].productImageUrl,
                                                                  width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?100:130:160,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?100:130:160,
                                                                  errorBuilder:
                                                                      (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                    return

                                                                      ClipOval(
                                                                          child:  Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 70:90:120 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 70:90:120,
                                                                          ) );
                                                                  },
                                                                ): Image.asset("images/pi.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 70:90:120 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 70:90:120,

                                                    )










                                                        ),

                                                        SizedBox(


                                                          child: Padding(
                                                            padding:ResponsiveInfo.isMobile(context)? EdgeInsets.all(3):EdgeInsets.all(8),

                                                            child: Text((language.compareTo("en")==0)?lsp[i].productNameEn : lsp[i].productNameAr,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.black),maxLines: 2,),) ,
                                                          width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?100:130:180 ,
                                                        )
                                                        ,
                                                        (lsp[i].ispricesame)?   Padding(padding:
                                                        ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(3) :
                                                        EdgeInsets.all(5):
                                                        EdgeInsets.all(8),

                                                          child: Text(
                                                            lsp[i].productStock[0].productPrice+" Qr",
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
                                                                  lsp[i].productStock[0].productPrice+" Qr",
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
                                                                  "  "+ lsp[i].productStock[0].productOfferPrice.toString()+" Qr",
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


                                                      ],
                                                    ),


                                                  )






                                                  ,



                                                )











                                    ),
                                    onTap: (){
                                      // Navigator.pushReplacement(
                                      //     context, MaterialPageRoute(builder: (_) => ProductDetailsPage(lsp[i],lsp[i].catId.toString())));



                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                            backgroundColor: Colors.transparent,

                                            content:MyProductDetailsPage(lsp[i].id,1,lsp[i])



                                        ),
                                      );


                                    },
                                  ),
                                ),
                              )
                          ) : Container(


                        )













                      ],

                    ),
                  ),




                  flex: 4,

                ),



              ],

            )






        ),
      )


      ;
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

  checkLanguage()async
  {

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();



    setState(() {
      language=currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {

        language=currentlanguage;

        addtocart=lde['addtocart_en'];
        price=lde['price_en'];
        moreinfo=lde['Moreinfo_en'];
        buynow=lde['Buynow_en'];
        youmaylike=lde['youmaylike_en'];



      }
      else {

        addtocart=lde['addtocart_Ar'];

        price=lde['price_Ar'];
        moreinfo=lde['Moreinfo_Ar'];
        buynow=lde['Buynow_Ar'];
        youmaylike=lde['youmaylike_Ar'];
      }
    });







  }

  getCart() async
  {

    int c=await cartDataProvider.getCartCountData(context);





    setState(() {
     cartcount=c;
    });





  }

  addToCart(int id,int qty) async{


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

getCart();


          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                body["message"]),
          ));
          print(body["message"]);
        }
      }




    }






  }


  addToWishList(String id) async
  {


    wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);


    String response=await  wishlistDataProvider.addWishlist(context, id);

    if(response.isNotEmpty)
    {




      Map body = json.decode(response);

      if(body!=null) {

        if(body.containsKey("message")) {

          setState(() {


            iswishlist=true;

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


  checkWishList(String id) async
  {


    wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);


    String response=await  wishlistDataProvider.check(context, id);

    if(response.isNotEmpty)
    {




      Map body = json.decode(response);

      if(body!=null) {

        if(body.containsKey("message")) {

          if(body.containsKey("return")) {

            if(body["return"].toString().compareTo("True")==0)
              {

                setState(() {


                  iswishlist=true;

                });

              }
            else{

              setState(() {


                iswishlist=false;

              });

            }


            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(
            //       body["return"]),
            // ));


          }


          // getAllItemsFromCart();

          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(
          //       body["message"]),
          // ));
          print(body["message"]);
        }
      }




    }
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

          setState(() {


            iswishlist=false;

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

  void getCategoryProduct()async {

    ProductlistEntity post=await productListProvider.getSinglePostData(context,product.catId.toString(),ServerConstants.categoryidparam);


    setState(() {

      lsp.clear();

      if(post!=null)
        {
          for(int i=0;i<post.products.length;i++)
          {

            if(post.products[i].status.toString().compareTo("enable")==0)
            {



                double price=0,offerprice=0;
                bool ispricesame=false;

                String url="";

                if(post.products[i].productStock.length>0)
                {
                  price=double.parse(post.products[i].productStock[0].productPrice);
                  offerprice=double.parse(post.products[i].productStock[0].productOfferPrice);

                  if(price!=0&&offerprice!=0) {
                    if (price == offerprice) {
                      ispricesame=true;
                      post.products[i].ispricesame=ispricesame;

                    }
                    else{

                      ispricesame=false;
                      post.products[i].ispricesame=ispricesame;
                    }
                  }


                }

              lsp.add(post.products[i]);
            }



          }
          // lsp.addAll(post.products);
        }

    });

  }
}
