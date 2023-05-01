import 'package:flutter/material.dart';




import '../../config/constant.dart';
import '../../utils/LanguageValues.dart';
import '../../utils/ResponsiveInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Staticvalues.dart';
import '../edit_profile.dart';
import '../login.dart';
import '../myorders.dart';
import '../user_address.dart';
import '../wishlist.dart';

typedef StringValue = String Function(String);

class MyAccount extends StatefulWidget {
  StringValue callback;
  MyAccount(this.callback);

  @override
  _MyAccountState createState() => _MyAccountState(callback);
}

class _MyAccountState extends State<MyAccount> {
  String clearmsg = "",
      yes = "",
      no = "",
      kenz = "",
      tokendata = "",
      orders = "",
      wishlist = "",
      coupon = "",
      helpcenter = "",
      editprofile = "",
      savedaddress = "",
      selectlanguage = "",
      accountsettings = "",
      logout = "";
  late StringValue callback;

  _MyAccountState(this.callback);

  @override
  void initState() {
    // TODO: implement initState
    checkLanguage();
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      // appBar:  AppBar(
      //   backgroundColor: Color(0xff05ac54),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Text("My Account",style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25),),
      //   centerTitle: false,
      // ),

      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                    padding: ResponsiveInfo.isMobile(context)
                        ? ResponsiveInfo.isSmallMobile(context)
                            ? EdgeInsets.fromLTRB(10, 10, 10, 0)
                            : EdgeInsets.fromLTRB(15, 15, 15, 0)
                        : EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  height: ResponsiveInfo.isMobile(context)
                                      ? ResponsiveInfo.isSmallMobile(context)
                                          ? 60
                                          : 70
                                      : 85,
                                  child: GestureDetector(
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                                padding: ResponsiveInfo.isTab(
                                                        context)
                                                    ? ResponsiveInfo.isMobile(
                                                            context)
                                                        ? ResponsiveInfo
                                                                .isSmallMobile(
                                                                    context)
                                                            ? EdgeInsets.all(6)
                                                            : EdgeInsets.all(10)
                                                        : EdgeInsets.all(14)
                                                    : EdgeInsets.all(20),
                                                child: Icon(
                                                  Icons.list_alt,
                                                  color: Color(0xff05ac54),
                                                  size: ResponsiveInfo.isTab(
                                                          context)
                                                      ? ResponsiveInfo.isMobile(
                                                              context)
                                                          ? ResponsiveInfo
                                                                  .isSmallMobile(
                                                                      context)
                                                              ? 20
                                                              : 25
                                                          : 30
                                                      : 35,
                                                )),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Padding(
                                                padding: ResponsiveInfo.isTab(
                                                        context)
                                                    ? ResponsiveInfo.isMobile(
                                                            context)
                                                        ? ResponsiveInfo
                                                                .isSmallMobile(
                                                                    context)
                                                            ? EdgeInsets.all(6)
                                                            : EdgeInsets.all(10)
                                                        : EdgeInsets.all(14)
                                                    : EdgeInsets.all(20),
                                                child: SizedBox(
                                                  child: Text(
                                                    orders,
                                                    maxLines: 5,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: ResponsiveInfo
                                                                .isTab(context)
                                                            ? ResponsiveInfo
                                                                    .isMobile(
                                                                        context)
                                                                ? ResponsiveInfo
                                                                        .isSmallMobile(
                                                                            context)
                                                                    ? 11
                                                                    : 13
                                                                : 15
                                                            : 18),
                                                  ),
                                                )),
                                            flex: 3,
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MyordersPage(
                                                  title: "My order")));
                                    },
                                  )),
                              flex: 1,
                            ),
                            Expanded(
                              child: Container(
                                  height: ResponsiveInfo.isMobile(context)
                                      ? ResponsiveInfo.isSmallMobile(context)
                                      ? 60
                                      : 70
                                      : 85,
                                  child: GestureDetector(
                                    child: Card(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                                padding: ResponsiveInfo.isTab(
                                                        context)
                                                    ? ResponsiveInfo.isMobile(
                                                            context)
                                                        ? ResponsiveInfo
                                                                .isSmallMobile(
                                                                    context)
                                                            ? EdgeInsets.all(6)
                                                            : EdgeInsets.all(10)
                                                        : EdgeInsets.all(14)
                                                    : EdgeInsets.all(20),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Color(0xff05ac54),
                                                  size: ResponsiveInfo.isTab(
                                                          context)
                                                      ? ResponsiveInfo.isMobile(
                                                              context)
                                                          ? ResponsiveInfo
                                                                  .isSmallMobile(
                                                                      context)
                                                              ? 20
                                                              : 25
                                                          : 30
                                                      : 35,
                                                )),
                                            flex: 1,
                                          ),
                                          Expanded(
                                              child: Padding(
                                                  padding: ResponsiveInfo.isTab(
                                                          context)
                                                      ? ResponsiveInfo.isMobile(
                                                              context)
                                                          ? ResponsiveInfo
                                                                  .isSmallMobile(
                                                                      context)
                                                              ? EdgeInsets.all(
                                                                  6)
                                                              : EdgeInsets.all(
                                                                  10)
                                                          : EdgeInsets.all(14)
                                                      : EdgeInsets.all(20),
                                                  child: SizedBox(
                                                    child: Text(
                                                      wishlist,
                                                      maxLines: 5,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: ResponsiveInfo
                                                                  .isTab(
                                                                      context)
                                                              ? ResponsiveInfo
                                                                      .isMobile(
                                                                          context)
                                                                  ? ResponsiveInfo
                                                                          .isSmallMobile(
                                                                              context)
                                                                      ? 11
                                                                      : 13
                                                                  : 15
                                                              : 18),
                                                    ),
                                                  )),
                                              flex: 2)
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Wishlist()));
                                    },
                                  )),
                              flex: 1,
                            ),
                          ],
                        ),

                      ],
                    )),
              ],
            ),
            Padding(
              padding: ResponsiveInfo.isMobile(context)
                  ? ResponsiveInfo.isSmallMobile(context)
                      ? EdgeInsets.fromLTRB(15, 10, 10, 10)
                      : EdgeInsets.fromLTRB(20, 15, 15, 20)
                  : EdgeInsets.fromLTRB(26, 20, 20, 25),
              child: Text(
                accountsettings,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: ResponsiveInfo.isTab(context)
                        ? ResponsiveInfo.isMobile(context)
                            ? ResponsiveInfo.isSmallMobile(context)
                                ? 14
                                : 16
                            : 18
                        : 20),
              ),
            ),
            Stack(
              children: [
                Padding(
                    padding: ResponsiveInfo.isMobile(context)
                        ? ResponsiveInfo.isSmallMobile(context)
                            ? EdgeInsets.fromLTRB(10, 5, 10, 0)
                            : EdgeInsets.fromLTRB(15, 10, 15, 0)
                        : EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  apiToken.isEmpty
                                      //tokendata.isEmpty
                                      ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const LoginPage()))
                                          .then((result) {
                                          if (result != null) {
                                            setState(() {});
                                          }
                                        })
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => EditProfile()));
                                },
                                child: Card(
                                  child: Container(
                                      height: ResponsiveInfo.isMobile(context)
                                          ? ResponsiveInfo.isSmallMobile(
                                                  context)
                                              ? 75
                                              : 90
                                          : 110,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                    padding: ResponsiveInfo
                                                            .isTab(context)
                                                        ? ResponsiveInfo.isMobile(
                                                                context)
                                                            ? ResponsiveInfo
                                                                    .isSmallMobile(
                                                                        context)
                                                                ? EdgeInsets
                                                                    .all(6)
                                                                : EdgeInsets
                                                                    .all(10)
                                                            : EdgeInsets.all(14)
                                                        : EdgeInsets.all(20),
                                                    child: Image.asset(
                                                      Staticvalues.filename[0],
                                                      width: ResponsiveInfo
                                                              .isTab(context)
                                                          ? ResponsiveInfo
                                                                  .isMobile(
                                                                      context)
                                                              ? ResponsiveInfo
                                                                      .isSmallMobile(
                                                                          context)
                                                                  ? 20
                                                                  : 25
                                                              : 30
                                                          : 35,
                                                      height: ResponsiveInfo
                                                              .isTab(context)
                                                          ? ResponsiveInfo
                                                                  .isMobile(
                                                                      context)
                                                              ? ResponsiveInfo
                                                                      .isSmallMobile(
                                                                          context)
                                                                  ? 20
                                                                  : 25
                                                              : 30
                                                          : 35,
                                                    )),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                    padding: ResponsiveInfo
                                                            .isTab(context)
                                                        ? ResponsiveInfo.isMobile(
                                                                context)
                                                            ? ResponsiveInfo
                                                                    .isSmallMobile(
                                                                        context)
                                                                ? EdgeInsets
                                                                    .all(6)
                                                                : EdgeInsets
                                                                    .all(10)
                                                            : EdgeInsets.all(14)
                                                        : EdgeInsets.all(20),
                                                    child: SizedBox(
                                                      child: Text(
                                                        editprofile,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: ResponsiveInfo
                                                                    .isTab(
                                                                        context)
                                                                ? ResponsiveInfo
                                                                        .isMobile(
                                                                            context)
                                                                    ? ResponsiveInfo.isSmallMobile(
                                                                            context)
                                                                        ? 11
                                                                        : 13
                                                                    : 15
                                                                : 18),
                                                      ),
                                                    )),
                                                flex: 2,
                                              )
                                            ],
                                          ),

                                          // Divider(
                                          //   thickness: 1,
                                          //   color: Colors.white38,
                                          // ),
                                        ],
                                      )),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => UserAddress("0")));
                                },
                                child: Card(
                                    child: Container(
                                  height: ResponsiveInfo.isMobile(context)
                                      ? ResponsiveInfo.isSmallMobile(context)
                                          ? 75
                                          : 85
                                      : 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                            padding:
                                                ResponsiveInfo.isTab(context)
                                                    ? ResponsiveInfo.isMobile(
                                                            context)
                                                        ? ResponsiveInfo
                                                                .isSmallMobile(
                                                                    context)
                                                            ? EdgeInsets.all(6)
                                                            : EdgeInsets.all(10)
                                                        : EdgeInsets.all(14)
                                                    : EdgeInsets.all(20),
                                            child: Image.asset(
                                              Staticvalues.filename[1],
                                              width: ResponsiveInfo.isTab(
                                                      context)
                                                  ? ResponsiveInfo.isMobile(
                                                          context)
                                                      ? ResponsiveInfo
                                                              .isSmallMobile(
                                                                  context)
                                                          ? 20
                                                          : 25
                                                      : 30
                                                  : 35,
                                              height: ResponsiveInfo.isTab(
                                                      context)
                                                  ? ResponsiveInfo.isMobile(
                                                          context)
                                                      ? ResponsiveInfo
                                                              .isSmallMobile(
                                                                  context)
                                                          ? 20
                                                          : 25
                                                      : 30
                                                  : 35,
                                            )),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding:
                                                ResponsiveInfo.isTab(context)
                                                    ? ResponsiveInfo.isMobile(
                                                            context)
                                                        ? ResponsiveInfo
                                                                .isSmallMobile(
                                                                    context)
                                                            ? EdgeInsets.all(6)
                                                            : EdgeInsets.all(10)
                                                        : EdgeInsets.all(14)
                                                    : EdgeInsets.all(20),
                                            child: SizedBox(
                                              child: Text(
                                                savedaddress,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 5,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: ResponsiveInfo
                                                            .isTab(context)
                                                        ? ResponsiveInfo
                                                                .isMobile(
                                                                    context)
                                                            ? ResponsiveInfo
                                                                    .isSmallMobile(
                                                                        context)
                                                                ? 11
                                                                : 13
                                                            : 15
                                                        : 18),
                                              ),
                                            )),
                                        flex: 2,
                                      )
                                    ],
                                  ),


                                )),
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    Widget optionOne = SimpleDialogOption(
                                      child: const Text('English'),
                                      onPressed: () async {
                                        final datastorage =
                                            await SharedPreferences
                                                .getInstance();

                                        datastorage.setString(
                                            Staticvalues.currentlanguage,
                                            Staticvalues.englishlanguagecode);

                                        widget.callback("en");

                                        checkLanguage();

                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget optionTwo = SimpleDialogOption(
                                      child: const Text('عربى'),
                                      onPressed: () async {
                                        final datastorage =
                                            await SharedPreferences
                                                .getInstance();
                                        datastorage.setString(
                                            Staticvalues.currentlanguage,
                                            Staticvalues.arabiclanguagecode);
                                        widget.callback("Ar");
                                        checkLanguage();
                                        Navigator.pop(context);
                                      },
                                    );

                                    SimpleDialog dialog = SimpleDialog(
                                      title: const Text('Choose a language'),
                                      children: <Widget>[
                                        optionOne,
                                        optionTwo,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return dialog;
                                      },
                                    );
                                  },
                                  child: Card(
                                    child: Container(
                                      height: ResponsiveInfo.isMobile(context)
                                          ? ResponsiveInfo.isSmallMobile(
                                                  context)
                                              ? 75
                                              : 85
                                          : 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Padding(
                                                  padding: ResponsiveInfo.isTab(
                                                          context)
                                                      ? ResponsiveInfo.isMobile(
                                                              context)
                                                          ? ResponsiveInfo
                                                                  .isSmallMobile(
                                                                      context)
                                                              ? EdgeInsets.all(
                                                                  6)
                                                              : EdgeInsets.all(
                                                                  10)
                                                          : EdgeInsets.all(14)
                                                      : EdgeInsets.all(20),
                                                  child: Image.asset(
                                                    Staticvalues.filename[2],
                                                    width: ResponsiveInfo.isTab(
                                                            context)
                                                        ? ResponsiveInfo
                                                                .isMobile(
                                                                    context)
                                                            ? ResponsiveInfo
                                                                    .isSmallMobile(
                                                                        context)
                                                                ? 20
                                                                : 25
                                                            : 30
                                                        : 35,
                                                    height: ResponsiveInfo
                                                            .isTab(context)
                                                        ? ResponsiveInfo
                                                                .isMobile(
                                                                    context)
                                                            ? ResponsiveInfo
                                                                    .isSmallMobile(
                                                                        context)
                                                                ? 20
                                                                : 25
                                                            : 30
                                                        : 35,
                                                  )),
                                              flex: 1),
                                          Expanded(
                                              child: Padding(
                                                  padding: ResponsiveInfo.isTab(
                                                          context)
                                                      ? ResponsiveInfo.isMobile(
                                                              context)
                                                          ? ResponsiveInfo
                                                                  .isSmallMobile(
                                                                      context)
                                                              ? EdgeInsets.all(
                                                                  3)
                                                              : EdgeInsets.all(
                                                                  6)
                                                          : EdgeInsets.all(9)
                                                      : EdgeInsets.all(13),
                                                  child: SizedBox(
                                                    child: Text(
                                                      selectlanguage,
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: ResponsiveInfo
                                                                  .isTab(
                                                                      context)
                                                              ? ResponsiveInfo
                                                                      .isMobile(
                                                                          context)
                                                                  ? ResponsiveInfo
                                                                          .isSmallMobile(
                                                                              context)
                                                                      ? 11
                                                                      : 13
                                                                  : 15
                                                              : 18),
                                                    ),
                                                  )),
                                              flex: 2)
                                        ],
                                      ),

                                      // Divider(
                                      //   thickness: 1,
                                      //   color: Colors.white38,
                                      // ),
                                    ),
                                  )),
                              flex: 1,
                            ),
                            Expanded(
                              child: (apiToken.isNotEmpty
                                  //tokendata.isNotEmpty
                                  )
                                  ? GestureDetector(
                                      onTap: () {
                                        Widget yesButton = TextButton(
                                            child: Text(yes),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              // clearProductFromCart();
                                              setState(() {
                                                saveStringValue("token", "");
                                                apiToken = '';
                                                getToken();
                                              });
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
                                          content: Text(clearmsg),
                                          actions: [yesButton, noButton],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      },
                                      child: Card(
                                        child: Container(
                                            height: ResponsiveInfo.isMobile(
                                                    context)
                                                ? ResponsiveInfo.isSmallMobile(
                                                        context)
                                                    ? 75
                                                    : 85
                                                : 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(child: Padding(
                                                        padding: ResponsiveInfo
                                                            .isTab(context)
                                                            ? ResponsiveInfo
                                                            .isMobile(
                                                            context)
                                                            ? ResponsiveInfo
                                                            .isSmallMobile(
                                                            context)
                                                            ? EdgeInsets
                                                            .all(6)
                                                            : EdgeInsets
                                                            .all(10)
                                                            : EdgeInsets
                                                            .all(14)
                                                            : EdgeInsets.all(
                                                            20),
                                                        child: Image.asset(
                                                          "images/logout.png",
                                                          width: ResponsiveInfo
                                                              .isTab(
                                                              context)
                                                              ? ResponsiveInfo
                                                              .isMobile(
                                                              context)
                                                              ? ResponsiveInfo
                                                              .isSmallMobile(
                                                              context)
                                                              ? 20
                                                              : 25
                                                              : 30
                                                              : 35,
                                                          height: ResponsiveInfo
                                                              .isTab(
                                                              context)
                                                              ? ResponsiveInfo
                                                              .isMobile(
                                                              context)
                                                              ? ResponsiveInfo
                                                              .isSmallMobile(
                                                              context)
                                                              ? 20
                                                              : 25
                                                              : 30
                                                              : 35,
                                                        )),flex: 1,)
                                                    ,

                                                    Expanded(child: Padding(
                                                        padding: ResponsiveInfo
                                                            .isTab(context)
                                                            ? ResponsiveInfo
                                                            .isMobile(
                                                            context)
                                                            ? ResponsiveInfo
                                                            .isSmallMobile(
                                                            context)
                                                            ? EdgeInsets
                                                            .all(6)
                                                            : EdgeInsets
                                                            .all(10)
                                                            : EdgeInsets
                                                            .all(14)
                                                            : EdgeInsets.all(
                                                            20),
                                                        child: SizedBox(
                                                          child: Text(
                                                            logout,
                                                            maxLines: 5,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: ResponsiveInfo
                                                                    .isTab(
                                                                    context)
                                                                    ? ResponsiveInfo.isMobile(
                                                                    context)
                                                                    ? ResponsiveInfo.isSmallMobile(context)
                                                                    ? 11
                                                                    : 13
                                                                    : 15
                                                                    : 18),
                                                          ),
                                                        )),flex: 2,)

                                                  ],
                                                ),


                                              ],
                                            )),
                                      ))
                                  : Container(),
                              flex: 1,
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ]),
    );
  }

  getToken() async {
    String apiToken = await getStringValue("token");

    setState(() {
      tokendata = apiToken;
    });
  }

  checkLanguage() async {
    Map lde = await LanguageDatas.getLanguageData();

    String currentlanguage = await LanguageDatas.checkLanguage();

    setState(() {
      if (currentlanguage.compareTo("en") == 0) {
        orders = lde['Order_en'];
        wishlist = lde['Wishlist_en'];
        coupon = lde['Coupon_en'];
        helpcenter = lde['helpcenter_en'];
        accountsettings = lde['Accountsettings_en'];
        editprofile = lde['Editprofile_en'];
        savedaddress = lde['Savedaddress_en'];
        selectlanguage = lde['Selectlanguage_en'];
        logout = lde['logout_en'];
        yes = lde['yes_en'];
        no = lde['No_en'];
        kenz = lde['kenz_food_en'];
        clearmsg = lde['logoutmsg_en'];
      } else {
        orders = lde['Order_Ar'];
        wishlist = lde['Wishlist_Ar'];
        coupon = lde['Coupon_Ar'];
        helpcenter = lde['helpcenter_Ar'];
        accountsettings = lde['Accountsettings_Ar'];
        editprofile = lde['Editprofile_Ar'];
        savedaddress = lde['Savedaddress_Ar'];
        selectlanguage = lde['Selectlanguage_Ar'];
        logout = lde['logout_ar'];
        yes = lde['Yes_ar'];
        no = lde['No_ar'];
        kenz = lde['kenz_food_ar'];
        clearmsg = lde['logoutmsg_ar'];
      }
    });
  }
}
