import 'package:flutter/material.dart';

import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../pages/phoneVerification.dart';
import '../pages/signup.dart';
import '../pages/splashScreen.dart';


class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    //list all routes here
    SplashScreen.routeName: (ctx) => const SplashScreen(),
    LoginPage.routename: (ctx) => const NewLoginpage(),
    SignUp.routename: (ctx) => const SignUp(),
    PhoneVerification.routename: (ctx) => const PhoneVerification(
          phoneNumber: '',
          pageKey: '',
          userId: '',
      code: '',
        ),
  };
}
