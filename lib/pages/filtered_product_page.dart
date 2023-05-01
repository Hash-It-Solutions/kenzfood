import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../dataproviders/CartDataProvider.dart';
import '../dataproviders/NormalFastProductProvider.dart';
import '../models/productlist_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import 'my_product_details_page.dart';

class FilteredProductPage extends StatefulWidget {

  int code=0;

   FilteredProductPage(this.code) ;

  @override
  _FilteredProductPageState createState() => _FilteredProductPageState(code);
}

class _FilteredProductPageState extends State<FilteredProductPage> {

  int co=0;

  _FilteredProductPageState(this.co);



  String language="",normaldelivery="",fastdelivery="",title="",addtoCart="";
  late NormalFastProductProvider normalFastProductProvider;
  late CartDataProvider cartDataProvider;
  List<ProductlistProducts> lsp=[];

  @override
  void initState() {
    // TODO: implement initState
    checkLanguage();
    super.initState();
    normalFastProductProvider=Provider.of<NormalFastProductProvider>(context, listen: false);
    cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);

    getProducts();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        resizeToAvoidBottomInset: true,

        appBar:  AppBar(
        backgroundColor: Color(0xff05ac54),
    elevation: 0,
    leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.pop(context),
    ),
    title: Text(title,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25),),
    centerTitle: false,
    ),

      body: Container(

        width: double.infinity,
        height: double.infinity,

        child: Stack(

          children: [


            (lsp.length>0)?  GridView.builder(

              physics:  AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,

              itemCount:lsp.length,
              itemBuilder: (BuildContext context, int index) {

                double price=0,offerprice=0;
                bool ispricesame=false;

                String url="";

                if(lsp[index].productStock.length>0)
                {
                  price=double.parse(lsp[index].productStock[0].productPrice);
                  offerprice=double.parse(lsp[index].productStock[0].productOfferPrice);

                  if(price!=0&&offerprice!=0) {
                    if (price == offerprice) {
                      ispricesame=true;
                    }
                    else{

                      ispricesame=false;
                    }
                  }


                }

                if(lsp[index].productImages.length>0)
                {

                  url=lsp[index].productImages[0].productImageUrl;

                }



                return


                  GestureDetector(

                      onTap: (){


                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (_) => ProductDetailsPage(lsp[index],lsp[index].catId.toString())));


                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                              backgroundColor: Colors.transparent,

                              content:MyProductDetailsPage(lsp[index].id,1,lsp[index])



                          ),
                        );
                      },


                      child:Container(

                          width: double.infinity,

                          child:  Card(
                              elevation: 3,


                              child:  Container(

                                width: double.infinity,
                                height: 600,


                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(padding:
                                    ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5) :
                                    EdgeInsets.all(9):
                                    EdgeInsets.all(15),

                                        child:  Container(

                                          child:
                                          Image.network(url,width: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 60:80:110, height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 60:80:110,fit: BoxFit.fill,errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return Image.asset(
                                                "images/pi.png", width: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 60:80:110, height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 60:80:110, fit: BoxFit.fill
                                            );
                                          }
                                          ) ,
                                        )),



                                    Padding(padding:
                                    ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(3) :
                                    EdgeInsets.all(5):
                                    EdgeInsets.all(8),

                                      child: Text(

                                        (language.compareTo("en")==0)?  lsp[index].productNameEn :
                                        lsp[index].productNameAr
                                        ,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(

                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.normal,
                                            fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?12:13:18 ,

                                            color:  Colors.black),
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






                                    ) ,







                                    Padding(

                                      padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?EdgeInsets.all(3) :
                                      EdgeInsets.all(5):
                                      EdgeInsets.all(8),
                                      child: (!lsp[index].isaddedcart)?  Container(


                                          height:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 50:65:80,
                                          decoration: BoxDecoration(
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


                                            TextButton(onPressed: () {


                                              addToCart(lsp[index].id);









                                            },
                                              child: Text(addtoCart,style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)? 13:16),),





                                            ),)




                                      ) : Text(addtoCart,style: TextStyle(color: Colors.green,fontSize:ResponsiveInfo.isMobile(context)? 13:16),),
                                    )
                                  ],
                                ) ,

                              ))



                      )



                  );









              },   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.3,
              mainAxisSpacing: 0.3,
              childAspectRatio:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 0.85:0.7:0.63,

            ),) :

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

            ,


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
        normaldelivery=lde['Normaldelivery_en'];
        fastdelivery=lde['Fastdelivery_en'];
        addtoCart=lde['addtocart_en'];

      }
      else {

        language=currentlanguage;

        normaldelivery=lde['Normaldelivery_Ar'];
        fastdelivery=lde['Fastdelivery_Ar'];
        addtoCart=lde['addtocart_Ar'];


      }

      if(co==0)
        {
          title=normaldelivery;

        }
      else{

        title=fastdelivery;

      }




    });







  }


  getProducts()async
  {

    if(co==0)
      {

        String data=await normalFastProductProvider.getNormalData(context);

        var a= jsonDecode(data);

        ProductlistEntity ple=ProductlistEntity.fromJson(a);

        setState(() {

          for(int i=0;i<ple.products.length;i++) {

            if(ple.products[i].status.toString().compareTo("enable")==0) {
              lsp.add(ple.products[i]);
            }
          }



        });

      }
    else{

      String data=await normalFastProductProvider.getFastData(context);

      var a= jsonDecode(data);

      ProductlistEntity ple=ProductlistEntity.fromJson(a);

      setState(() {
        for(int i=0;i<ple.products.length;i++) {

          if(ple.products[i].status.toString().compareTo("enable")==0) {
            lsp.add(ple.products[i]);
          }
        }



      });


    }


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
}
