import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/baseProvider.dart';
import '../providers/userProvider.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextfield.dart';


class ResetPassword extends StatefulWidget {
  final String userId;
  const ResetPassword({Key? key, required this.userId}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool hasError = false;
  final _verifiedkey = GlobalKey<FormState>();
  final _passwordcontroller = TextEditingController();
  final _confirmcontroller = TextEditingController();
  final _pswdFocus = FocusNode();
  final _confirmFocus = FocusNode();


  String resetpassword="",password="",confirmpassword="",submit="";

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
        appBar: _getAppbar(),
        body: Form(
            key: _verifiedkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Image.asset("images/rsetpass.png",width: 200,height: 200,fit: BoxFit.fill,),



                  const SizedBox(height: 30),
                  // _getTitle(),
                  // const SizedBox(height: 30),
                  _password(),
                  _confirmPassword(),
                  const SizedBox(height: 15),
                  user.state == ViewState.Idle
                      ? _submitButton(user)
                      : const CircularProgressIndicator()
                ],
              ),
            )),
      );
    });
  }

  _getAppbar() {
    return AppBar(
      backgroundColor: Color(0xfff1efef),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color:Color(0xff106e3c)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(resetpassword,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Color(0xff106e3c)),),
      centerTitle: false,
    );
  }

  _getTitle() {
    return const Flexible(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "Reset password ",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _submitButton(UserProvider user) {
    return CustomButton(
      onPressed: () async {
        if (_verifiedkey.currentState!.validate()) {
          FocusManager.instance.primaryFocus!.unfocus();
          await user
              .updatePassword(widget.userId, _confirmcontroller.text.trim())
              .then((value) {
            // WidgetHelper.showToast(value);
            Navigator.of(context).pop();
          });
        }
      },
      text: submit,
    );
  }

  Widget _password() {
    return CustomTextField(
      icon: Icons.lock,
      isPassword: true,
      hintText: password,
      controller: _passwordcontroller,
      textInputAction: TextInputAction.next,
      focusNode: _pswdFocus,
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
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_confirmFocus);
      },
    );
  }

  Widget _confirmPassword() {
    return CustomTextField(
      icon: Icons.lock,
      isPassword: true,
      hintText: confirmpassword,
      controller: _confirmcontroller,
      textInputAction: TextInputAction.done,
      focusNode: _confirmFocus,
      validator: (val) {
        if (val!.isEmpty) {
          return "Field cannot be Empty";
        }
        if (_confirmcontroller.text.trim() != _passwordcontroller.text.trim()) {
          return "Passwords not match";
        } else {
          return null;
        }
      },
    );
  }


  Future<void> checkLanguage() async {

    String currentlanguage=await LanguageDatas.checkLanguage();
    Map lde= await LanguageDatas.getLanguageData();

    setState(() {

      if (currentlanguage.compareTo("en") == 0) {
        resetpassword=lde['reset_password_en'];
        password=lde['password_en'];
        confirmpassword=lde['confirmpassword_en'];
        submit=lde['submit_en'];


      }
      else{
        resetpassword=lde['reset_password_ar'];
        password=lde['password_ar'];
        confirmpassword=lde['confirmpassword_ar'];
        submit=lde['submit_ar'];

      }


    });












  }

}
