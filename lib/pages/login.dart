import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/phoneVerification.dart';
import 'package:kenz_market_new/pages/signup.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../config/constant.dart';
import '../providers/baseProvider.dart';
import '../providers/userProvider.dart';
import '../utils/LanguageValues.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextfield.dart';
import '../widgets/or_divider.dart';
import '../widgets/widgetHelper.dart';
import 'forgotPassword.dart';

class LoginPage extends StatefulWidget {
  static const routename = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _nextFocus = FocusNode();
  final _loginkey = GlobalKey<FormState>();

  String language = "",
      email = "",
      password = "",
      forgotpassword = "",
      login = "",
      createaccount = "",
      or = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, _) {
      return Scaffold(



          appBar:  AppBar(
            backgroundColor: Color(0xffffffff),

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xff05ac54)),
              onPressed: () => Navigator.pop(context),
            ),

          ),



          body: Form(
        key: _loginkey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                _logo(),
                _userName(),
                _password(),
                user.state == ViewState.Idle ? _forgotpassword() : Container(),
                user.state == ViewState.Idle
                    ? _login(user)
                    : const CircularProgressIndicator(),
                user.state == ViewState.Idle ? OrDivider(or) : Container(),
                user.state == ViewState.Idle ? _signup() : Container(),
              ],
            ),
          ),
        ),
      ));
    });
  }

  Widget _login(UserProvider user) {
    return CustomButton(
        onPressed: () async {
          if (_loginkey.currentState!.validate()) {
            FocusManager.instance.primaryFocus!.unfocus();
            await user
                .login(_usernamecontroller.text.trim(),
                    _passwordcontroller.text.trim())
                .then((userModel) {
              if (userModel!.token == null) {
                WidgetHelper.showToast('Inavalid Username or Password');
              } else {
                // WidgetHelper.showToast(
                //     'Success :' + userModel.userId.toString());
                if (userModel.isVerified == false) {
                  saveStringValue("token", "");
                  Navigator.of(context).push(
                    PageTransition(
                      child: PhoneVerification(
                        pageKey: 'login',
                        phoneNumber: countryCode + userModel.phone!,
                        userId: userModel.userId.toString(),
                        code: countryCode,
                      ),
                      // const Homescreen(),
                      type: PageTransitionType.leftToRightWithFade,
                    ),
                  );
                } else {
                  Navigator.of(context).pop({'loggedin': 1});
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   PageTransition(
                  //     child: Homescreen(0),
                  //     type: PageTransitionType.leftToRightWithFade,
                  //   ),
                  //   (Route<dynamic> route) => false,
                  // );
                }
              }
            });
          }
        },
        text: login);
  }

  Widget _signup() {
    return CustomButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SignUp.routename);
        },
        text: createaccount);
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Image.asset(
        'images/splashicon.png',
      ),
    );
  }


  Widget _userName() {
    return CustomTextField(
      icon: Icons.email,
      hintText: email,
      textInputAction: TextInputAction.next,
      controller: _usernamecontroller,
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your Email";
        }
        return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_nextFocus);
      },
    );
  }

  Widget _password() {
    return CustomTextField(
      icon: Icons.lock,
      isPassword: true,
      hintText: password,
      controller: _passwordcontroller,
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your Password";
        }
        return null;
      },
      focusNode: _nextFocus,
    );
  }

  _forgotpassword() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          forgotpassword,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            child:
                // const ResetPassword(),
                const ForgotPassword(),
            type: PageTransitionType.leftToRightWithFade,
          ),
        );
        // Navigator.of(context).pushNamed(ForgotPasswordscreen.routeName);
      },
    );
  }

  checkLanguage() async {
    Map lde = await LanguageDatas.getLanguageData();

    String currentlanguage = await LanguageDatas.checkLanguage();



    setState(() {
      language = currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {
        language = currentlanguage;
        email = lde['email_en'];
        password = lde['password_en'];
        forgotpassword = lde['forgotpassword_en'];

        login = lde['login_en'];
        or = lde['or_en'];
        createaccount = lde['createaccount_en'];
      } else {
        language = currentlanguage;
        email = lde['email_ar'];
        password = lde['password_ar'];
        forgotpassword = lde['forgotpassword_ar'];

        login = lde['login_ar'];
        or = lde['or_ar'];
        createaccount = lde['createaccount_ar'];
      }
    });
  }
}
