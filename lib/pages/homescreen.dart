import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/bottomsheetpages/new_home_page.dart';
import 'package:kenz_market_new/pages/wishlist.dart';

import 'package:provider/provider.dart';

import '../config/constant.dart';
import '../dataproviders/CartDataProvider.dart';
import '../dataproviders/CategoryDataProvider.dart';

import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';

import 'bottomsheetpages/cart.dart';
import 'bottomsheetpages/category.dart';
import 'package:provider/single_child_widget.dart';
 import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'bottomsheetpages/home.dart';
import 'bottomsheetpages/my_new_account_page.dart';
import 'notifications.dart';
// import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: Homescreen(0),
  ));
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<CategoryDataProvider>(
      create: (_) => CategoryDataProvider()),
];

class Homescreen extends StatefulWidget {

  int cart=0;

   Homescreen(this.cart) ;

  @override
  _HomescreenState createState() => _HomescreenState(cart);


}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {

  final _pageController = PageController(initialPage: 0);

  int maxCount = 5;

  int forcart=0;
  String cartcount="";


  _HomescreenState(this.forcart);

  static int _selectedIndex = 0;

  bool _fromTop = true;

  String home = "Home",
      category = "Category",
       favourite = "Favourites",
      cart = "Cart",
      myaacount = "My Account";

  List<Widget> categories = <Widget>[
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Fast Delivery",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(6),
      child: Text(
        "Normal Delivery",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
      ),
    )
  ];

  final List<bool> _selectedcategories = <bool>[true, false];

  bool vertical = false;
  TextEditingController searchcontroller = new TextEditingController();

  List widgetData = [
   // Home(),
     NewHomePage(),
    Category(),
    Cart(),
    Wishlist(),

    MyNewAccountPage()

    // MyAccount((String v) {
    //   return v;
    // })
  ];

  int counter = 0;
  late Timer _timer;

 static int currentindex=0;
  late CartDataProvider cartDataProvider;

  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    cartDataProvider = Provider.of<CartDataProvider>(context, listen: false);
    updateCounter();
    _tabController = TabController(length: 2, vsync: this);

    setLanguageData();
    if(forcart==1)
      {
        showCart();
      }


    super.initState();
  }


  setLanguageData()async{

    // final datastorage = await SharedPreferences.getInstance();
    // datastorage.setString(Staticvalues.currentlanguage, "en");
  }
  bool isfirsticon = true, isseconicon = false, isthirdicon = false,isfourthicon=false,isfifthicon=false;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  updateCounter() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // You can also call here any function.
      checkLanguage();
      checkCategoryPage();
      getCart();
      checkwishlistPage();
    });
  }

  @override
  void didChangeDependencies() {
    print(" Token : $apiToken");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height);
    double width = (MediaQuery.of(context).size.width);
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff05ac54), // Status bar color
        child: SafeArea(
            left: false,
            right: false,
            bottom: false,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  toolbarHeight: ResponsiveInfo.isMobile(context)
                      ? ResponsiveInfo.isSmallMobile(context)
                          ? 70
                          : 90
                      : 120,
                  flexibleSpace: Container(
                    width: double.infinity,
                    padding: ResponsiveInfo.isMobile(context)
                        ? ResponsiveInfo.isSmallMobile(context)
                            ? EdgeInsets.only(left: 5, right: 10)
                            : EdgeInsets.only(left: 7, right: 15)
                        : EdgeInsets.only(left: 9, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                    ? ResponsiveInfo.isSmallMobile(context)
                                    ?5:7:9),

                                child:   Image.asset('images/logoimg.png',width: ResponsiveInfo.isMobile(context)
                                    ? ResponsiveInfo.isSmallMobile(context)
                                    ?50:60:70,height: ResponsiveInfo.isMobile(context)
                                    ? ResponsiveInfo.isSmallMobile(context)
                                    ?50:60:70,),

                                ),


                                Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                                    ? ResponsiveInfo.isSmallMobile(context)
                                    ?5:7:9),

                                  child:   Image.asset('images/kenztitle.png',width:ResponsiveInfo.isMobile(context)
                                      ? ResponsiveInfo.isSmallMobile(context)
                                      ? 107:120:150,height:ResponsiveInfo.isMobile(context)
                                      ? ResponsiveInfo.isSmallMobile(context)
                                      ? 28:32:40,),

                                )





                              ],


                            )
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Align(
                              alignment: FractionalOffset.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ResponsiveInfo.isMobile(context)
                                        ? ResponsiveInfo.isSmallMobile(context)
                                            ? 15
                                            : 20
                                        : 25),
                                child: InkWell(
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
                              )),
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                  backgroundColor: Color(0xfffffff),
                  centerTitle: false,
                  elevation: 0,
                ),

    body: PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
          widgetData.length, (index) => widgetData[index]),
    ),
              extendBody: true,
              bottomNavigationBar: AnimatedNotchBottomBar(

                pageController: _pageController,
                color: Color(0xff5CA149),
                showLabel: true,

                itemLabelStyle: TextStyle(fontSize: 8,color: Colors.black,fontFamily: 'Poppins'),
                notchColor: Colors.white,

                bottomBarItems: [
                   BottomBarItem(
                    inActiveItem: Image.asset("images/home.png",width: 20,height: 20,),
                    activeItem:

                    Image.asset("images/home.png",width: 20,height: 20,),
                    itemLabel: home,
                  ),
                   BottomBarItem(
                    inActiveItem:Image.asset("images/categoryicon.png",width: 20,height: 20,),




                    activeItem: Image.asset("images/categoryicon.png",width: 20,height: 20,),
                    itemLabel: category,
                  ),


                  BottomBarItem(
                    inActiveItem:  (cartcount.isNotEmpty)? Stack(

                        children: [

                          Align(
                            alignment: FractionalOffset.bottomCenter,

                            child: Image.asset("images/cart.png",width: 20,height: 20,),

                          ),

                          Align(
                              alignment: FractionalOffset.topRight,


                                  child: Text(".",textAlign: TextAlign.center,  style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 15:18:23,color: Colors.red,fontWeight: FontWeight.bold),







                              )

                          )

                        ],

                      ) :Image.asset("images/cart.png",width: 20,height: 20,),





                    activeItem:
                    (cartcount.isNotEmpty)? Stack(

                        children: [

                          Align(
                            alignment: FractionalOffset.bottomCenter,

                            child: Image.asset("images/cart.png",width: 20,height: 20,),

                          ),

                          Align(
                              alignment: FractionalOffset.topRight,


                              child: Text(".",textAlign: TextAlign.center,  style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 15:18:23,color: Colors.red,fontWeight: FontWeight.bold),







                              )

                          )

                        ],

                      ) :Image.asset("images/cart.png",width: 20,height: 20,),


                    itemLabel: cart,
                  ),
                   BottomBarItem(
                    inActiveItem: Image.asset("images/favourite.png",width: 20,height: 20,),
                    activeItem: Image.asset("images/favourite.png",width: 20,height: 20,),
                    itemLabel: favourite,
                  ),
                   BottomBarItem(
                     inActiveItem: Image.asset("images/person.png",width: 20,height: 20,),
                     activeItem: Image.asset("images/person.png",width: 20,height: 20,),
                    itemLabel: myaacount,
                  ),
                ],
                onTap: (index) {

                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),







            )));
  }

  checkLanguage() async {
    Map lde = await LanguageDatas.getLanguageData();

    String currentlanguage = await LanguageDatas.checkLanguage();

    setState(() {
      if (currentlanguage.compareTo("en") == 0) {
        home = lde['Home_en'];
        category = lde['Category_en'];
        favourite = lde['Wishlist_en'];
        cart = lde['Cart_en'];
        myaacount = lde['MyAccount_en'];

//checkLanguage();

      } else {
        home = lde['Home_Ar'];
        category = lde['Category_Ar'];
        favourite = lde['Wishlist_Ar'];
        cart = lde['Cart_Ar'];
        myaacount = lde['MyAccount_Ar'];
        // checkLanguage();
      }
    });
  }

  checkCategoryPage()
  async {

    final datastorage = await SharedPreferences.getInstance();

    String? categorydata=datastorage.getString("category");

    if(categorydata.toString().compareTo("yes")==0)
      {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
        datastorage.setString("category", "no");

      }



  }


  checkwishlistPage()
  async {

    final datastorage = await SharedPreferences.getInstance();

    String? categorydata=datastorage.getString("wishlist");

    if(categorydata.toString().compareTo("yes")==0)
    {
      _pageController.animateToPage(
        3,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
      datastorage.setString("wishlist", "no");

    }



  }

//  setLanguage()async
//  {
//
//    final datastorage = await SharedPreferences.getInstance();
// datastorage.setString(Staticvalues.currentlanguage,"en")!;
//
//
//  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  showCart()
  {
    setState(() {
      _selectedIndex = 3;
    });

  }

    showCategory()
  {
    setState(() {
      _selectedIndex = 1;
    });

  }



  getCart() async
  {

    int c=await cartDataProvider.getCartCountData(context);





    setState(() {


      if(c<=0)
        {
          cartcount="";

        }
      else {
        if (c > 9) {
          cartcount = c.toString() + "+";
        }
        else {
          cartcount = c.toString();
        }
      }
    });





  }

}
