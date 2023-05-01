import 'package:flutter/material.dart';



import 'package:provider/provider.dart';

import '../config/constant.dart';
import '../providers/baseProvider.dart';
import '../providers/userProvider.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import 'homescreen.dart';

class DeactivateAccount extends StatefulWidget {
  const DeactivateAccount() : super();

  @override
  _DeactivateAccountState createState() => _DeactivateAccountState();
}

class _DeactivateAccountState extends State<DeactivateAccount> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController oldpasswordcontroller = new TextEditingController();
  TextEditingController newpasswordcontroller = new TextEditingController();
  TextEditingController confirmpasswordcontroller = new TextEditingController();
  String language = "", oldpass = "", typedeactivate = "", deactivateacc = "";
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
        appBar: AppBar(
          backgroundColor: Color(0xffeeefef),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff05ac54)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            deactivateacc,
            style: TextStyle(
                fontSize: ResponsiveInfo.isTab(context)
                    ? ResponsiveInfo.isMobile(context)
                        ? ResponsiveInfo.isSmallMobile(context)
                            ? 14
                            : 17
                        : 20
                    : 25,

            color: Color(0xff05ac54)

            ),
          ),
          centerTitle: false,
        ),
        body: Form(
          key: _formkey,
          child: Column(
            children: [


              Image.asset("images/rset.png",width: 200,height: 200,fit: BoxFit.fill,),




              Padding(
                padding: ResponsiveInfo.isMobile(context)
                    ? ResponsiveInfo.isSmallMobile(context)
                        ? EdgeInsets.fromLTRB(14, 15, 14, 5)
                        : EdgeInsets.fromLTRB(18, 20, 18, 5)
                    : EdgeInsets.fromLTRB(22, 25, 22, 5),

                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: Theme(
                  data: new ThemeData(hintColor: Colors.black12),
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black54, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black54, width: 0.5),
                      ),
                      hintText: oldpass,
                    ),
                    onChanged: (text) {},
                    obscureText: true,
                    controller: oldpasswordcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (value.length < 5) {
                        return "Password too short";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),

              Padding(
                padding: ResponsiveInfo.isMobile(context)
                    ? ResponsiveInfo.isSmallMobile(context)
                        ? EdgeInsets.all(10)
                        : EdgeInsets.all(15)
                    : EdgeInsets.all(18),
                child: user.state == ViewState.Busy
                    ? const CircularProgressIndicator()
                    : Container(
                        height: ResponsiveInfo.isMobile(context)
                            ? ResponsiveInfo.isSmallMobile(context)
                                ? 40
                                : 60
                            : 75,
                        width: ResponsiveInfo.isMobile(context)
                            ? ResponsiveInfo.isSmallMobile(context)
                                ? 150
                                : 180
                            : 250,
                        decoration: BoxDecoration(
                            color: Color(0xff05ac54),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              FocusManager.instance.primaryFocus!.unfocus();
                              user
                                  .deactivateAccount(
                                      oldpasswordcontroller.text.trim())
                                  .then((response) {
                                if (response.statusCode == 200) {
                                  saveStringValue("token", "");
                                  apiToken = '';
                                }

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => Homescreen(0)));
                              });
                            }
                                                   },
                          child: Text(
                            deactivateacc,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }

  checkLanguage() async {
    Map lde = await LanguageDatas.getLanguageData();

    String currentlanguage = await LanguageDatas.checkLanguage();

    setState(() {
      language = currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {
        language = currentlanguage;

        deactivateacc = lde['deactivateacc_en'];
        oldpass = lde['oldpassword_en'];
        typedeactivate = lde['typedeactivate_en'];
      } else {
        language = currentlanguage;

        deactivateacc = lde['deactivateacc_ar'];
        oldpass = lde['oldpassword_ar'];
        typedeactivate = lde['typedeactivate_ar'];
      }
    });
  }
}
