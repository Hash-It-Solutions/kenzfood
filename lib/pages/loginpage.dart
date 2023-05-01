import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/phoneVerification.dart';
import 'package:kenz_market_new/pages/whole_sale_register.dart';

import 'package:page_transition/page_transition.dart';

import 'package:country_code_picker/country_code_picker.dart';
import '../api/api.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../widgets/customTextfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
class NewLoginpage extends StatefulWidget {
  const NewLoginpage() : super();

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<NewLoginpage> {


  TextEditingController mobilecontroller =new TextEditingController();
  final _nextFocus = FocusNode();

  String country="IN",code="+91";
  String mobilewarning="Enter your mobile number";

  String language="";

  String entermob="",willsendverification="",continuetxt="",continuemsg="",wholesaleregister="",termsofuse="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff05ac54)),
            onPressed: () => Navigator.pop(context),
          ),

          centerTitle: false,
        ),




        body: Form(

          child:Center(




            child: SingleChildScrollView(
              child: Column(
           
                children: [
                  
                  Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?13:ResponsiveInfo.isSmallMobile(context)?10:15),

                  child:  Text(entermob,textAlign : TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?23:ResponsiveInfo.isSmallMobile(context)?19:26,color: Color(0xff01713D),fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),


                  ),

          Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?10:20),

            child:
                  Text(willsendverification,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?13:18,color: Color(0xffA3A3A3),fontWeight: FontWeight.normal),)),

      Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?30:ResponsiveInfo.isSmallMobile(context)?20:50),

        child:
        _userPhone()),
          Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?30:ResponsiveInfo.isSmallMobile(context)?20:50),

            child:
                  _submit()),


                  Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?30:ResponsiveInfo.isSmallMobile(context)?20:50),

                      child:Center(

                        child: Text.rich(
                          textAlign:TextAlign.center,
                          TextSpan(

                            text: continuemsg,
                            children: [
                              TextSpan(
                                text: termsofuse,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff2C299A),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final result = await FlutterWebAuth.authenticate(url: "https://kenzfood.com/termsandconditions", callbackUrlScheme: "my-custom-app");

// Extract token from resulting url
                                    final token = Uri.parse(result).queryParameters['token'];
                                  },
                              ),
                            ],
                          ),
                        ),
                      )







                  ),


                  Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?30:ResponsiveInfo.isSmallMobile(context)?20:50),

                      child:Center(

                        child: Text.rich(

                          TextSpan(
                            text: '',
                            children: [
                              TextSpan(
                                text: wholesaleregister,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff01713D),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {

                                    Navigator.of(context).push(
                                      PageTransition(
                                        child: WholeSaleRegister(),
                                        type: PageTransitionType.leftToRightWithFade,
                                      ),
                                    );



                                  },
                              ),
                            ],
                          ),
                        ),
                      )







                  )

                ],
              ),
            ),
          ),)
        );
  }

  Widget _submit() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:  Color(0xff01713D),
      ),
      height: ResponsiveInfo.isMobile(context)?55:ResponsiveInfo.isSmallMobile(context)?50:60,
      width: ResponsiveInfo.isMobile(context)?175:ResponsiveInfo.isSmallMobile(context)?160:190,
      child: TextButton(
          onPressed: () async {

            if(mobilecontroller.text.isNotEmpty)
              {

                insertUser(mobilecontroller.text);


              }
            else{

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    mobilewarning),
              ));
            }




          }
          ,
          child: Text(
            continuetxt,
            style:  TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
            fontSize: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?13:18

            ),
          )),
    );
  }

  insertUser(String phone)
  async {

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

        Map results = await Navigator.of(context)
            .push(new MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return new PhoneVerification(
              pageKey: 'login',
              phoneNumber: mobilecontroller.text.trim(),
              userId: "0", code: code,
            );
          },
        ));

        if (results != null &&
            results.containsKey('verified')) {
          setState(() {
            var acc_selected =
            results['verified'];

            int acs =
            acc_selected as int;

            if(acs!=0) {

              Navigator.of(context).pop({'loggedin':1 });

            }




          });
        }

        // Navigator.of(context).push(
        //   PageTransition(
        //     child: PhoneVerification(
        //       pageKey: 'login',
        //       phoneNumber: mobilecontroller.text.trim(),
        //       userId: "0", code: code,
        //     ),
        //     // const Homescreen(),
        //     type: PageTransitionType.leftToRightWithFade,
        //   ),
        // );

        //return extractedData["return"];
      } else {
        print("error occured");

      }
    } catch (e) {

      print('Error : $e');
    }

  }

  Widget _userPhone() {
    return Container(

      margin:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:18:22),
      padding:  EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE2E2E2),


          ),

          borderRadius: BorderRadius.all(
              Radius.circular(10.0))
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Expanded(child:      CountryCodePicker(
            enabled: true,
            onChanged: (c) {

            country=  c.name!;
            code=c.dialCode!;

            print(code);


            },
            initialSelection: 'IN',
            showCountryOnly: true,

            showOnlyCountryWhenClosed: true,
            showDropDownButton: true
            ,

            hideMainText: true,
            favorite: const ['+91', 'IN'],
          ),

            flex: 2,

          ),


          Expanded(child:
          TextField(



            keyboardType: TextInputType.number,
            controller: mobilecontroller,

            style:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? TextStyle(fontSize: 15, height: 1.3,color: Colors.black,fontFamily: 'Roboto'):TextStyle(fontSize: 18, height: 1.5,color: Colors.black,fontFamily: 'Roboto') : TextStyle(fontSize: 20, height: 1.5,color: Colors.black,fontFamily: 'Roboto') : TextStyle(fontSize: 24, height: 1.5,color: Colors.black,fontFamily: 'Roboto'),
            decoration: InputDecoration(
              border: InputBorder.none,

              hintStyle: TextStyle(fontFamily: 'Poppins',fontSize: ResponsiveInfo.isMobile(context)?13:ResponsiveInfo.isSmallMobile(context)?11:15,color: Color(0xffD0D0D0)),

              hintText: entermob,
            ),


          ),

            flex: 4,

          )





        ],



      ),


    );





  }


  checkLanguage()async
  {
    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();



    setState(() {
      language=currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {

        language=currentlanguage;

        entermob=lde['entermob_en'];
        willsendverification=lde['wewillmsg_en'];
        continuetxt=lde['continue_en'];

        continuemsg=lde['byclick_en'];
        termsofuse=lde['termsofuse_en'];

        wholesaleregister=lde['wholesalereg_en'];


      }
      else {

        language=currentlanguage;
        entermob=lde['entermob_ar'];
        willsendverification=lde['wewillmsg_ar'];
        continuetxt=lde['continue_ar'];
        continuemsg=lde['byclick_ar'];
        termsofuse=lde['termsofuse_ar'];
        wholesaleregister=lde['wholesalereg_ar'];






      }
    });

  }
}
