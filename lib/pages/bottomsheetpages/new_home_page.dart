import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../databasehelper/DatabaseHelper.dart';
import '../../databasehelper/DatabaseTables.dart';
import '../../dataproviders/BannerProvider.dart';
import '../../dataproviders/CartDataProvider.dart';
import '../../dataproviders/CategoryDataProvider.dart';
import '../../dataproviders/ProductListProvider.dart';
import '../../dataproviders/SearchDataProvider.dart';
import '../../dataproviders/WishlistProvider.dart';
import '../../models/banner_entity.dart';
import '../../models/category_list_entity.dart';
import '../../models/productlist_entity.dart';
import '../../utils/LanguageValues.dart';
import '../../utils/ResponsiveInfo.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../utils/ServerConstants.dart';
import '../my_product_details_page.dart';
import '../productlist.dart';
class NewHomePage extends StatefulWidget {
   NewHomePage() ;

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {


  List<String>pagedatas=["search","time","Supermarket banner","Banner1","Categories","Recently Viewed","You may like this","Banners","Product_categorywise"];

  int p=0;

  String dohaqatar="", fastdelivery="Fast Delivery",normaldelivery="Normal Delivery",deliverylocation="Delivery Location",addtoCart="Add to Cart",categorieslang="Categories";

  String language="en";
  String search_hint="",see_all="";
  String recentlyviewed="",todaydeal="";


  List<String>arraybanners=[];

  List<String>smallarraybanners=[];

  List<ProductlistProducts>lsp=[];


  List<CategoryListCategories> categories=[];

  late CategoryDataProvider categorymodel;
  late ProductListProvider productListProvider;
  late BannerDataProvider bannerprvider;
  late CartDataProvider cartDataProvider;
  late SearchProductListProvider searchProductListProvider;
  late WishlistDataProvider wishlistDataProvider;

  late CategoryDataProvider categorypostMdl;

  List<Widget>nsdwidgetlike=[];
  List<Widget>nsdwidget=[];

  // List<ProductlistProducts>productlistbycategory=[];

Map<CategoryListCategories,ProductlistEntity >productwithcategory=new Map();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // categorymodel = Provider.of<CategoryDataProvider>(context, listen: false);
    productListProvider = Provider.of<ProductListProvider>(context, listen: false);
    bannerprvider= Provider.of<BannerDataProvider>(context, listen: false);
    cartDataProvider=Provider.of<CartDataProvider>(context, listen: false);
    searchProductListProvider=Provider.of<SearchProductListProvider>(context, listen: false);


    categorypostMdl = Provider.of<CategoryDataProvider>(context, listen: false);
    categorypostMdl.getPostData(context);

    productListProvider.getPostData(context, "0", ServerConstants.allparam);
    checkLanguage();
    getBanners();
    getHistory();
    getSmallBanners();
    getCategories();
    getAllProducts();
    // getcategories();
  }
  List<Widget>historywidget=[];
  List<ProductlistProducts> products=[];
  checkLanguage()async
  {

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();

    if(mounted) {
      setState(() {
        if (currentlanguage.compareTo("en") == 0) {
          language = currentlanguage;
          normaldelivery = lde['Normaldelivery_en'];
          fastdelivery = lde['Fastdelivery_en'];
          deliverylocation = lde['Deliverylocation_en'];
          addtoCart = lde['addtocart_en'];
          categorieslang = lde['categories_en'];
          todaydeal = lde['Today_deal_en'];

          recentlyviewed = lde['recentlyviewed_en'];
          search_hint=lde['search_hint_en'];
          see_all=lde['see_all_en'];
          dohaqatar=lde['dohaqatar_en'];
        }
        else {
          language = currentlanguage;
          dohaqatar=lde['dohaqatar_ar'];
          normaldelivery = lde['Normaldelivery_Ar'];
          fastdelivery = lde['Fastdelivery_Ar'];
          deliverylocation = lde['Deliverylocation_Ar'];
          addtoCart = lde['addtocart_Ar'];
          categorieslang = lde['categories_ar'];

          todaydeal = lde['Today_deal_ar'];
          search_hint=lde['search_hint_ar'];
          recentlyviewed = lde['recentlyviewed_ar'];
          see_all=lde['see_all_ar'];
        }
      });
    }



  }
  @override
  Widget build(BuildContext context) {


    double  height= (MediaQuery.of(context).size.height);
    double  width= (MediaQuery.of(context).size.width);
    categorypostMdl = Provider.of<CategoryDataProvider>(context);
    productListProvider=Provider.of<ProductListProvider>(context);
    bannerprvider=Provider.of<BannerDataProvider>(context);
    cartDataProvider=Provider.of<CartDataProvider>(context);

    if(categorypostMdl.post!=null)
    {

      if(categorypostMdl.post.categories.length>0)
      {

        new DatabaseHelper().deleteAll(DatabaseTables.categories);

        String a=categorypostMdl.post.toJson().toString();


         // getProductbyCategory(categorypostMdl.post.categories);


        Map<String, dynamic> data_To_Table = new Map();
        data_To_Table['data'] = a;


        new DatabaseHelper().insert(data_To_Table, DatabaseTables.categories);

      }
      else{

     //   getCategoryDataFromDB();

      }


    }
    else{

    //  getCategoryDataFromDB();

    }


    if(productListProvider.post!=null)
      {

        if(productListProvider.post.products.length>0)
        {

          // String a=productListProvider.post.toJson().toString();
          getAllProducts();

          // Map<String, dynamic> data_To_Table = new Map();
          // data_To_Table['data'] = a;
          //
          //
          // new DatabaseHelper().insert(data_To_Table, DatabaseTables.allproducts);
        //  getAllProducts();
        }
        else{

          //getProductListFromDB();
        }

      }
    else{

    //  getProductListFromDB();
    }



    return Scaffold(

      resizeToAvoidBottomInset : false,

      body: Stack(


        children: [
        Container(
        width: double.infinity,
        height:double.infinity,

        color: Color(0xfff6f6f6),

      ),

      Padding(padding: EdgeInsets.only(bottom: ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?60:75:100),

        child:Stack(



            children: [

          Align(

          alignment: FractionalOffset.topCenter,

          child:  ListView(       shrinkWrap: true,
              children: <Widget>[
                      // Widget w=Container();

          Container(
          width: double.infinity,
            height: ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?50:60:70,
            margin: EdgeInsets.all( ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  style: DefaultTextStyle.of(context).style.copyWith(
                      fontStyle: FontStyle.normal
                  ),
                  decoration: InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color(0xff5CA149)), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color(0xff5CA149)), //<-- SEE HERE
                      ),

                      hintText: search_hint,
                      hintStyle: TextStyle(color: Colors.black12,fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?14:16:19),
                      // border: OutlineInputBorder(),
                      suffixIcon: Container(
                        width: ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?50:60:70,
                        height: ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?50:60:70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight:Radius.circular(ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10) ,bottomRight:Radius.circular(ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10) ),
                            color: Color(0xff5EA049)
                        ),
                        // color: Color(0xff5CA149),
                        child:

                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      )


                  )
              ),
              suggestionsCallback: (pattern) async {

                // return await BackendService.getSuggestions(pattern);

                List<ProductlistProducts> products=[];

                List<ProductlistProducts> plist=[];



                List<Map<String, dynamic>> a= await  new DatabaseHelper().queryAllRows(DatabaseTables.allproducts);
                for (Map ab in a) {
                  print(ab.length.toString() + " \n");
                  print("data \n");


                  int id = ab["keyid"];
                  String data = ab["data"];

                  var jsondata = jsonDecode(data);


                  ProductlistEntity p=ProductlistEntity.fromJson(jsondata);


                  plist.addAll(p.products);

                }

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
            ),

          ),

            Container(
                width: double.infinity,
                height:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 50 :60:75,
                // color: Color(0xff01713D),
                margin: EdgeInsets.all( ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff01713D)
                ),


                child: Padding(

                  padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?8:10:12, 0, ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?8:10:12, 0),

                  child:   Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Expanded(child: Row(

                        children: [
                          Image.asset("images/location.png",width: 20,height: 20,),
                          Text(

                            "  "+dohaqatar
                            ,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(

                                fontFamily: 'poppins',
                                fontWeight: FontWeight.normal,
                                fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?12:14:17 ,

                                color:  Colors.white),
                          )

                        ],

                      ),flex: 1,),

                      Expanded(child:

                      Text(

                        "12.00 AM to 9.00 PM"
                        ,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: TextStyle(

                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                            fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?12:14:17 ,

                            color:  Colors.white),
                      )

                        ,flex: 1,)



                    ],


                  ),
                )




            ),

