import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/resetPassword.dart';

import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../config/color_palette.dart';
import '../config/constant.dart';
import '../models/userReturnModel.dart';
import '../providers/userProvider.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../widgets/customButton.dart';
import '../widgets/widgetHelper.dart';
import 'homescreen.dart';
import 'package:http/http.dart' as http;

class PhoneVerification extends StatefulWidget {
  static const routename = '/otp-screen';

  final String phoneNumber;
  final String pageKey;
  final String userId;
  final String code;
  const PhoneVerification(
      {required this.phoneNumber,
      Key? key,
      required this.pageKey,
      required this.userId, required this.code})
      : super(key: key);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationCode = '';
  final _phone = TextEditingController();
  final _verifiedkey = GlobalKey<FormState>();

  String currentText = "";
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  bool _isResend = false;
  String errorMsg = '';

  Timer? _timer;
  int _start = 60;
  String language="";

  String verifymobile="",checkotp="",pleaseentercorrect="",verifycontinue="",check_otp="",resendotp="",pleasewaitforOTP="";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    _sendOtp(widget.code+widget.phoneNumber);
    super.initState();
    checkLanguage();
  }

  checkLanguage()async
  {
    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();



    setState(() {
      language=currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {

        language=currentlanguage;

        verifymobile=lde['verifyyourmob_en'];
        // willsendverification=lde['wewillmsg_en'];
        check_otp=lde['checkotp_en'];

        pleaseentercorrect=lde['pleaseentercorrect_otp_en'];
        verifycontinue=lde['verifycontinue_en'];

        resendotp=lde['resendotp_en'];
        pleasewaitforOTP=lde['pleasewaitforOTP_en'];



      }
      else {

        language=currentlanguage;
        verifymobile=lde['verifyyourmob_ar'];
        // willsendverification=lde['wewillmsg_ar'];
        check_otp=lde['checkotp_ar'];
        pleaseentercorrect=lde['pleaseentercorrect_otp_ar'];
        verifycontinue=lde['verifycontinue_ar'];
        resendotp=lde['resendotp_ar'];

        pleasewaitforOTP=lde['pleasewaitforOTP_ar'];




      }
    });

  }


  @override
  void dispose() {
    errorController!.close();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, _) {
      return Scaffold(
        appBar: _getAppbar(),
        body: Form(
            key: _verifiedkey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    _getTitle(),
                    const SizedBox(height: 30),
                    _getSubTitle(),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: otpfield(
                          context: context,
                          currentText: currentText,
                          errorController: errorController,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          phone: _phone),
                    ),
                    _getMsg(),
                    const SizedBox(height: 15),
                    _verifyButton(user),
                    const SizedBox(height: 15),
                     _isResend ? _resendbutton() : _resendText(),

                    //_resendbutton()
                  ],
                ),
              ),
            )),
      );
    });
  }

  _getAppbar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.green),
        onPressed: () =>  Navigator.pop(context) ,
      ),
      // title: const Text(
      //   "Verification",
      //   style: TextStyle(fontWeight: FontWeight.bold),
      // ),
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.white54,
    );
  }

  _getTitle() {
    return  Flexible(
      child: Text(
       verifymobile,
        style: TextStyle(fontFamily: 'Poppins',fontSize:22,color: Color(0xff01713D
        ) ),

      ),
    );
  }

  _getSubTitle() {
    return   Padding(

        padding: EdgeInsets.all(10),
        child: Text(
          check_otp,textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Poppins',fontSize:18,color: Colors.black12, ),

        ),
      )


    ;
  }

  _getMsg() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        hasError ? pleaseentercorrect : "",
        style: const TextStyle(
            color: Colors.red,
            //fontSize: 12 * curScaleFactor,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _verifyButton(UserProvider user) {


    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:  Color(0xff01713D),
      ),
      height: ResponsiveInfo.isMobile(context)?55:ResponsiveInfo.isSmallMobile(context)?50:60,
      width: ResponsiveInfo.isMobile(context)?190:ResponsiveInfo.isSmallMobile(context)?210:240,
      child: TextButton(
          onPressed: () async {

            await _verifyOtp(currentText);
            if (errorMsg.isNotEmpty) {
              errorController!.add(ErrorAnimationType.shake);
              setState(() {
                hasError = true;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(errorMsg)));
              });
            } else {
              try {

          String p=      widget.phoneNumber;

                await user.verifyPhoneNum(p);
                success(p, user);
                setState(() {
                  hasError = false;
                });
              } catch (e) {
                WidgetHelper.showToast(
                    "Error occured. Please try again later.");
                if (widget.pageKey == 'login') {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove("token");
                }
                Navigator.of(context).pop();
              }
            }




          }
          ,
          child: Text(
            verifycontinue,
            style:  TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?13:18

            ),
          )),
    );



    // CustomButton(
    //   onPressed: () async {
    //     await _verifyOtp(currentText);
    //     if (errorMsg.isNotEmpty) {
    //       errorController!.add(ErrorAnimationType.shake);
    //       setState(() {
    //         hasError = true;
    //         ScaffoldMessenger.of(context)
    //             .showSnackBar(SnackBar(content: Text(errorMsg)));
    //       });
    //     } else {
    //       try {
    //         await user.verifyPhoneNum(widget.userId);
    //         success('', user);
    //         setState(() {
    //           hasError = false;
    //         });
    //       } catch (e) {
    //         WidgetHelper.showToast("Error occured. Please try again later.");
    //         if (widget.pageKey == 'login') {
    //           final prefs = await SharedPreferences.getInstance();
    //           await prefs.remove("token");
    //         }
    //         Navigator.of(context).pop();
    //       }
    //     }
    //   },
    //   text: "Verify",
    // );
  }

  _resendbutton() {
    return TextButton(
      onPressed: () async {
        await _sendOtp(widget.phoneNumber);
        setState(() {
          _isResend = false;
          _start = 60;
          startTimer();
        });
      },
  child: Text(resendotp,style: TextStyle(fontFamily: 'Poppins',fontSize: ResponsiveInfo.isMobile(context)? 15:18,color: Colors.black54, decoration: TextDecoration.underline,),),
    );
  }

  _resendText() {
    return Flexible(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: pleasewaitforOTP,
          style: const TextStyle(
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: '00:$_start',
              style: TextStyle(
                color: primarySwatch,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _isResend = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void success(String phone, UserProvider user) async {
    if (widget.pageKey == 'signUp') {
      WidgetHelper.showToast('User Verification Successful');
      Navigator.of(context).pop();
    } else if (widget.pageKey == 'login') {
      // verify
      // saveStringValue("token", apiToken);
      // Navigator.of(context).pushAndRemoveUntil(
      //   PageTransition(
      //     child: Homescreen(0),
      //     type: PageTransitionType.leftToRightWithFade,
      //   ),
      //   (Route<dynamic> route) => false,
      // );

      var uri = Uri.parse(Api.signUp);
      var headers = {'Content-Type': 'application/json'};
      var parameters = {
        "ip_address": "0.0.0.0",
        "user_type": "user",
        "username": "",
        "firstname": "",
        "lastname": "",
        "password": "",
        "email": "",
        "phone": phone
      };

      try {


        final response =
        await http.post(uri, body: json.encode(parameters), headers: headers);
        if (response.statusCode == 200) {
          final extractedData = json.decode(response.body);

          // final extractedData = json.decode(response.body);
          var data = UserModel.fromJson(extractedData);
          saveStringValue("token", data.token.toString()) ;
          saveStringValue("userid", data.userId.toString()) ;
          saveStringValue("user_tye", data.userType.toString()) ;

          Navigator.of(context).pop({'verified':1 });

          //return extractedData["return"];
        } else {
          print("error occured");

        }
      } catch (e) {

        print('Error : $e');
      }


    } else if (widget.pageKey == 'reset') {
      //reset password

      Navigator.of(context).pushReplacement(
        PageTransition(
          child: ResetPassword(
            userId: widget.userId,
          ),
          type: PageTransitionType.leftToRightWithFade,
        ),
      );
    }
  }

  Future _sendOtp(String phoneNumber) async {
    await _auth
        .verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (phoneAuthCredential) {
              WidgetHelper.showToast('code sent successfully');
              print('success');
            },
            verificationFailed: (FirebaseAuthException e) {
              print('verferor :' + e.toString());
            },
            codeSent: (String verificationId, [forceResendingToken]) {
              verificationCode = verificationId;
            },
            timeout: const Duration(seconds: 60),
            codeAutoRetrievalTimeout: (String verificationId) {
              verificationCode = verificationId;
            })
        .onError((e, stackTrace) {
      WidgetHelper.showToast(e.toString());
      print('phneror :' + e.toString());
    });
  }

  Future _verifyOtp(String otp) async {
    try {
      await _auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode, smsCode: otp))
          .then((user) {
        setState(() {
          errorMsg = '';
        });
      });
    } on FirebaseException catch (e) {
      setState(() {
        errorMsg = e.message!;
      });
    } catch (e) {
      print(e);
    }
  }

  PinCodeTextField otpfield(
      {required BuildContext context,
      required String currentText,
      required StreamController<ErrorAnimationType>? errorController,
      required Function(String) onChanged,
      required TextEditingController phone}) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: Colors.white,
          inactiveColor: Colors.grey),
      animationDuration: Duration(milliseconds: 300),
      errorAnimationController: errorController,
      controller: phone,
      keyboardType: TextInputType.number,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: onChanged,
    );
  }
}
