

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/upload_proof.dart';

import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import 'package:country_code_picker/country_code_picker.dart';
class WholeSaleRegister extends StatefulWidget {
  const WholeSaleRegister() : super();

  @override
  _WholeSaleRegisterState createState() => _WholeSaleRegisterState();
}

class _WholeSaleRegisterState extends State<WholeSaleRegister> {


  String country="IN",code="+91";
  String mobilewarning="Enter your mobile number";

  TextEditingController mobilecontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController namecontroller=new TextEditingController();
  String language="";

  String enteryourname="", wholesalereg="",enteryourmob="",enteryouremail="",continuetxt="",continuemsg="",termsofuse="",entermail="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(

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

                    child:  Text(wholesalereg,textAlign : TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?23:ResponsiveInfo.isSmallMobile(context)?19:26,color: Color(0xff01713D),fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),


                  ),

                  Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?5:ResponsiveInfo.isSmallMobile(context)?3:8),

                      child:
                      Container(

                        margin:  EdgeInsets.only(left:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:18:22,right:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:18:22 ),

                        padding:  EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE2E2E2),


                            ),

                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))
                        ),

                      child: TextField(

                        controller: namecontroller,

                        keyboardType: TextInputType.text,

                        style:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? TextStyle(fontSize: 15, height: 1.3,color: Colors.black,fontFamily: 'Roboto'):TextStyle(fontSize: 18, height: 1.5,color: Colors.black,fontFamily: 'Roboto') : TextStyle(fontSize: 20, height: 1.5,color: Colors.black,fontFamily: 'Roboto') : TextStyle(fontSize: 24, height: 1.5,color: Colors.black,fontFamily: 'Roboto'),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontFamily: 'Poppins',fontSize: ResponsiveInfo.isMobile(context)?13:ResponsiveInfo.isSmallMobile(context)?11:15,color: Color(0xffD0D0D0)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),

                          hintText: '  '+enteryourname,
                        ),


                      ),

                      )




                  ),

                  Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?5:ResponsiveInfo.isSmallMobile(context)?3:8),

                      child:
                      _userPhone()),

                  Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?5:ResponsiveInfo.isSmallMobile(context)?3:8),

                      child:
                      Container(

                        margin:  EdgeInsets.only(left:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:18:22,right:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:18:22 ),
                        padding:  EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE2E2E2),


                            ),

                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))
                        ),

                        child: TextField(


                          controller: emailcontroller,

                          keyboardType: TextInputType.text,

                          style:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? TextStyle(fontSize: 15, height: 1.3,color: Colors.black,fontFamily: 'Roboto'):TextStyle(fontSize: 18, height: 1.5,color: Colors.black,fontFamily: 'Roboto') : TextStyle(fontSize: 20, height: 1.5,color: Colors.black,fontFamily: 'Roboto') : TextStyle(fontSize: 24, height: 1.5,color: Colors.black,fontFamily: 'Roboto'),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontFamily: 'Poppins',fontSize: ResponsiveInfo.isMobile(context)?13:ResponsiveInfo.isSmallMobile(context)?11:15,color: Color(0xffD0D0D0)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),

                            hintText: enteryouremail,
                          ),


                        ),

                      )




                  ),


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


            if(namecontroller.text.toString().isNotEmpty)
              {


                if(mobilecontroller.text.toString().isNotEmpty)
                {

                  if(emailcontroller.text.toString().isNotEmpty)
                  {


                    Navigator.of(context).push(
                      PageTransition(
                        child: UploadProof(namecontroller.text.toString(),mobilecontroller.text.toString(),emailcontroller.text.toString()),
                        type: PageTransitionType.leftToRightWithFade,
                      ),
                    );


                  }
                  else{


                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Enter email"),
                    ));
                  }



                }
                else{

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Enter mobile number"),
                  ));

                }


              }
            else{

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Enter name"),
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

  Widget _userPhone() {
    return Container(

      margin:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?15:18:22),

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

              hintText: enteryourmob,
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

        enteryourmob=lde['entermob_en'];
        // willsendverification=lde['wewillmsg_en'];
        continuetxt=lde['continue_en'];

        continuemsg=lde['byclick_en'];
        termsofuse=lde['termsofuse_en'];

        wholesalereg=lde['wholesalereg_en'];
        enteryourname=lde['enteryourname_en'];
        enteryouremail=lde['enteryourmailid_en'];


      }
      else {

        language=currentlanguage;
        enteryourmob=lde['entermob_ar'];
        // willsendverification=lde['wewillmsg_ar'];
        continuetxt=lde['continue_ar'];
        continuemsg=lde['byclick_ar'];
        termsofuse=lde['termsofuse_ar'];
        wholesalereg=lde['wholesalereg_ar'];

        enteryourname=lde['enteryourname_ar'];
        enteryouremail=lde['enteryourmailid_ar'];




      }
    });

  }

}
