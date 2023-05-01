import 'package:flutter/material.dart';

import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword() : super();

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {


  TextEditingController oldpasswordcontroller=new TextEditingController();
  TextEditingController newpasswordcontroller=new TextEditingController();
  TextEditingController confirmpasswordcontroller=new TextEditingController();

  String language="",chnagepassword="",oldpass="",newpass="",confirmpass="",resetpass="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(

      appBar:  AppBar(
        backgroundColor: Color(0xff05ac54),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(chnagepassword,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25),),
        centerTitle: false,
      ),

      body: Column(


        children: [



          Padding(
              padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?EdgeInsets.fromLTRB(14,15,14,5):EdgeInsets.fromLTRB(18,20,18,5):EdgeInsets.fromLTRB(22,25,22,5),

              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: Theme(data: new ThemeData(
                  hintColor: Colors.black12
              ), child: TextField(

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 0.5),
                  ),
                  hintText: oldpass,


                ),
                onChanged: (text) {


                },
                obscureText: true,
                controller: oldpasswordcontroller,
              ))),

          Padding(
              padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?EdgeInsets.fromLTRB(14,5,14,5):EdgeInsets.fromLTRB(18,5,18,5):EdgeInsets.fromLTRB(22,5,22,5),

              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: Theme(data: new ThemeData(
                  hintColor: Colors.black12
              ), child: TextField(

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 0.5),
                  ),
                  hintText: newpass,


                ),
                onChanged: (text) {


                },
                obscureText: true,
                controller: newpasswordcontroller,
              ))),

          Padding(
              padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?EdgeInsets.fromLTRB(14,5,14,5):EdgeInsets.fromLTRB(18,5,18,5):EdgeInsets.fromLTRB(22,5,22,5),

              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: Theme(data: new ThemeData(
                  hintColor: Colors.black12
              ), child: TextField(

                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 0.5),
                  ),
                  hintText: confirmpass,


                ),
                onChanged: (text) {


                },
                obscureText: true,
                controller: confirmpasswordcontroller,
              ))),

          Padding(
            padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(10):EdgeInsets.all(15):EdgeInsets.all(18),
            child :   Container(
              height: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?40:60:75,
              width:ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? 150:180:250,
              decoration: BoxDecoration(
                  color: Color(0xff05ac54), borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => Otppage(title: "Otp",)));

                  // TemRegData trmg=new TemRegData(namecontroller.value.text,emailcontroller.value.text
                  // ,dropdownValue,dropdownstate,mobilecontroller.value.text,sponsermobilecontroller.value.text,passwordcontroller.value.text,languagedropdown);




                },
                child: Text(
                  resetpass,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),),






        ],
      ),
    );
  }

  // "oldpassword_en": "Old Password",
  // "oldpassword_ar": "كلمة المرور القديمة" ,
  //
  // "newpassword_en": "New Password",
  // "newpassword_ar": "كلمة سر جديدة" ,
  //
  // "confirmpassword_en": "Confirm Password",
  // "confirmpassword_ar": "تأكيد كلمة المرور",
  //
  // "resetpassword_en": "Reset Password",
  // "resetpassword_ar": "إعادة تعيين كلمة المرور"


  checkLanguage()async
  {

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();



    setState(() {
      language=currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {

        language=currentlanguage;


        chnagepassword=lde['changepassword_en'];
        oldpass=lde['oldpassword_en'];
        newpass=lde['newpassword_en'];
        confirmpass=lde['confirmpassword_en'];
        resetpass=lde['resetpassword_en'];




      }
      else {

        language=currentlanguage;
        chnagepassword=lde['changepassword_ar'];
        oldpass=lde['oldpassword_ar'];
        newpass=lde['newpassword_ar'];
        confirmpass=lde['confirmpassword_ar'];
        resetpass=lde['resetpassword_ar'];



      }
    });







  }
}