            Container(
              width: double.infinity,
              height:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 55 :65:75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:  Color(0xff5CA149)
              ),
              margin: EdgeInsets.all( ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10),

              child: Image.asset("images/smallinfo.png",width: double.infinity,height:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 65 :75:85,fit: BoxFit.fill,),

            ),


              (arraybanners.length>0)?Container(
                  height: (MediaQuery.of(context).size.width) / 1.89349112,
                  width: double.infinity,
                  margin: EdgeInsets.all( ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10),
                  child: PageIndicatorContainer(
                      length: arraybanners.length,
                      align: IndicatorAlign.bottom,
                      indicatorSpace: 14.0,

                      indicatorColor: Colors.black12,
                      indicatorSelectorColor: Colors.blueGrey,
                      shape: IndicatorShape.circle(size: 10),
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        // controller: controller,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: (MediaQuery.of(context).size.width) / 1.89349112,
                            width: double.infinity,

                            child: Card(
                                child:
                                Image.network(arraybanners[index],width: width,height: (MediaQuery.of(context).size.width) / 1.89349112,fit: BoxFit.fill,)),
                          );
                        },
                        itemCount: arraybanners.length,
                        // children: nsdwidget,
                      ))):Card(
                elevation: 3,

                child: Container(
                  width: double.infinity,
                  height:(MediaQuery.of(context).size.width) / 1.89349112 ,
                  margin: EdgeInsets.all( ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10),

                ),
              ),


            Padding(padding:
            ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                .isSmallMobile(context) ? EdgeInsets.only(
                left: 8, top: 10, bottom: 10) :
            EdgeInsets.only(left: 12, top: 15, bottom: 15) :
            EdgeInsets.only(left: 15, top: 20, bottom: 20),

                child: (categorypostMdl.post.categories
                    .length > 0) ?

                Column(

                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                        Text(

                          categorieslang
                          ,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(

                              fontFamily: 'poppins',
                              fontWeight: FontWeight.normal,
                              fontSize: ResponsiveInfo
                                  .isMobile(context)
                                  ? ResponsiveInfo
                                  .isSmallMobile(context)
                                  ? 15
                                  : 17
                                  : 19,

                              color: Color(0xff5EA049)),
                        ),

                        Container(
                          margin: EdgeInsets.all(
                              ResponsiveInfo.isMobile(context)
                                  ? ResponsiveInfo
                                  .isSmallMobile(context)
                                  ? 8
                                  : 10
                                  : 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius
                                  .circular(5),
                              color: Color(0xff5CA149)
                          ),
                          child: Padding(

                            padding: EdgeInsets.all(
                                ResponsiveInfo.isMobile(
                                    context) ? ResponsiveInfo
                                    .isSmallMobile(context)
                                    ? 4
                                    : 7 : 9),
                            child: InkWell(
                              onTap: () async {
                                //homescreen.showCategory();

                                final datastorage = await SharedPreferences
                                    .getInstance();

                                datastorage.setString(
                                    "category", "yes");
                              },

                              child: Text(see_all,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ResponsiveInfo
                                        .isMobile(context)
                                        ? ResponsiveInfo
                                        .isSmallMobile(context)
                                        ? 10
                                        : 11
                                        : 13,
                                    color: Colors.white),),
                            )


                            ,
                          )

                          ,


                        )

                      ],

                    ),

                    GridView.builder(

                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (categorypostMdl.post
                          .categories.length >= 3)
                          ? 3
                          : categorypostMdl.post.categories
                          .length,
                      itemBuilder: (BuildContext context,
                          int index) {
                        return

                          AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(
                                  milliseconds: 700),
                              columnCount: 3,
                              child:


                              ScaleAnimation(
                                  child: FadeInAnimation(


                                      child: GestureDetector(

                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (
                                                      _) =>
                                                      Productlist(
                                                          categorypostMdl
                                                              .post
                                                              .categories[index])));
                                        },


                                        child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Container(
                                                  height: double
                                                      .infinity,

                                                  width: double
                                                      .infinity,
                                                  child: Center(
                                                    child: CircleAvatar(
                                                        radius: 45,
                                                        backgroundImage:


                                                        NetworkImage(
                                                          categorypostMdl
                                                              .post
                                                              .categories[index]
                                                              .categoryImageUrl,)
                                                    ),


                                                    //   ClipOval(
                                                    //       child: SizedBox.fromSize(
                                                    //           size: Size.fromRadius(48),
                                                    //
                                                    //
                                                    // child:  Image.network(categories[index].categoryImageUrl,width:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 60:75:100, height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 60:75:100,errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                                                    //     return Image.asset(
                                                    //         "images/pi.png", width: 60, height: 60, fit: BoxFit.fill
                                                    //     );
                                                    //   }
                                                    //   )) ),
                                                  ),
                                                )),


                                            Expanded(
                                              flex: 2,

                                              child: Text(
                                                (language
                                                    .compareTo(
                                                    "en") == 0)
                                                    ? categorypostMdl
                                                    .post
                                                    .categories[index]
                                                    .categoryNameEn
                                                    :
                                                categorypostMdl
                                                    .post
                                                    .categories[index]
                                                    .categoryNameAr,
                                                maxLines: 2,
                                                textAlign: TextAlign
                                                    .center,
                                                style: TextStyle(

                                                    fontFamily: 'poppins',
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    fontSize: ResponsiveInfo
                                                        .isMobile(
                                                        context)
                                                        ? ResponsiveInfo
                                                        .isSmallMobile(
                                                        context)
                                                        ? 12
                                                        : 13
                                                        : 15,

                                                    color: Color(
                                                        0xff3f3f3f)),
                                              ),


                                            )
                                          ],
                                        ),


                                      )


                                  )

                              )
                          );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 0.3,
                          mainAxisSpacing: 0.3,
                          childAspectRatio: 1
                      ),)
                  ],
                )


                    : Container()),

            (historywidget.length>0)?Padding(padding:
            ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                .isSmallMobile(context) ? EdgeInsets.only(
                left: 5, top: 10, bottom: 10) :
            EdgeInsets.only(left: 8, top: 15, bottom: 15) :
            EdgeInsets.only(left: 13, top: 20, bottom: 20),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(

                      " " + recentlyviewed
                      ,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(

                          fontFamily: 'poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: ResponsiveInfo.isMobile(
                              context)
                              ? ResponsiveInfo.isSmallMobile(
                              context) ? 15 : 17
                              : 19,

                          color: Color(0xff3e3e3e)),
                    ),

                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: historywidget,
                        )


                    )

                  ],
                )


            ):Container(),


                (productListProvider.post.products.length>0)?   Padding(padding:
            ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                .isSmallMobile(context) ? EdgeInsets.only(
                left: 5, top: 10, bottom: 10) :
            EdgeInsets.only(left: 8, top: 15, bottom: 15) :
            EdgeInsets.only(left: 13, top: 20, bottom: 20),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(

                      " " + todaydeal
                      ,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(

                          fontFamily: 'poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: ResponsiveInfo.isMobile(
                              context)
                              ? ResponsiveInfo.isSmallMobile(
                              context) ? 15 : 17
                              : 19,

                          color: Color(0xff3e3e3e)),
                    ),

                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: nsdwidgetlike,
                        )


                    )

                  ],
                )


            ) : Container(),




            Container(
                height: (MediaQuery
                    .of(context)
                    .size
                    .width) / 1.89349112,
                width: double.infinity,
                child: PageIndicatorContainer(
                    length: smallarraybanners.length,
                    align: IndicatorAlign.bottom,
                    indicatorSpace: 14.0,
                    padding: const EdgeInsets.all(10),
                    indicatorColor: Colors.black12,
                    indicatorSelectorColor: Colors.blueGrey,
                    shape: IndicatorShape.circle(size: 10),
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      // controller: controller,
                      itemBuilder: (BuildContext context,
                          int index) {
                        return Container(
                          height: (MediaQuery
                              .of(context)
                              .size
                              .width) / 1.89349112,
                          width: double.infinity,
                          child: Card(
                              child:
                              Image.network(
                                smallarraybanners[index],
                                width: width,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .width) / 1.89349112,
                                fit: BoxFit.fill,)),
                        );
                      },
                      itemCount: smallarraybanners.length,
                      // children: nsdwidget,
                    ))),

          


                Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: nsdwidget)




