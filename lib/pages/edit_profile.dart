import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


import 'package:provider/provider.dart';

import '../providers/baseProvider.dart';
import '../providers/userProvider.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../widgets/widgetHelper.dart';
import 'deactivate_account.dart';
import 'forgotPassword.dart';

class EditProfile extends StatefulWidget {
  const EditProfile() : super();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isloading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  File? image;

  String yes = "",
      no = "",
      kenz = "",
      msg = "",
      language = "",
      editprofile = "",
      fname = "",
      lname = "",
      submit = "",
      update = "",
      mobilenumber = "",
      emailid = "",
      changepassword = "",
      deactivateacc = "",
  photousagewarnin="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    setData();
  }

  setData() {
    setState(() {
      _isloading = true;
    });
    final user = Provider.of<UserProvider>(context, listen: false)
        .getUserDetails()
        .then((user) {
      fnamecontroller.text = user == null ? '' : user.firstname ?? '';
      lnamecontroller.text = user == null ? '' : user.lastname ?? '';
      emailcontroller.text = user == null ? '' : user.email ?? '';
      phonecontroller.text = user == null ? '' : user.phone ?? '';

      setState(() {
        _isloading = false;
      });
    });
  }

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);

      setState(() {
        this.image = tempImage;
      });
    } on PlatformException catch (e) {
      WidgetHelper.showToast("failed to Pick Image $e");
    }
  }

  setProfilePic(UserProvider user) {
    if (user.userModel != null && image == null) {
      if (user.userModel!.profileUrl != null) {
        return NetworkImage(user.userModel!.profileUrl!);
      } else {
        return image != null
            ? FileImage(File(image!.path),
                scale: ResponsiveInfo.isMobile(context)
                    ? ResponsiveInfo.isSmallMobile(context)
                        ? 100
                        : 130
                    : 160)
            : NetworkImage(
                "https://pbs.twimg.com/profile_images/1257280933557710850/95taFO3E_400x400.jpg",
                scale: ResponsiveInfo.isMobile(context)
                    ? ResponsiveInfo.isSmallMobile(context)
                        ? 100
                        : 130
                    : 160);
      }
    } else {
      return image != null
          ? FileImage(File(image!.path),
              scale: ResponsiveInfo.isMobile(context)
                  ? ResponsiveInfo.isSmallMobile(context)
                      ? 100
                      : 130
                  : 160)
          : NetworkImage(
              "https://pbs.twimg.com/profile_images/1257280933557710850/95taFO3E_400x400.jpg",
              scale: ResponsiveInfo.isMobile(context)
                  ? ResponsiveInfo.isSmallMobile(context)
                      ? 100
                      : 130
                  : 160);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, _) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Color(0xffe5e8e8),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff05ac54)),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              editprofile,
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
          body: _isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Stack(
                        //   children: [
                        //     Align(
                        //       alignment: FractionalOffset.topCenter,
                        //       child: Padding(
                        //           padding: EdgeInsets.all(2),
                        //           child: Container(
                        //             height: ResponsiveInfo.isMobile(context)
                        //                 ? ResponsiveInfo.isSmallMobile(context)
                        //                     ? 120
                        //                     : 150
                        //                 : 180,
                        //             width: ResponsiveInfo.isMobile(context)
                        //                 ? ResponsiveInfo.isSmallMobile(context)
                        //                     ? 120
                        //                     : 150
                        //                 : 180,
                        //             child: Stack(children: [
                        //               Align(
                        //                   alignment:
                        //                       FractionalOffset.bottomCenter,
                        //                   child: Container(
                        //                       height: ResponsiveInfo.isMobile(
                        //                               context)
                        //                           ? ResponsiveInfo
                        //                                   .isSmallMobile(
                        //                                       context)
                        //                               ? 100
                        //                               : 130
                        //                           : 160,
                        //                       width: ResponsiveInfo.isMobile(
                        //                               context)
                        //                           ? ResponsiveInfo
                        //                                   .isSmallMobile(
                        //                                       context)
                        //                               ? 100
                        //                               : 130
                        //                           : 160,
                        //                       child: CircleAvatar(
                        //                         backgroundImage:
                        //                             setProfilePic(user),
                        //
                        //                         // child: Image.network(
                        //                         //   DataConstants.profileimgbaseurl+profileimage,
                        //                         //   fit: BoxFit.fill,
                        //                         //   errorBuilder: (context, url, error) => new Icon(Icons.account_circle_rounded,size: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?90:120:160,),
                        //                         // ),
                        //                       )
                        //
                        //                       // child:Image.asset("images/user.png")
                        //                       )),
                        //               Align(
                        //                   alignment:
                        //                       FractionalOffset.bottomCenter,
                        //                   child: Padding(
                        //                     padding: ResponsiveInfo.isMobile(
                        //                             context)
                        //                         ? ResponsiveInfo.isSmallMobile(
                        //                                 context)
                        //                             ? EdgeInsets.fromLTRB(
                        //                                 45, 0, 0, 0)
                        //                             : EdgeInsets.fromLTRB(
                        //                                 60, 0, 0, 0)
                        //                         : EdgeInsets.fromLTRB(
                        //                             80, 0, 0, 0),
                        //                     child: FloatingActionButton(
                        //                       onPressed: () async {
                        //
                        //
                        //                         Widget yesButton = TextButton(
                        //                             child: Text(yes,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?14:16:18),),
                        //                             onPressed: () async {
                        //
                        //                               Navigator.pop(context);
                        //
                        //                               _pickImage();
                        //
                        //
                        //                             });
                        //
                        //
                        //
                        //                         Widget noButton = TextButton(
                        //                           child: Text(no,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?14:16:18)),
                        //                           onPressed: () {
                        //                             Navigator.pop(context);
                        //                           },
                        //                         );
                        //
                        //                         // set up the AlertDialog
                        //                         AlertDialog alert = AlertDialog(
                        //                           title: Text(kenz,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?14:16:18)),
                        //                           content: Text(photousagewarnin,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?14:16:18)),
                        //                           actions: [yesButton, noButton],
                        //                         );
                        //
                        //                         // show the dialog
                        //                         showDialog(
                        //                           context: context,
                        //                           builder: (BuildContext context) {
                        //                             return alert;
                        //                           },
                        //                         );
                        //
                        //
                        //
                        //
                        //
                        //                         // Widget yesButton = TextButton(
                        //                         //     child: Text(
                        //                         //       yes,
                        //                         //       style: TextStyle(
                        //                         //           fontSize: ResponsiveInfo
                        //                         //                   .isMobile(context)
                        //                         //               ? ResponsiveInfo
                        //                         //                       .isSmallMobile(
                        //                         //                           context)
                        //                         //                   ? 12
                        //                         //                   : 14
                        //                         //               : 17),
                        //                         //     ),
                        //                         //     onPressed: () async {});
                        //
                        //                         // Widget noButton = TextButton(
                        //                         //   child: Text(no,
                        //                         //       style: TextStyle(
                        //                         //           fontSize: ResponsiveInfo
                        //                         //                   .isMobile(context)
                        //                         //               ? ResponsiveInfo
                        //                         //                       .isSmallMobile(
                        //                         //                           context)
                        //                         //                   ? 12
                        //                         //                   : 14
                        //                         //               : 17)),
                        //                         //   onPressed: () {
                        //                         //     Navigator.pop(context);
                        //                         //   },
                        //                         // );
                        //
                        //                         // // set up the AlertDialog
                        //                         // AlertDialog alert = AlertDialog(
                        //                         //   title: Text(kenz,
                        //                         //       style: TextStyle(
                        //                         //           fontSize: ResponsiveInfo
                        //                         //                   .isMobile(context)
                        //                         //               ? ResponsiveInfo
                        //                         //                       .isSmallMobile(
                        //                         //                           context)
                        //                         //                   ? 12
                        //                         //                   : 14
                        //                         //               : 17)),
                        //                         //   content: Text(msg,
                        //                         //       style: TextStyle(
                        //                         //           fontSize: ResponsiveInfo
                        //                         //                   .isMobile(context)
                        //                         //               ? ResponsiveInfo
                        //                         //                       .isSmallMobile(
                        //                         //                           context)
                        //                         //                   ? 12
                        //                         //                   : 14
                        //                         //               : 17)),
                        //                         //   actions: [yesButton, noButton],
                        //                         // );
                        //
                        //                         // // show the dialog
                        //                         // showDialog(
                        //                         //   context: context,
                        //                         //   builder: (BuildContext context) {
                        //                         //     return alert;
                        //                         //   },
                        //                         // );
                        //                       },
                        //                       child: Icon(
                        //                         Icons.edit,
                        //                         color: Colors.white,
                        //                         size: 29,
                        //                       ),
                        //                       backgroundColor:
                        //                           Color(0xff05ac54),
                        //                       elevation: 5,
                        //                       splashColor: Colors.grey,
                        //                     ),
                        //                   ))
                        //             ]),
                        //           )),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                            padding: ResponsiveInfo.isMobile(context)
                                ? ResponsiveInfo.isSmallMobile(context)
                                    ? EdgeInsets.fromLTRB(14, 5, 14, 5)
                                    : EdgeInsets.fromLTRB(18, 5, 18, 5)
                                : EdgeInsets.fromLTRB(22, 5, 22, 5),

                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Theme(
                                data: new ThemeData(hintColor: Colors.black12),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    hintText: fname,
                                  ),
                                  onChanged: (text) {},
                                  controller: fnamecontroller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Firstname cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ))),
                        Padding(
                            padding: ResponsiveInfo.isMobile(context)
                                ? ResponsiveInfo.isSmallMobile(context)
                                    ? EdgeInsets.fromLTRB(14, 5, 14, 5)
                                    : EdgeInsets.fromLTRB(18, 5, 18, 5)
                                : EdgeInsets.fromLTRB(22, 5, 22, 5),

                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Theme(
                                data: new ThemeData(hintColor: Colors.black12),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    hintText: lname,
                                  ),
                                  onChanged: (text) {},
                                  controller: lnamecontroller,
                                ))),

                        //!!MOB
                        Padding(
                            padding: ResponsiveInfo.isMobile(context)
                                ? ResponsiveInfo.isSmallMobile(context)
                                    ? EdgeInsets.fromLTRB(14, 5, 14, 5)
                                    : EdgeInsets.fromLTRB(18, 5, 18, 5)
                                : EdgeInsets.fromLTRB(22, 5, 22, 5),

                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Theme(
                                data: new ThemeData(hintColor: Colors.black12),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    hintText: mobilenumber,
                                  ),
                                  onChanged: (text) {},
                                  controller: phonecontroller,
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
                                ))),
                        //!!EMAIL
                        Padding(
                            padding: ResponsiveInfo.isMobile(context)
                                ? ResponsiveInfo.isSmallMobile(context)
                                    ? EdgeInsets.fromLTRB(14, 5, 14, 5)
                                    : EdgeInsets.fromLTRB(18, 5, 18, 5)
                                : EdgeInsets.fromLTRB(22, 5, 22, 5),

                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Theme(
                                data: new ThemeData(hintColor: Colors.black12),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    hintText: emailid,
                                  ),
                                  onChanged: (text) {},
                                  controller: emailcontroller,
                                  validator: (value) {
                                    if (EmailValidator.validate(
                                        value!.trim())) {
                                      return null;
                                    } else {
                                      return 'Invalid Email';
                                    }
                                  },
                                ))),

                        //!!phone old
                        // Padding(
                        //     padding: ResponsiveInfo.isMobile(context)
                        //         ? ResponsiveInfo.isSmallMobile(context)
                        //             ? EdgeInsets.fromLTRB(14, 5, 14, 5)
                        //             : EdgeInsets.fromLTRB(18, 5, 18, 5)
                        //         : EdgeInsets.fromLTRB(22, 5, 22, 5),

                        //     //padding: EdgeInsets.symmetric(horizontal: 15),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           border: Border.all(color: Colors.black12)),
                        //       width: double.infinity,
                        //       height: ResponsiveInfo.isMobile(context)
                        //           ? ResponsiveInfo.isSmallMobile(context)
                        //               ? 50
                        //               : 60
                        //           : 75,
                        //       child: Row(
                        //           textDirection: TextDirection.ltr,
                        //           mainAxisSize: MainAxisSize.max,
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: <Widget>[
                        //             Expanded(
                        //                 child: Padding(
                        //                   padding: ResponsiveInfo.isMobile(context)
                        //                       ? ResponsiveInfo.isSmallMobile(context)
                        //                           ? EdgeInsets.fromLTRB(5, 20, 5, 5)
                        //                           : EdgeInsets.fromLTRB(10, 25, 10, 10)
                        //                       : EdgeInsets.fromLTRB(15, 30, 15, 5),
                        //                   //padding: EdgeInsets.symmetric(horizontal: 15),
                        //                   child: new Theme(
                        //                       data: new ThemeData(
                        //                           hintColor: Colors.black12),
                        //                       child: TextFormField(
                        //                         decoration: InputDecoration(
                        //                           border: InputBorder.none,
                        //                           hintText: mobilenumber,
                        //                         ),
                        //                         onChanged: (text) {},
                        //                         controller: phonecontroller,
                        //                         validator: (value) {
                        //                           if (value!.isEmpty) {
                        //                             return "Enter your Mobile number";
                        //                           }
                        //                           if (value.length < 7) {
                        //                             return "Enter a valid phone number";
                        //                           } else {
                        //                             return null;
                        //                           }
                        //                         },
                        //                       )),
                        //                 ),
                        //                 flex: 3),
                        //             Expanded(
                        //               child: Text(update,
                        //                   style: TextStyle(
                        //                       color: Color(0xff05ac54),
                        //                       fontSize: ResponsiveInfo.isMobile(context)
                        //                           ? ResponsiveInfo.isSmallMobile(
                        //                                   context)
                        //                               ? 11
                        //                               : 14
                        //                           : 17)),
                        //               flex: 1,
                        //             ),
                        //           ]),
                        //     )),
                        //!!email old
                        // Padding(
                        //     padding: ResponsiveInfo.isMobile(context)
                        //         ? ResponsiveInfo.isSmallMobile(context)
                        //             ? EdgeInsets.fromLTRB(14, 5, 14, 5)
                        //             : EdgeInsets.fromLTRB(18, 5, 18, 5)
                        //         : EdgeInsets.fromLTRB(22, 5, 22, 5),

                        //     //padding: EdgeInsets.symmetric(horizontal: 15),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           border: Border.all(color: Colors.black12)),
                        //       width: double.infinity,
                        //       height: ResponsiveInfo.isMobile(context)
                        //           ? ResponsiveInfo.isSmallMobile(context)
                        //               ? 50
                        //               : 60
                        //           : 75,
                        //       child: Row(
                        //           textDirection: TextDirection.ltr,
                        //           mainAxisSize: MainAxisSize.max,
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: <Widget>[
                        //             Expanded(
                        //                 child: Padding(
                        //                   padding: ResponsiveInfo.isMobile(context)
                        //                       ? ResponsiveInfo.isSmallMobile(context)
                        //                           ? EdgeInsets.fromLTRB(5, 20, 5, 5)
                        //                           : EdgeInsets.fromLTRB(10, 25, 10, 10)
                        //                       : EdgeInsets.fromLTRB(15, 30, 15, 5),
                        //                   //padding: EdgeInsets.symmetric(horizontal: 15),
                        //                   child: new Theme(
                        //                       data: new ThemeData(
                        //                           hintColor: Colors.black12),
                        //                       child: TextFormField(
                        //                         decoration: InputDecoration(
                        //                           border: InputBorder.none,
                        //                           hintText: emailid,
                        //                         ),
                        //                         onChanged: (text) {},
                        //                         controller: emailcontroller,
                        //                         validator: (value) {
                        //                           if (EmailValidator.validate(
                        //                               value!.trim())) {
                        //                             return null;
                        //                           } else {
                        //                             return 'Invalid Email';
                        //                           }
                        //                         },
                        //                       )),
                        //                 ),
                        //                 flex: 3),
                        //             Expanded(
                        //               child: Text(update,
                        //                   style: TextStyle(
                        //                       color: Color(0xff05ac54),
                        //                       fontSize: ResponsiveInfo.isMobile(context)
                        //                           ? ResponsiveInfo.isSmallMobile(
                        //                                   context)
                        //                               ? 11
                        //                               : 14
                        //                           : 17)),
                        //               flex: 1,
                        //             ),
                        //           ]),
                        //     )),
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
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                        user.updateProfile(
                                          image,
                                          fnamecontroller.text.trim(),
                                          lnamecontroller.text.trim(),
                                          emailcontroller.text.trim(),
                                          phonecontroller.text.trim(),
                                        );
                                      }

                                      // Navigator.push(
                                      //     context, MaterialPageRoute(builder: (_) => Otppage(title: "Otp",)));

                                      // TemRegData trmg=new TemRegData(namecontroller.value.text,emailcontroller.value.text
                                      // ,dropdownValue,dropdownstate,mobilecontroller.value.text,sponsermobilecontroller.value.text,passwordcontroller.value.text,languagedropdown);
                                    },
                                    child: Text(
                                      submit,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ResponsiveInfo.isMobile(
                                                  context)
                                              ? ResponsiveInfo.isSmallMobile(
                                                      context)
                                                  ? 12
                                                  : 14
                                              : 17),
                                    ),
                                  ),
                                ),
                        ),

                        Padding(
                            padding: ResponsiveInfo.isMobile(context)
                                ? ResponsiveInfo.isSmallMobile(context)
                                    ? EdgeInsets.fromLTRB(14, 5, 14, 5)
                                    : EdgeInsets.fromLTRB(18, 5, 18, 5)
                                : EdgeInsets.fromLTRB(22, 5, 22, 5),

                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: user.state == ViewState.Busy
                                ? Container()
                                : Row(
                                    textDirection: TextDirection.ltr,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //Center Row contents horizontally,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                        Expanded(
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              ForgotPassword()
                                                          //ChangePassword(),
                                                          ));
                                                },
                                                child: Text(
                                                  changepassword,
                                                  style: TextStyle(
                                                      color: Color(0xff71b990),
                                                      fontSize: ResponsiveInfo
                                                              .isMobile(context)
                                                          ? ResponsiveInfo
                                                                  .isSmallMobile(
                                                                      context)
                                                              ? 12
                                                              : 14
                                                          : 17),
                                                )),
                                            flex: 1),
                                        Expanded(
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              DeactivateAccount()));
                                                },
                                                child: Text(
                                                  deactivateacc,
                                                  style: TextStyle(
                                                      color: Color(0xff71b990),
                                                      fontSize: ResponsiveInfo
                                                              .isMobile(context)
                                                          ? ResponsiveInfo
                                                                  .isSmallMobile(
                                                                      context)
                                                              ? 12
                                                              : 14
                                                          : 17),
                                                )),
                                            flex: 1),
                                      ])),
                      ],
                    ),
                  ),
                ));
    });
  }

  checkLanguage() async {
    Map lde = await LanguageDatas.getLanguageData();

    String currentlanguage = await LanguageDatas.checkLanguage();

    setState(() {
      language = currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {
        language = currentlanguage;

        editprofile = lde['editprofile_en'];
        fname = lde['firstname_en'];
        lname = lde['lastname_en'];
        submit = lde['submit_en'];

        update = lde['update_en'];
        mobilenumber = lde['mobile_en'];
        emailid = lde['emailid_en'];

        changepassword = lde['changepassword_en'];
        deactivateacc = lde['deactivateacc_en'];

        yes = lde['yes_en'];
        no = lde['No_en'];
        kenz = lde['kenz_food_en'];
        msg = lde['profilemsg_en'];
        photousagewarnin=lde['photosecurewarning_en'];
      } else {
        language = currentlanguage;
        editprofile = lde['editprofile_ar'];
        fname = lde['firstname_ar'];
        lname = lde['lastname_ar'];
        submit = lde['submit_ar'];

        update = lde['update_ar'];
        mobilenumber = lde['mobile_ar'];
        emailid = lde['emailid_ar'];

        changepassword = lde['changepassword_ar'];
        deactivateacc = lde['deactivateacc_ar'];

        yes = lde['Yes_ar'];
        no = lde['No_ar'];
        kenz = lde['kenz_food_ar'];
        msg = lde['profilemsg_ar'];
        photousagewarnin=lde['photosecurewarning_ar'];
      }
    });
  }
}
