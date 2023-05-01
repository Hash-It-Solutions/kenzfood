import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/productlisttab.dart';

import 'package:provider/provider.dart';

import '../dataproviders/SearchDataProvider.dart';
import '../dataproviders/SubCategoryProvider.dart';
import '../models/category_list_entity.dart';
import '../models/productlist_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';


import 'customwidgets/CustomTab.dart';
import 'notifications.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Productlist extends StatefulWidget {

  final CategoryListCategories categoryListCategories;

  const Productlist( this.categoryListCategories) : super();

  @override
  _ProductlistState createState() => _ProductlistState(categoryListCategories);
}

class _ProductlistState extends State<Productlist> with TickerProviderStateMixin {

  late CategoryListCategories categoryListCategories;

  late SubCategoryDataProvider subCategoryDataProvider;




  _ProductlistState(this.categoryListCategories);

  List<Widget>tabwidgets=[];
   int _selectedIndex=0;

  String language="en",addtocart="Add to Cart",search_hint="";

  List<Widget>subpages=[];
  late SearchProductListProvider searchProductListProvider;
  List<String> suggestons = ["USA", "UK", "Uganda", "Uruguay", "United Arab Emirates"];
  @override
  void initState() {


    subCategoryDataProvider = Provider.of<SubCategoryDataProvider>(context, listen: false);
    subCategoryDataProvider.getData(context,categoryListCategories.id.toString());
searchProductListProvider=Provider.of<SearchProductListProvider>(context, listen: false);
    super.initState();
    checkLanguage();
  }


  @override
  Widget build(BuildContext context) {



    _selectedIndex=0;
    subCategoryDataProvider = Provider.of<SubCategoryDataProvider>(context);

    for(int i=0;i<subCategoryDataProvider.post.subcategories.length;i++)
      {



        subpages.add(Productlisttab(subCategoryDataProvider.post.subcategories[i].id.toString(),categoryListCategories.id.toString()));

      }


    return Scaffold(

      resizeToAvoidBottomInset: true,

      appBar:  AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xff01713D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text((language.compareTo("en")==0)?categoryListCategories.categoryNameEn : categoryListCategories.categoryNameAr,style: TextStyle(color: Color(0xff01713D),fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 16:18:21:25),),
        centerTitle: false,

        actions: [

          InkWell(
              child: Icon(
                Icons.notifications,
                size: ResponsiveInfo.isMobile(context)
                    ? ResponsiveInfo.isSmallMobile(context)
                    ? 25
                    : 30
                    : 40,
                color: Colors.black,
              ),
              onTap: () {

                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Notifications()));



              },
            ),


        ],

      ),

      body: Stack(

        children: [



          Align(

            alignment: FractionalOffset.topCenter,
            child: (subpages.length>0)?

                 Card(

                  child:  Stack(

                    children: [

                      Align(
                        alignment: FractionalOffset.topCenter,

                        child:   Container(
                          width: double.infinity,
                          height: ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?50:60:70,
                          margin: EdgeInsets.all( ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?5:8:10),
                          child: TypeAheadField(
                            animationStart: 0,
                            animationDuration: Duration.zero,
                            textFieldConfiguration: TextFieldConfiguration(
                                autofocus: false,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                    hintText: search_hint,
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
                                    ),
                                    border: OutlineInputBorder()
                                ),


                            ),
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                color: Colors.lightBlue[50]
                            ),
                            suggestionsCallback: (pattern) async {
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
                            itemBuilder: (context, sone) {
                              ProductlistProducts p=sone as ProductlistProducts;

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
                              print(suggestion);
                            },
                          ),

                        ),

                      ),

                      Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)?80:115),

                        child:CustomTabView(

                          initPosition: _selectedIndex,
                          itemCount: subCategoryDataProvider.post.subcategories.length,
                          tabBuilder: (context, index) => Tab(text:(language.compareTo("en")==0)? subCategoryDataProvider.post.subcategories[index].subcategoryNameEn :
                          subCategoryDataProvider.post.subcategories[index].subcategoryNameAr
                          ),
                          pageBuilder: (context, index) => subpages[index],
                          onPositionChange: (index){
                            print('current position: $index');
                            _selectedIndex = index;
                          },
                          onScroll: (position) => print('$position'), stub: Container(),
                        )







                      )

                    ],
                  )













                )




            :Container(),



          )
          ,

          // (subpages.length>0)?   Align(
          //
          //   alignment: FractionalOffset.topCenter,
          //   child: Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?60:70:90),
          //
          //     // child: subpages[_selectedIndex],
          //
          //     child: subpages[_selectedIndex],
          //
          //
          //   )
          //
          //
          //
          //
          //
          // ):Container()


        ],


      ),



    );
  }
  Future<List<ProductlistProducts>> getSearchProductList(String param)async{

    List<ProductlistProducts> plistp=[];

    ProductlistEntity p=await searchProductListProvider.getSinglePostData(context, param);


    plistp.addAll(p.products);


    return plistp;




  }
  void setIndexSelected(int index)
  {


  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  checkLanguage()async
  {

    // Map lde= await LanguageDatas.getLanguageData();
    //
    // String currentlanguage=await LanguageDatas.checkLanguage();
    //
    // language=currentlanguage;

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();

    if(mounted) {
      setState(() {
        if (currentlanguage.compareTo("en") == 0) {
          language = currentlanguage;

          search_hint=lde['search_hint_en'];

        }
        else {
          language = currentlanguage;

          search_hint=lde['search_hint_ar'];

        }
      });
    }
  }
}
