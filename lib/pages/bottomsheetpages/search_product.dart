import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../databasehelper/DatabaseHelper.dart';
import '../../databasehelper/DatabaseTables.dart';
import '../../dataproviders/CategoryDataProvider.dart';
import '../../dataproviders/SearchDataProvider.dart';
import '../../models/category_list_entity.dart';
import '../../models/productlist_entity.dart';
import '../../utils/LanguageValues.dart';
import '../../utils/ResponsiveInfo.dart';
import '../filtered_product_page.dart';
import '../my_product_details_page.dart';
import '../product_details_page.dart';
import '../productlist.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct() : super();

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {


  late SearchProductListProvider searchProductListProvider;
  TextEditingController txtSearch=new TextEditingController();
  String language="",search_hint="",searchword="";
  List<CategoryListCategories> categories=[];
  late CategoryDataProvider categorymodel;

  String normaldelivery="",fastdelivery="",title="",recentlyviewed="",categorieslang="";

  List<Widget>w=[];

  List<ProductlistProducts>productlistproducts=[];

  List<String> suggestons = ["USA", "UK", "Uganda", "Uruguay", "United Arab Emirates"];

  @override
  void initState() {
    // TODO: implement initState
    checkLanguage();
    categorymodel = Provider.of<CategoryDataProvider>(context, listen: false);
    searchProductListProvider=Provider.of<SearchProductListProvider>(context, listen: false);

    getCategories();
    getHistory();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
        resizeToAvoidBottomInset: false,

      body: Stack(

        children: [

          Align(

            alignment: FractionalOffset.topCenter,

            child:     Container(
              height: ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)?60:75:90,
              color:  Color(0xfffafafa),
              child: Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 15),







                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [



                          Expanded(child:  TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                                autofocus: false,
                                style: DefaultTextStyle.of(context).style.copyWith(
                                    fontStyle: FontStyle.normal
                                ),
                                decoration: InputDecoration(

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black87), //<-- SEE HERE
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black87), //<-- SEE HERE
                                  ),

                                  hintText: search_hint,
                                  // border: OutlineInputBorder(),
                                  suffixIcon:  Icon(
                                    Icons.search,
                                    color: Colors.black12,
                                  ),
                                )
                            ),
                            suggestionsCallback: (pattern) async {

                              // return await BackendService.getSuggestions(pattern);

                              List<ProductlistProducts> plist= await   getSearchProductList(pattern);

                              String d="";
                              List<ProductlistProducts> products=[];

                              for(int i=0;i<plist.length;i++)
                              {
                                if(language.compareTo("en")==0) {
                                  if (plist[i].productNameEn.contains(
                                      pattern)) {
                                    products.add(plist[i]);
                                  }
                                }
                                else{

                                  if (plist[i].productNameAr.contains(
                                      pattern)) {
                                    products.add(plist[i]);
                                  }

                                }


                              }



                              return products;
                            },
                            itemBuilder: (context, suggestion) {


                              ProductlistProducts p=suggestion as ProductlistProducts;

                              return
                                Padding(padding: EdgeInsets.all(ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?8:11:15),

                                  child:ListTile(
                                    leading: (p.productImages.length>0)? Image.network(p.productImages[0].productImageUrl,width: 60, height: 60,fit: BoxFit.fill,errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return Image.asset(
                                          "images/pi.png", width: 60, height: 60, fit: BoxFit.fill
                                      );
                                    }
                                    ) : Image.asset(
                                        "images/pi.png", width: 60, height: 60, fit: BoxFit.fill
                                    ),
                                    title: Text((language.compareTo("en")==0)?p.productNameEn : p.productNameAr,style: TextStyle(fontSize: ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?12:14:16),),
                                    // subtitle: Text('\$${suggestion['price']}'),
                                  ) ,

                                )

                              ;
                            },
                            onSuggestionSelected: (suggestion) {

                              ProductlistProducts p=suggestion as ProductlistProducts;

                              // Navigator.push(
                              //     context, MaterialPageRoute(builder: (_) => ProductDetailsPage(p,p.catId.toString())));


                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                    backgroundColor: Colors.transparent,

                                    content:MyProductDetailsPage(p.id,1,p)



                                ),
                              );

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => ProductPage(product: suggestion)
                              // ));
                            },
                          ),flex: 3,),

                          Expanded(child: Container(


                              margin: EdgeInsets.only(
                                  left: 10, right: 10) ,


                              child:
                              GestureDetector(

                                  onTap: (){

                                    showModalBottomSheet(
                                      context: context,
                                      // color is applied to main screen when modal bottom screen is displayed
                                      barrierColor: Color(0xae8e8e8),
                                      //background color for modal bottom screen
                                      backgroundColor: Colors.white,
                                      //elevates modal bottom screen
                                      elevation: 10,
                                      // gives rounded corner to modal bottom screen
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      builder: (BuildContext context) {
                                        // UDE : SizedBox instead of Container for whitespaces
                                        return SizedBox(
                                          height: height/1.3,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  <Widget>[
                                                Padding(padding: EdgeInsets.all(10),

                                                  child:  Text(categorieslang,style: TextStyle(fontSize:ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)? 14:15:17,color: Colors.green),),
                                                ),

                                                Padding(padding: EdgeInsets.all(10),

                                                  child:SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        children: w,
                                                      )


                                                  ),
                                                ),






                                                Row(

                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,

                                                  children: [


                                                    GestureDetector(

                                                      child:  Padding(padding: EdgeInsets.all(10),

                                                          child:  Container(
                                                              decoration:    BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(
                                                                  width: 1.0,
                                                                  color: Colors.green,
                                                                ),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)?5.0 : 6.0:8.0) //                 <--- border radius here
                                                                ),
                                                              ),

                                                              child:
                                                              Padding(padding: EdgeInsets.all(10),

                                                                child:

                                                                Text(normaldelivery,style: TextStyle(fontSize:ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)? 12:14:15,color: Colors.green),),
                                                              )
                                                          )



                                                      ),

                                                      onTap: (){

                                                        Navigator.push(
                                                            context, MaterialPageRoute(builder: (_) => FilteredProductPage(0)));
                                                      },

                                                    ),



                                                    GestureDetector(

                                                      child: Padding(padding: EdgeInsets.all(10),

                                                          child:  Container(
                                                              decoration:    BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(
                                                                  width: 1.0,
                                                                  color: Colors.green,
                                                                ),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)?5.0 : 6.0:8.0) //                 <--- border radius here
                                                                ),
                                                              ),

                                                              child:
                                                              Padding(padding: EdgeInsets.all(10),

                                                                child:

                                                                Text(fastdelivery,style: TextStyle(fontSize:ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)? 12:14:15,color: Colors.green),),
                                                              )
                                                          )



                                                      ),

                                                      onTap: (){
                                                        Navigator.push(
                                                            context, MaterialPageRoute(builder: (_) => FilteredProductPage(1)));



                                                      },

                                                    )



                                                  ],

                                                )





                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },

                                  child: Image.asset("images/settings.png",width:ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)?20:25:30 ,height: ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)?20:25:30)


                              )




                          ),flex: 1,)


                        ],


                      ),
















                ),
              ),
            ),

          ),


          (productlistproducts.length>0)?    Align(

            alignment: FractionalOffset.topLeft,

            child: Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 100:120:150,left: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 10:12:15),


              child: Text(recentlyviewed,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 13:15:17 ),),


            ),

          ) : Container(),

          Align(

            alignment: FractionalOffset.topCenter,

            child: Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 120:150:180),


              child: GridView.builder(
                itemCount: productlistproducts.length,
                itemBuilder: (context, index) {



                  return  Padding(padding: EdgeInsets.all(5),

                      child: GestureDetector(
                        onTap: (){

                          // Navigator.push(
                          //     context, MaterialPageRoute(builder: (_) => ProductDetailsPage(productlistproducts[index],productlistproducts[index].catId.toString())));

                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                backgroundColor: Colors.transparent,

                                content:MyProductDetailsPage(productlistproducts[index].id,1,productlistproducts[index])



                            ),
                          );

                        },

                        child:   Padding(

                          padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:9:13),
                          child: Container(
                              decoration:    BoxDecoration(

                                border: Border.all(
                                    width: 0.7

                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)?8.0 : 12.0:17.0) //                 <--- border radius here
                                ),
                              ),

                              height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?40:45:55,
                              child:
                              Padding(

                                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?3:5:7),
                                child:

                                Text(

                                  (language.compareTo("en")==0)?  productlistproducts[index].productNameEn :
                                  productlistproducts[index].productNameAr
                                  ,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.normal,
                                      fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?11:12:14 ,

                                      color:  Colors.black38),
                                ),)


                          ),


                        ),

                      )




                  );


                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.2,
                    crossAxisSpacing: 0.5
                ),
              ),


            ),

          )




        ],


      ),



    );
  }

  getHistory() async
  {

    List<Map<String, dynamic>> a =
    await new DatabaseHelper().queryAllRows(DatabaseTables.History);


    String idp = "0";

    bool isHistoryexist = false;
    List<Widget>w=[];
    for (Map ab in a) {
      print(ab.length.toString() + " \n");
      print("data \n");


      int id = ab["keyid"];
      String data = ab["data"];

      var jsondata = jsonDecode(data);

      idp = jsondata['id'].toString();

      Map<String,dynamic> m=jsondata['product'];

      ProductlistProducts products=ProductlistProducts.fromJson(m);
      setState(() {

        productlistproducts.add(products);
      });



    }



  }

  getCategories()async {
    CategoryListEntity categoryListEntity = await categorymodel
        .getSinglePostData(context);
    if (categoryListEntity.categories.length > 0) {

      List<Widget>wa=[];

      for(int i=0;i<categoryListEntity.categories.length;i++)
      {

        wa.add(

            GestureDetector(


              child: Padding(padding: EdgeInsets.all(10),

                  child:
                  Card(
                    elevation: 5,


                    child: Container(
                      height:ResponsiveInfo.isSmallMobile(context)?ResponsiveInfo.isMobile(context)?28:32:36 ,


                      margin: EdgeInsets.all(6),


                      child:

                      Padding(
                        padding:  EdgeInsets.all(5),

                        child:  Text((language.compareTo("en")==0)?categoryListEntity.categories[i].categoryNameEn :categoryListEntity.categories[i].categoryNameAr,textAlign: TextAlign.center, ),

                      )


                      ,








                    ),
                  )

              ),

              onTap: (){


                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Productlist(categories[i])));


              },
            )


        );

      }



      setState(() {
        categories.clear();
        categories.addAll(categoryListEntity.categories);
        w.clear();
        w.addAll(wa);
      });
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

        search_hint=lde['search_hint_en'];
        normaldelivery=lde['Normaldelivery_en'];
        fastdelivery=lde['Fastdelivery_en'];
        recentlyviewed=lde['recentlyviewed_en'];
        categorieslang=lde['categories_en'];



      }
      else {

        language=currentlanguage;

        search_hint=lde['search_hint_ar'];
        normaldelivery=lde['Normaldelivery_Ar'];
        fastdelivery=lde['Fastdelivery_Ar'];
        recentlyviewed=lde['recentlyviewed_ar'];
        categorieslang=lde['categories_ar'];

      }
    });

  }


  Future<List<ProductlistProducts>> getSearchProductList(String param)async{

    List<ProductlistProducts> plistp=[];

    ProductlistEntity p=await searchProductListProvider.getSinglePostData(context, param);


    plistp.addAll(p.products);


    return plistp;




  }
}
