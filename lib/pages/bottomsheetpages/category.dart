import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kenz_market_new/databasehelper/DatabaseHelper.dart';
import 'package:kenz_market_new/databasehelper/DatabaseTables.dart';
import 'package:kenz_market_new/models/category_list_entity.dart';


import '../../dataproviders/CategoryDataProvider.dart';
import '../../dataproviders/SearchDataProvider.dart';
import '../../models/productlist_entity.dart';
import '../../utils/LanguageValues.dart';
import '../../utils/ResponsiveInfo.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../my_product_details_page.dart';
import '../product_details_page.dart';
import '../productlist.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<CategoryDataProvider>(create: (_) => CategoryDataProvider(),
  ),
];


class Category extends StatefulWidget {
  const Category() : super();

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {


  late CategoryDataProvider postMdl;

  String language="",search_hint="",allcategories="";
  late SearchProductListProvider searchProductListProvider;
  @override
  void initState() {
    // TODO: implement initState

    postMdl = Provider.of<CategoryDataProvider>(context, listen: false);
    postMdl.getPostData(context);

    searchProductListProvider=Provider.of<SearchProductListProvider>(context, listen: false);

    super.initState();
    checkLanguage();


  }



  checkLanguage()async
  {

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();

    if(mounted) {
      setState(() {
        if (currentlanguage.compareTo("en") == 0) {
          language = currentlanguage;

          search_hint=lde['search_hint_en'];
          allcategories=lde['allcategories_en'];

        }
        else {
          language = currentlanguage;

          search_hint=lde['search_hint_ar'];
          allcategories=lde['allcategories_ar'];

        }
      });
    }



  }


  @override
  Widget build(BuildContext context) {

    postMdl = Provider.of<CategoryDataProvider>(context);


    if(postMdl.post!=null)
      {

        if(postMdl.post.categories.length>0)
          {

            new DatabaseHelper().deleteAll(DatabaseTables.categories);

            String a=postMdl.post.toJson().toString();


            Map<String, dynamic> data_To_Table = new Map();
            data_To_Table['data'] = a;


            new DatabaseHelper().insert(data_To_Table, DatabaseTables.categories);

          }
        else{

          getCategoryDataFromDB();

        }


      }
    else{

      getCategoryDataFromDB();

    }




    return


         Scaffold(


          body: Container(color: Colors.white60,
            width: double.infinity,
            height: double.infinity,

            child: Stack(

              children: [

                Align(
                  alignment: FractionalOffset.topCenter,

                  child:   Container(
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

                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                              backgroundColor: Colors.transparent,

                              content:MyProductDetailsPage(p.id,1,p)



                          ),
                        );


                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (_) => ProductDetailsPage(p,p.catId.toString())));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => ProductPage(product: suggestion)
                        // ));
                      },
                    ),

                  ),

                ),

                Align(
                    alignment: FractionalOffset.topLeft,

                    child: Padding(


                      padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?65:75:90,left: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10),
                      child: Text(

                        allcategories
                        ,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(

                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                            fontSize:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?15:17:19 ,

                            color:  Color(0xff5EA049)),
                      ),
                    )


                ),


                (postMdl.post.categories.length>0)?   Align(
                    alignment: FractionalOffset.topCenter,

                    child: Padding(


                      padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?100:120:150),
                      child: GridView.builder(

                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: postMdl.post.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return

                            AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 700),
                                columnCount: 2,
                                child:




                                ScaleAnimation(
                                    child: FadeInAnimation(


                                        child:  GestureDetector(

                                          onTap: (){


                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (_) => Productlist(postMdl.post.categories[index])));



                                          },


                                          child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child:Container(
                                                  width:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 110:130:160,
                                                  height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 175:200:230,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover, image: NetworkImage(postMdl.post.categories[index].categoryImageUrl)),
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                    color: Colors.redAccent,
                                                  ),
                                                ),




                                              ),


                                              Expanded(
                                                flex: 2,

                                                child: Text(
                                                  (language.compareTo("en")==0)? "\n"+  postMdl.post.categories[index].categoryNameEn :
                                                  "\n"+ postMdl.post.categories[index].categoryNameAr,
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
                                          ) ,




                                        )




                                    )

                                )
                            );




                        },   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.3,
                          mainAxisSpacing: 0.3,
                          childAspectRatio: 1
                      ),),
                    )


                    )
                    :
                      Align(
                      alignment: FractionalOffset.topCenter,

    child: Padding(


    padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?100:120:150),
    child:   GridView.builder(

                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return

                      AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          columnCount: 2,
                          child:




                          ScaleAnimation(
                              child: FadeInAnimation(


                                  child:  GestureDetector(

                                      onTap: (){


                                        // Navigator.push(
                                        //     context, MaterialPageRoute(builder: (_) => Productlist(postMdl.post.categories[index])));



                                      },


                                      child:
                                      Card(
                                        elevation: 3,


                                        child:    Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                height:double.infinity,

                                                width: double.infinity,
                                                child: Center(
                                                    child: Image.asset(
                                                          "images/pi.png", width: 60, height: 60, fit: BoxFit.fill
                                                      )

                                                     ),
                                              ),
                                            ),


                                            Expanded(
                                              flex: 2,

                                              child: Text(
                                                "",
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
                                        ) ,
                                      )



                                  )




                              )

                          )
                      );




                  },   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.3,
                    mainAxisSpacing: 0.3,
                    childAspectRatio: 1
                ),)))


              ],


            ),



          ),

        );













;
  }



  getCategoryDataFromDB()
  async {

    List<Map<String, dynamic>> a= await  new DatabaseHelper().queryAllRows(DatabaseTables.categories);
    for (Map ab in a) {
      print(ab.length.toString() + " \n");
      print("data \n");


      int id = ab["keyid"];
      String data = ab["data"];

      var jsondata = jsonDecode(data);

      setState(() {

        postMdl.post=CategoryListEntity.fromJson(jsondata);
      });


    }

  }



  Future<List<ProductlistProducts>> getSearchProductList(String param)async{

    List<ProductlistProducts> plistp=[];



    List<Map<String, dynamic>> a= await  new DatabaseHelper().queryAllRows(DatabaseTables.allproducts);
    for (Map ab in a) {
      print(ab.length.toString() + " \n");
      print("data \n");


      int id = ab["keyid"];
      String data = ab["data"];

      var jsondata = jsonDecode(data);


      ProductlistEntity p=ProductlistEntity.fromJson(jsondata);


      plistp.addAll(p.products);

    }
    

   


    return plistp;




  }
}
class CurveClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 1.2, size.height * 0.75, size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    return path.getBounds();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}