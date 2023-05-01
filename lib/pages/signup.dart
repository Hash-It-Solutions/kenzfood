import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:kenz_market_new/pages/phoneVerification.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


import '../config/color_palette.dart';
import '../providers/baseProvider.dart';
import '../providers/userProvider.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextfield.dart';
import '../widgets/widgetHelper.dart';

class SignUp extends StatefulWidget {
  static const routename = '/signup';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  //textediting controllers
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _usernamecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _mobilecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmcontroller = TextEditingController();

  //focus nodes

  final _lastnameFocus = FocusNode();
  final _userNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phnFocus = FocusNode();
  final _pswdFocus = FocusNode();
  final _confirmFocus = FocusNode();

  var countryCode = '+91';

  String createaccount = "",
      language = "",
      firstname = "",
      lastname = "",
      username = "",
      password = "",
      email = "",
      phonenumber = "",
      confirmpassword = "",
      signup = "",
      alreadyhaveaccount = "",
      login = "",
      infoalert="",yes="",no="",kenz="";

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
            title: Text(createaccount),
          ),
          body: Form(
            key: _formkey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _firstName(),
                    _lastName(),
                    _userName(),
                    _email(),
                    _phone(),
                    _password(),
                    _confirmPassword(),
                    const SizedBox(height: 25),
                    user.state == ViewState.Idle
                        ? _signUp(user)
                        : const CircularProgressIndicator(),
                    const SizedBox(height: 25),
                    user.state == ViewState.Idle
                        ? _alreadyHaveaccount()
                        : Container(),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ));
    });
  }

  Widget _firstName() {
    return CustomTextField(
      icon: Icons.person,
      hintText: firstname,
      controller: _firstnamecontroller,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return "Firstname cannot be empty";
        } else {
          return null;
        }
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_lastnameFocus);
      },
    );
  }

  Widget _lastName() {
    return CustomTextField(
      icon: Icons.person,
      hintText: lastname,
      controller: _lastnamecontroller,
      textInputAction: TextInputAction.next,
      focusNode: _lastnameFocus,
      validator: (value) {
        if (value!.isEmpty) {
          return "Username cannot be empty";
        } else {
          return null;
        }
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_userNameFocus);
      },
    );
  }

  Widget _userName() {
    return CustomTextField(
      icon: Icons.person,
      hintText: username,
      controller: _usernamecontroller,
      textInputAction: TextInputAction.next,
      focusNode: _userNameFocus,
      validator: (value) {
        if (value!.isEmpty) {
          return "Username cannot be empty";
        } else {
          return null;
        }
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_emailFocus);
      },
    );
  }

  Widget _email() {
    return CustomTextField(
      icon: Icons.email,
      hintText: email,
      controller: _emailcontroller,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocus,
      validator: (value) {
        if (EmailValidator.validate(value!.trim())) {
          return null;
        } else {
          return 'Invalid Email';
        }
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_phnFocus);
      },
    );
  }

  Widget _phone() {
    return CustomTextField(
      icon: Icons.phone,
      hintText: phonenumber,
      controller: _mobilecontroller,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      focusNode: _phnFocus,
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
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_pswdFocus);
      },
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

  Widget _signUp(UserProvider user) {
    return CustomButton(
        onPressed: () async {
          if (_formkey.currentState!.validate()) {
            //String phoneNumber = countryCode + _mobilecontroller.text.trim();


            Widget yesButton = TextButton(
                child: Text(yes,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?14:16:18),),
                onPressed: () async {

                  Navigator.pop(context);

                  await user
                      .isMobileNumExists(_mobilecontroller.text.trim())
                      .then((userModel) async {
                    if (userModel!.userModelReturn == "no user found") {
                      //  print("user not exists");
                      await user
                          .signUp(
                        firstName: _firstnamecontroller.text.trim(),
                        lastName: _lastnamecontroller.text.trim(),
                        userName: _usernamecontroller.text.trim(),
                        email: _emailcontroller.text.trim(),
                        phone: _mobilecontroller.text.trim(),
                        password: _confirmcontroller.text.trim(),
                      )
                          .then((userModel) {
                        if (userModel!.userModelReturn == "user added successfully") {
                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              child: PhoneVerification(
                                phoneNumber:
                                countryCode + _mobilecontroller.text.trim(),
                                pageKey: 'signUp',
                                userId: userModel.userId.toString(), code: '',
                              ),
                              type: PageTransitionType.leftToRightWithFade,
                            ),
                          );
                          // Navigator.of(context)
                          //     .pushNamed(PhoneVerification.routename);
                          // Navigator.of(context).pop();
                          // WidgetHelper.showToast("user added successfully");
                        } else {
                          WidgetHelper.showToast("Error occured");
                        }
                      });
                    } else {
                      // print("user  exists"); // showdialog user already exists
                      WidgetHelper.showToast("User Already Exists. Please Login ");
                    }
                  });


                });



            Widget noButton = TextButton(
              child: Text(no,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?14:16:18)),
              onPressed: () {
                Navigator.pop(context);
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text(kenz,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?14:16:18)),
              content: Text(infoalert,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?14:16:18)),
              actions: [yesButton, noButton],
            );

            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );



          }
        },
        text: signup);
  }

  Widget _alreadyHaveaccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          alreadyhaveaccount,
          style: TextStyle(fontSize: 15),
        ),
        Flexible(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              login,
              style: TextStyle(
                color: primarycolor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }

  checkLanguage() async {
    Map lde = await LanguageDatas.getLanguageData();

    String currentlanguage = await LanguageDatas.checkLanguage();

    setState(() {
      language = currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {
        language = currentlanguage;

        firstname = lde['firstname_en'];
        lastname = lde['lastname_en'];
        username = lde['username_en'];
        email = lde['emailid_en'];

        phonenumber = lde['telephonenumber_en'];
        password = lde['password_en'];
        confirmpassword = lde['confirmpassword_en'];

        signup = lde['signup_en'];
        alreadyhaveaccount = lde['alreadyhaveaccount_en'];

        login = lde['login_en'];
        createaccount = lde['createaccount_en'];
        yes = lde['yes_en'];
        no = lde['No_en'];
        kenz = lde['kenz_food_en'];
        infoalert=lde['infoalert_en'];



      } else {
        language = currentlanguage;

        firstname = lde['firstname_ar'];
        lastname = lde['lastname_ar'];
        username = lde['username_ar'];
        email = lde['emailid_ar'];

        phonenumber = lde['telephonenumber_ar'];
        password = lde['password_ar'];
        confirmpassword = lde['confirmpassword_ar'];

        signup = lde['signup_ar'];
        alreadyhaveaccount = lde['alreadyhaveaccount_ar'];

        login = lde['login_ar'];

        createaccount = lde['createaccount_ar'];

        yes = lde['Yes_ar'];
        no = lde['No_ar'];
        kenz = lde['kenz_food_ar'];

        infoalert=lde['infoalert_ar'];

      }
    });
  }
}