// Container(
//
//
//   child:  ListView.builder(
//       itemCount: 5,
//       scrollDirection: Axis.vertical,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           width: double.infinity,
//           height: 200,
//           child: Column(
//
//             children: [
//
//               Text("svchjdvs")
//             ],
//           ),
//
//         );
//       }),
//   width: double.infinity,
//   height: 320,
//
// )






                         ]


                    ),)

            ],



















        )

      )

        ],


      ),





    );
  }

  // getcategories()
  // async {
  //
  //   try {
  //     final response = await http.get(
  //       Uri.parse(ServerConstants.baseurl+ServerConstants.getCategory),
  //       headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final item = json.decode(response.body);
  //       CategoryListEntity    result = CategoryListEntity.fromJson(item);
  //       getProductbyCategory(result.categories);
  //
  //
  //     }
  //
  //
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //
  // }

  getProductListFromDB()
  async {
    List<Map<String, dynamic>> a= await  new DatabaseHelper().queryAllRows(DatabaseTables.allproducts);
    for (Map ab in a) {
      print(ab.length.toString() + " \n");
      print("data \n");


      int id = ab["keyid"];
      String data = ab["data"];

      var jsondata = jsonDecode(data);

      setState(() {

        productListProvider.post=ProductlistEntity.fromJson(jsondata);
      });

      getAllProducts();
    }
  }


  getBanners()async
  {
    try {


      List<Map<String, dynamic>> a= await  new DatabaseHelper().queryAllRows(DatabaseTables.Bigbanner);
      for (Map ab in a) {
        print(ab.length.toString() + " \n");
        print("data \n");


        int id = ab["keyid"];
        String data = ab["data"].toString();

        var jsondata = jsonDecode(data);


        BannerEntity p=BannerEntity.fromJson(jsondata);

        for (int i = 0; i < p.data.length; i++) {
          if(mounted) {
            setState(() {
              arraybanners.add(p.data[i].bannerImageUrl);
            });
          }
        }




      }



      String url=ServerConstants.baseurl+ServerConstants.get_banners;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {

        String a=response.body;
        final item = json.decode(response.body);
        BannerEntity   result = BannerEntity.fromJson(item);


        if (result.data.length > 0) {
          arraybanners.clear();


          for (int i = 0; i < result.data.length; i++) {
            if (mounted) {
              setState(() {
                arraybanners.add(result.data[i].bannerImageUrl);
              });
            }
          }


          new DatabaseHelper().deleteAll(DatabaseTables.Bigbanner);

          String resp = a;
          Map<String, dynamic> data_To_Table = new Map();
          data_To_Table['data'] = resp;

          new DatabaseHelper().insert(data_To_Table, DatabaseTables.Bigbanner);
        }
        else {


        }
      }
    }catch(e)
    {

      print(e.toString());
    }



  }


  getSmallBanners()async
  {
    try {

      List<Map<String, dynamic>> a= await  new DatabaseHelper().queryAllRows(DatabaseTables.SmallBanner);
      for (Map ab in a) {
        print(ab.length.toString() + " \n");
        print("data \n");


        int id = ab["keyid"];
        String data = ab["data"].toString();

        var jsondata = jsonDecode(data);


        BannerEntity p=BannerEntity.fromJson(jsondata);

        for (int i = 0; i < p.data.length; i++) {
          if(mounted) {
            setState(() {
              smallarraybanners.add(p.data[i].bannerImageUrl);
            });
          }
        }




      }



      BannerEntity bannerentity = await bannerprvider.getSecondaryData(context);

      if (bannerentity.data.length > 0) {
        smallarraybanners.clear();

        for (int i = 0; i < bannerentity.data.length; i++) {
          if(mounted) {
            setState(() {
              smallarraybanners.add(bannerentity.data[i].bannerImageUrl);
            });
          }
        }
      }
      else {


      }

      new DatabaseHelper().deleteAll(DatabaseTables.SmallBanner);

      String resp = bannerentity.toString();
      Map<String, dynamic> data_To_Table = new Map();
      data_To_Table['data'] = resp;

      new DatabaseHelper().insert(data_To_Table, DatabaseTables.SmallBanner);



    }catch(e)
    {

    }



  }

  getCategoryDataFromDB()
  async {

    List<Map<String, dynamic>> a= await  new DatabaseHelper().queryAllRows(DatabaseTables.categories);
    for (Map ab in a) {
      print(ab.length.toString() + " \n");
      print("data \n");


      int id = ab["keyid"];
      String data = ab["data"];

      // var jsondata = jsonDecode(data);
      //
      // setState(() {
      //
      //   categorypostMdl.post=CategoryListEntity.fromJson(jsondata);
      // });


    }

  }

  getHistory() async
  {
    try {
      List<Map<String, dynamic>> a =
      await new DatabaseHelper().queryAllRows(DatabaseTables.History);


      String idp = "0";

      bool isHistoryexist = false;
      List<Widget>w = [];
      for (Map ab in a) {
        print(ab.length.toString() + " \n");
        print("data \n");


        int id = ab["keyid"];
        String data = ab["data"];

        var jsondata = jsonDecode(data);

        idp = jsondata['id'].toString();

        Map<String, dynamic> m = jsondata['product'];

        ProductlistProducts products = ProductlistProducts.fromJson(m);

        print("No : " + products.productStock.length.toString());

        // historywidget.add(value);

        double price = 0,
            offerprice = 0,offerpercent=0;
        bool ispricesame = false;

        String url = "";

        if (products.productStock.length > 0) {
          price = double.parse(products.productStock[0].productPrice);
          offerprice = double.parse(products.productStock[0].productOfferPrice);

          if (price != 0 && offerprice != 0) {
            if (price == offerprice) {
              ispricesame = true;
            }
            else {
              ispricesame = false;

              offerpercent=((price-offerprice)/price)*100;
            }
          }
        }

        if (products.productImages.length > 0) {
          url = products.productImages[0].productImageUrl;
        }

        w.add(Padding(padding: ResponsiveInfo.isMobile(context)
            ? ResponsiveInfo.isSmallMobile(context)
            ? EdgeInsets.all(5)
            : EdgeInsets.all(8) : EdgeInsets.all(13),

            child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) =>
                  //     ProductDetailsPage(products,
                  //         products
                  //             .catId.toString())));


                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.transparent,

                        content:MyProductDetailsPage(products.id,1,products)



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
                                      .isSmallMobile(context) ? EdgeInsets.all(5) :
                                  EdgeInsets.all(9) :
                                  EdgeInsets.all(15),

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
                                      .isSmallMobile(context) ? EdgeInsets.all(3) :
                                  EdgeInsets.all(5) :
                                  EdgeInsets.all(8),

                                    child: Text(

                                      (language.compareTo("en") == 0) ? products.productNameEn :
                                      products.productNameAr
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
                                        .isSmallMobile(context) ?10:13:17,),

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

                                          addToCart(products.id,1,products);
                                        },
                                      )



                                  )




                                ],
                              ),


                            ),


                          ),
                          alignment: FractionalOffset.center,
                        ),

                        // Align(
                        //   alignment: FractionalOffset.topRight,
                        //   child: ,
                        //
                        // ),
                        Align(
                            alignment: FractionalOffset.topLeft,
                            child:SizedBox(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    margin: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                        ? ResponsiveInfo.isSmallMobile(context)
                                        ?5:8:11),

                                    // child: GestureDetector(
                                    //
                                    //   child: Icon(Icons.favorite_outline,color:(products.inWishlist)?Colors.red: Colors.black,size:ResponsiveInfo.isMobile(context)
                                    //       ? ResponsiveInfo.isSmallMobile(context)
                                    //       ?20:23:28 ,),
                                    //
                                    //   onTap: ()
                                    //   async {
                                    //
                                    //     if(!products.inWishlist)
                                    //     {
                                    //
                                    //       wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);
                                    //
                                    //
                                    //       String response=await  wishlistDataProvider.addWishlist(context, products.id.toString());
                                    //
                                    //       if(response.isNotEmpty)
                                    //       {
                                    //
                                    //
                                    //
                                    //
                                    //         Map body = json.decode(response);
                                    //
                                    //         if(body!=null) {
                                    //
                                    //           if(body.containsKey("message")) {
                                    //
                                    //             setState(() {
                                    //
                                    //
                                    //               products.inWishlist=true;
                                    //
                                    //             });
                                    //             // getAllItemsFromCart();
                                    //
                                    //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    //               content: Text(
                                    //                   body["message"]),
                                    //             ));
                                    //             print(body["message"]);
                                    //           }
                                    //         }
                                    //
                                    //
                                    //
                                    //
                                    //       }
                                    //     }
                                    //     else{
                                    //
                                    //       wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);
                                    //
                                    //       String response=await  wishlistDataProvider.remove(context, products.id.toString());
                                    //
                                    //       if(response.isNotEmpty)
                                    //       {
                                    //
                                    //
                                    //
                                    //
                                    //         Map body = json.decode(response);
                                    //
                                    //         if(body!=null) {
                                    //
                                    //           if(body.containsKey("message")) {
                                    //
                                    //             setState(() {
                                    //
                                    //
                                    //               products.inWishlist=false;
                                    //
                                    //             });
                                    //
                                    //
                                    //
                                    //
                                    //             // getAllItemsFromCart();
                                    //
                                    //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    //               content: Text(
                                    //                   body["message"]),
                                    //             ));
                                    //             print(body["message"]);
                                    //           }
                                    //         }
                                    //
                                    //
                                    //
                                    //
                                    //       }
                                    //
                                    //     }
                                    //
                                    //
                                    //   },
                                    // )





                                  ),

                                  (!ispricesame)?  Container(

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
                                          ?9:10:11, fontFamily: 'Poppins' ),) ,


                                    )

                                    ,


                                  ):Container()
                                ],
                              ),
                              width: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                  .isSmallMobile(context) ? 180 : 195 : 220,
                            )





                        ),




                      ],
                    )

                  ],
                )







            )


        ));


        // if (idp.compareTo(product.id.toString()) == 0) {
        //   isHistoryexist = true;
        //   break;
        // }
      }
      if(mounted) {
        setState(() {
          historywidget.addAll(w);
        });
      }
    }catch(e)
    {

    }

  }

  addToCart(int id,int qty,ProductlistProducts productlistProducts) async{

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


  }



  getAllProducts()
  {
    // arrangeProductByCategory();
    lsp.clear();
    nsdwidgetlike.clear();
    int p = 0;

    if (productListProvider.post.products.length > 10) {
      p = 10;
    }
    else {
      p = productListProvider.post.products.length;
    }


    for (int i = 0; i < p; i++) {
      if (productListProvider.post.products[i].status.toString().compareTo("enable") == 0) {
        lsp.add(productListProvider.post.products[i]);
      }
    }

    //lsp.addAll(productListProvider.post.products);


    for (int i = 0; i < lsp.length; i++) {
      try {
        double price = 0,
            offerprice = 0;
        bool ispricesame = false;

        String url = "";

        if (lsp[i].productStock.length > 0) {
          print(lsp[i].productStock[0].productPrice);
          price = double.parse(lsp[i].productStock[0].productPrice);
          offerprice = double.parse(lsp[i].productStock[0].productOfferPrice);

          if (price != 0 && offerprice != 0) {
            if (price == offerprice) {
              ispricesame = true;
            }
            else {
              ispricesame = false;
            }
          }
        }

        lsp[i].ispricesame = ispricesame;
      } on Exception catch (_) {
        // make it explicit that a SocketException will be thrown if the network connection fails
        rethrow;
      }
    }

    List<Widget>w = [];

    try{

      for (int i = 0; i < lsp.length; i++) {
        double price = 0,
            offerprice = 0,offerpercent=0;

        bool ispricesame = false;

        String url = "";

        if (lsp[i].productStock.length > 0) {
          price = double.parse(
              lsp[i].productStock[0]
                  .productPrice);
          offerprice = double.parse(
              lsp[i].productStock[0]
                  .productOfferPrice);


          if (price != 0 && offerprice != 0) {
            if (price == offerprice) {
              ispricesame = true;
              lsp[i].ispricesame = ispricesame;
            }
            else {
              ispricesame = false;
              lsp[i].ispricesame = ispricesame;
              offerpercent=((price-offerprice)/price)*100;

            }
          }
        }

        if (lsp[i].productImages.length > 0) {
          url = lsp[i].productImages[0]
              .productImageUrl;
        }

        w.add(Padding(padding: ResponsiveInfo.isMobile(context)
            ? ResponsiveInfo.isSmallMobile(context)
            ? EdgeInsets.all(5)
            : EdgeInsets.all(8) : EdgeInsets.all(13),

            child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) =>
                  //     ProductDetailsPage(lsp[i],
                  //         lsp[i]
                  //             .catId.toString())));


                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.transparent,

                        content:MyProductDetailsPage(lsp[i].id,1,lsp[i])



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
                                      .isSmallMobile(context) ? EdgeInsets.all(5) :
                                  EdgeInsets.all(9) :
                                  EdgeInsets.all(15),

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
                                      .isSmallMobile(context) ? EdgeInsets.all(3) :
                                  EdgeInsets.all(5) :
                                  EdgeInsets.all(8),

                                    child: Text(

                                      (language.compareTo("en") == 0) ? lsp[i].productNameEn :
                                      lsp[i].productNameAr
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
                                        .isSmallMobile(context) ?10:13:17,),

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

                                          addToCart(lsp[i].id,i,lsp[i]);
                                        },
                                      )



                                  )




                                ],
                              ),


                            ),


                          ),
                          alignment: FractionalOffset.center,
                        ),

                        // Align(
                        //   alignment: FractionalOffset.topRight,
                        //   child: ,
                        //
                        // ),
                        Align(
                            alignment: FractionalOffset.topLeft,
                            child:SizedBox(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      margin: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                          ? ResponsiveInfo.isSmallMobile(context)
                                          ?5:8:11),

                                      child:GestureDetector(

                                        child: Icon(Icons.favorite_outline,color:(lsp[i].inWishlist)?Colors.red: Colors.black,size:ResponsiveInfo.isMobile(context)
                                            ? ResponsiveInfo.isSmallMobile(context)
                                            ?20:23:28 ,),
                                        onTap: () async {

                                          if(!lsp[i].inWishlist)
                                          {

                                            wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);


                                            String response=await  wishlistDataProvider.addWishlist(context, lsp[i].id.toString());

                                            if(response.isNotEmpty)
                                            {




                                              Map body = json.decode(response);

                                              if(body!=null) {

                                                if(body.containsKey("message")) {

                                                  setState(() {

                                                    // nsdwidgetlike.insert(i, nsdwidgetlike[i]);


                                                    lsp[i].inWishlist=true;

                                                    getAllProducts();

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

                                            wishlistDataProvider=Provider.of<WishlistDataProvider>(context, listen: false);

                                            String response=await  wishlistDataProvider.remove(context, lsp[i].id.toString());

                                            if(response.isNotEmpty)
                                            {




                                              Map body = json.decode(response);

                                              if(body!=null) {

                                                if(body.containsKey("message")) {

                                                  setState(() {


                                                    lsp[i].inWishlist=false;
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




                                  ),

                                  (!ispricesame)?  Container(

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


                                  ):Container()
                                ],
                              ),
                              width: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                  .isSmallMobile(context) ? 180 : 195 : 220,
                            )





                        ),




                      ],
                    )

                  ],
                )







            )


        ))


        ;
      }
    }catch (e) {

    }

    if(mounted) {
      setState(() {
        nsdwidgetlike.addAll(w);
      });
    }
  }






  getCategories()async {
    try {

  late     CategoryListEntity categoryListEntity;
      final response = await http.get(
        Uri.parse(ServerConstants.baseurl+ServerConstants.getCategory),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        categoryListEntity = CategoryListEntity.fromJson(item);
      }


      if (categoryListEntity.categories.length > 0) {

        callProductbyCategory(categoryListEntity.categories);

        // if(mounted) {
        //   setState(() {
        //     categories.clear();
        //     categories.addAll(categoryListEntity.categories);
        //   });
        // }


        // for (int i = 0; i < categoryListEntity.categories.length; i++) {
        //
        //   ProductlistEntity productlistEntity = await productListProvider
        //       .getSinglePostDataByCategory(context, categoryListEntity.categories[i].id.toString(),
        //       ServerConstants.categoryidparam);
        //   print(productlistEntity.products.length);
        //
        //   if (productlistEntity.products.length > 0) {
        //     getProductsByCategory(categoryListEntity.categories[i],productlistEntity.products);
        //
        //   }
        // }
      }
    }catch(e)
    {

    }

  }

  getProductsByCategory(CategoryListCategories categori,List<ProductlistProducts> products)
  {
    if (products.length > 0) {


      // setState(() {
      //
      // });

      nsdwidget.add(Container(

        margin: ResponsiveInfo.isTab(context) ? ResponsiveInfo.isMobile(
            context) ? EdgeInsets.all(5) : EdgeInsets.all(9) : EdgeInsets
            .all(14),

        child: Text(

          (language.compareTo("en") == 0)
              ? categori.categoryNameEn
              : categori.categoryNameAr
          ,
          maxLines: 2,
          textAlign: TextAlign.left,
          style: TextStyle(

              fontFamily: 'poppins',
              fontWeight: FontWeight.normal,
              fontSize: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                  .isSmallMobile(context) ? 12 : 14 : 17,

              color: Colors.black),
        ),


      ));
      List<Widget>w = [];

      List<String>w1 = [];
      w1.clear();

      for (int j = 0; j < products.length; j++) {

        if (products[j].status.toString().compareTo(
            "enable") == 0) {

          w1.add(products[j].productNameEn);
          double price = 0,
              offerprice = 0,offerpercent=0;
          bool ispricesame = false;

          String url = "";

          if (products[j].productStock.length > 0) {
            price = double.parse(
                products[j].productStock[0]
                    .productPrice);
            offerprice = double.parse(
                products[j].productStock[0]
                    .productOfferPrice);

            if (price != 0 && offerprice != 0) {
              if (price == offerprice) {
                ispricesame = true;
                products[j].ispricesame = ispricesame;
              }
              else {
                ispricesame = false;
                products[j].ispricesame = ispricesame;
                offerpercent=((price-offerprice)/price)*100;
              }
            }
          }

          if (products[j].productImages.length > 0) {
            url = products[j].productImages[0]
                .productImageUrl;
          }

          w.add(Padding(padding: ResponsiveInfo.isMobile(context)
              ? ResponsiveInfo.isSmallMobile(context)
              ? EdgeInsets.all(5)
              : EdgeInsets.all(8) : EdgeInsets.all(13),

              child: GestureDetector(
                onTap: () {

                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.transparent,

                        content:MyProductDetailsPage(products[j].id,1,products[j])



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
                                      .isSmallMobile(context) ? EdgeInsets.all(5) :
                                  EdgeInsets.all(9) :
                                  EdgeInsets.all(15),

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
                                      .isSmallMobile(context) ? EdgeInsets.all(3) :
                                  EdgeInsets.all(5) :
                                  EdgeInsets.all(8),

                                    child: Text(

                                      (language.compareTo("en") == 0) ? products[j].productNameEn :
                                      products[j].productNameAr
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
                                        .isSmallMobile(context) ?10:13:17,),

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

                                          addToCart(products[j].id,1,products[j]);
                                        },
                                      )



                                  )




                                ],
                              ),


                            ),


                          ),
                          alignment: FractionalOffset.center,
                        ),

                        // Align(
                        //   alignment: FractionalOffset.topRight,
                        //   child: ,
                        //
                        // ),
                        Align(
                            alignment: FractionalOffset.topLeft,
                            child:SizedBox(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      margin: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                          ? ResponsiveInfo.isSmallMobile(context)
                                          ?5:8:11),

                                      child: Container()





                                  ),

                                  (!ispricesame)?  Container(

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
                                          ?9:11:12, fontFamily: 'Poppins' ),) ,


                                    )

                                    ,


                                  ):Container()
                                ],
                              ),
                              width: ResponsiveInfo.isMobile(context) ? ResponsiveInfo
                                  .isSmallMobile(context) ? 180 : 195 : 220,
                            )





                        ),




                      ],
                    )

                  ],
                )
                ,

              )


          ))


          ;
        }
      }


      // print(categories[i].id.toString()+", "+w1.length.toString());

      setState(() {




        print(productwithcategory.length);


        nsdwidget.add(SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: w,
            )


        ));



        //nsdwidget.add(Text("dxvibxjcbcvj"));
      });

    }
  }

  callProductbyCategory(List<CategoryListCategories> categories) async {

    for (int i = 0; i < categories.length; i++) {

      ProductlistEntity productlistEntity = await productListProvider
          .getSinglePostDataByCategory(context, categories[i].id.toString(),
          ServerConstants.categoryidparam);
      print(productlistEntity.products.length);

      if (productlistEntity.products.length > 0) {
        // productwithcategory.putIfAbsent(categories[i], productlistEntity );
        getProductsByCategory(categories[i],productlistEntity.products);

      }
    }

  }



}
