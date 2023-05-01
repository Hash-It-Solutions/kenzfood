import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/wel_com_screen.dart';


import 'package:page_transition/page_transition.dart';

import '../config/constant.dart';
import '../utils/Staticvalues.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';
import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initTimer();

    super.initState();
  }

  setLanguageData() async {
    final datastorage = await SharedPreferences.getInstance();
    datastorage.setString(Staticvalues.currentlanguage, "en");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _splashImg(),
    );
  }

  Widget _splashImg() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        // color: Color(0xffd055e8),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            0.1,
            0.4,
            0.6,
            0.9,
          ],
          colors: [
            Color(0xffffffff),
            Color(0xffffffff),
            Color(0xfff3f3f3),
            Color(0xffdcdbdb),
          ],
        )),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            'images/ic_launcher.png',
          ),
        )));
  }

  Timer _initTimer() {
    return Timer(
      const Duration(seconds: 5),
      () => getLoginstatus(),
    );
  }

  getLoginstatus() async {
    apiToken = await getStringValue("token");
    String isViewed = await getStringValue("initial");
    if (isViewed.isEmpty) {
      print("LoggedIn : false");
      Navigator.of(context).pushReplacement(
        PageTransition(
          child: WelComScreen(),
          type: PageTransitionType.leftToRightWithFade,
        ),
      );
    } else {

      // Navigator.of(context).pushReplacement(
      //   PageTransition(
      //     child: PhoneVerification(
      //       phoneNumber: "+919747497967",
      //       pageKey: 'login',
      //       userId: "0",
      //     ),
      //     type: PageTransitionType.leftToRightWithFade,
      //   ),
      // );


      Navigator.of(context).pushReplacement(
        PageTransition(
          child: Homescreen(0),
          type: PageTransitionType.leftToRightWithFade,
        ),
      );

      // Navigator.of(context).pushReplacement(
      //   PageTransition(
      //     child: NewLoginpage(),
      //     type: PageTransitionType.leftToRightWithFade,
      //   ),
      // );
    }
  }
}
