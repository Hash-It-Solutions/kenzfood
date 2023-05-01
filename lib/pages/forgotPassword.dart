import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/phoneVerification.dart';

import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

import '../config/constant.dart';
import '../providers/baseProvider.dart';
import '../providers/userProvider.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextfield.dart';
import '../widgets/widgetHelper.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _verifiedkey = GlobalKey<FormState>();
  final _mobilecontroller = TextEditingController();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, _) {
      return Scaffold(
        appBar: _getAppbar(),
        body: Form(
            key: _verifiedkey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    _getTitle(),
                    const SizedBox(height: 30),
                    _phone(),
                    _getMsg(),
                    const SizedBox(height: 15),
                    user.state == ViewState.Idle
                        ? _submitButton(user)
                        : const CircularProgressIndicator()
                  ],
                ),
              ),
            )),
      );
    });
  }

  _getAppbar() {
    return AppBar(
      title: const Text(
        "Forgot Password",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      elevation: 0.0,
      centerTitle: true,
    );
  }

  _getTitle() {
    return const Flexible(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "Enter your Mobile Number we will send a verification Code",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _getMsg() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        hasError ? "*Please enter the correct OTP" : "",
        style: const TextStyle(
            color: Colors.red,
            //fontSize: 12 * curScaleFactor,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _submitButton(UserProvider user) {
    return CustomButton(
      onPressed: () async {
        if (_verifiedkey.currentState!.validate()) {
          await user
              .isMobileNumExists(_mobilecontroller.text.trim())
              .then((user) async {
            if (user!.userModelReturn == "no user found") {
              WidgetHelper.showToast("User not found");
            } else {
              Navigator.of(context).pushReplacement(
                PageTransition(
                  child: PhoneVerification(
                    phoneNumber: countryCode + _mobilecontroller.text.trim(),
                    pageKey: 'reset',
                    userId: user.userId.toString(), code: '',
                  ),
                  type: PageTransitionType.leftToRightWithFade,
                ),
              );
            }
          });
        }
      },
      text: "Submit",
    );
  }

  Widget _phone() {
    return CustomTextField(
      icon: Icons.phone,
      hintText: "PhoneNumber",
      controller: _mobilecontroller,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter your Mobile number";
        }
        if (value.length < 7) {
          return "Enter a valid phone number";
        } else {
          return null;
        }
      },
      onFieldSubmitted: (value) {},
    );
  }
}
