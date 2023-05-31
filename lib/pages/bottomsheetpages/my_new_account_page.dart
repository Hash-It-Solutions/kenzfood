import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kenz_market_new/pages/voucher_list.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../config/constant.dart';
import '../../models/userReturnModel.dart';
import '../../providers/userProvider.dart';
import '../../utils/LanguageValues.dart';
import '../../utils/ResponsiveInfo.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../utils/ServerConstants.dart';
import '../../utils/Staticvalues.dart';
import '../../widgets/widgetHelper.dart';
import '../deactivate_account.dart';
import '../edit_profile.dart';
import '../forgotPassword.dart';
import '../group_chat_screen.dart';
import '../myorders.dart';
import '../resetPassword.dart';
import '../resorce_web.dart';
import '../user_address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:zendesk_messaging/zendesk_messaging.dart';



class MyNewAccountPage extends StatefulWidget {
  const MyNewAccountPage() : super();

  @override
  _MyNewAccountPageState createState() => _MyNewAccountPageState();


}

class _MyNewAccountPageState extends State<MyNewAccountPage> {


  List<String>menuitems=["Edit Profile","My Address","Chat","My Orders","My Wishlist","Vouchers",   "Language"  ,  "Terms and Condition","Privacy Policy","Logout","Delete Account"];

  List<String>menuimages=["images/edtprofile.png","images/map.png","images/mychat.png", "images/myorders.png","images/wishlist.png","images/myvouchers.png","images/language.png","images/terms.png","images/ppo.png","images/logout.png","images/deleteacc.png"];

 File ?image;
 bool _isloading=false;
 UserModel? usm;

 String kenz="",yes="",no="",logoutmsg="",profilemsg="";
  static const String androidChannelKey = "your android key";
  static const String iosChannelKey = "your iOS key";

  final List<String> channelMessages = [];

  bool isLogin=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
    checkLanguage();

    ZendeskMessaging.initialize(
      androidChannelKey: androidChannelKey,
      iosChannelKey: iosChannelKey,
    );

    ZendeskMessaging.setMessageHandler((type, arguments) {
      setState(() {
        // channelMessages.add("$type - args=$arguments");
      });
    });


  }


  void _login() {
    // You can attach local observer when calling some methods to be notified when ready
    ZendeskMessaging.loginUserCallbacks(
      jwt: "my_jwt",
      onSuccess: (id, externalId) => setState(() {
        channelMessages.add("Login observer - SUCCESS: $id, $externalId");
        isLogin = true;

        ZendeskMessaging.show();
      }),
      onFailure: () => setState(() {
        channelMessages.add("Login observer - FAILURE!");
        isLogin = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return    Consumer<UserProvider>(builder: (context, user, _)
    {
      return Scaffold(

        body: Container(

            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(50 * fem),
            ),
            child: SingleChildScrollView(

              child: Stack(
                children: [

                  Align(
                      alignment: FractionalOffset.topCenter,

                      child: Padding(

                        padding: EdgeInsets.all(10),
                        child: Card(


                            child: Container(
                              width: double.infinity,


                              child:

                              Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Container(

                                    height: ResponsiveInfo.isMobile(context)
                                        ? ResponsiveInfo.isSmallMobile(context)
                                        ? 120
                                        : 150
                                        : 180,
                                    width: ResponsiveInfo.isMobile(context)
                                        ? ResponsiveInfo.isSmallMobile(context)
                                        ? 120
                                        : 150
                                        : 180,

                                    child: Stack(children: [

                                      Align(
                                          alignment: FractionalOffset
                                              .bottomCenter,

                                          child:

                                          Container(
                                              height: ResponsiveInfo.isMobile(
                                                  context) ? ResponsiveInfo
                                                  .isSmallMobile(context)
                                                  ? 100
                                                  : 130 : 160,
                                              width: ResponsiveInfo.isMobile(
                                                  context) ? ResponsiveInfo
                                                  .isSmallMobile(context)
                                                  ? 100
                                                  : 130 : 160,

                                              child: CircleAvatar(
                                                backgroundImage: setProfilePic(
                                                    user),


                                                // child: Image.network(
                                                //   DataConstants.profileimgbaseurl+profileimage,
                                                //   fit: BoxFit.fill,
                                                //   errorBuilder: (context, url, error) => new Icon(Icons.account_circle_rounded,size: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)?90:120:160,),
                                                // ),


                                              )

                                            // child:Image.asset("images/user.png")
                                          )),


                                      Align(
                                          alignment: FractionalOffset
                                              .bottomCenter,
                                          child: Padding(

                                            padding: ResponsiveInfo.isMobile(
                                                context)
                                                ? ResponsiveInfo.isSmallMobile(
                                                context)
                                                ? EdgeInsets.fromLTRB(45, 0, 0, 0)
                                                : EdgeInsets.fromLTRB(60, 0, 0, 0)
                                                : EdgeInsets.fromLTRB(
                                                80, 0, 0, 0),

                                            child: FloatingActionButton(
                                              onPressed: () async {
                                                Widget yesButton = TextButton(
                                                    child: Text(yes,
                                                      style: TextStyle(
                                                          fontSize: ResponsiveInfo
                                                              .isMobile(context)
                                                              ? ResponsiveInfo
                                                              .isSmallMobile(
                                                              context) ? 14 : 16
                                                              : 18),),
                                                    onPressed: () async {
                                                      Navigator.pop(context);

                                                      _pickImage();


                                                    });


                                                Widget noButton = TextButton(
                                                  child: Text(no,
                                                      style: TextStyle(
                                                          fontSize: ResponsiveInfo
                                                              .isMobile(context)
                                                              ? ResponsiveInfo
                                                              .isSmallMobile(
                                                              context) ? 14 : 16
                                                              : 18)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                );

                                                // set up the AlertDialog
                                                AlertDialog alert = AlertDialog(
                                                  title: Text(kenz,
                                                      style: TextStyle(
                                                          fontSize: ResponsiveInfo
                                                              .isMobile(context)
                                                              ? ResponsiveInfo
                                                              .isSmallMobile(
                                                              context) ? 14 : 16
                                                              : 18)),
                                                  content: Text(
                                                      profilemsg,
                                                      style: TextStyle(
                                                          fontSize: ResponsiveInfo
                                                              .isMobile(context)
                                                              ? ResponsiveInfo
                                                              .isSmallMobile(
                                                              context) ? 14 : 16
                                                              : 18)),
                                                  actions: [yesButton, noButton],
                                                );

                                                // show the dialog
                                                showDialog(
                                                  context: context,
                                                  builder: (
                                                      BuildContext context) {
                                                    return alert;
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.mode_edit_outlined,
                                                color: Color(0xff01713D),
                                                size: 20,
                                              ),
                                              backgroundColor: Colors.white,
                                              tooltip: 'Capture Picture',
                                              elevation: 5,
                                              splashColor: Colors.grey,
                                              mini: true,
                                            ),
                                          )


                                      )
                                    ]),
                                  )


                              ),
                            )
                        ),
                      )


                  ),

                  Align(

                    alignment: FractionalOffset.topCenter,

                    child: Padding(

                      padding: EdgeInsets.only(
                          top: ResponsiveInfo.isMobile(context) ? 240 : 290,
                          left: 10,
                          right: 10),

                      child: ListView.builder(
                          itemCount: menuimages.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(padding: EdgeInsets.all(10),


                                child: GestureDetector(

                                  child: Container(
                                      width: double.infinity,

                                      // color: Colors.black12,

                                      decoration: BoxDecoration(
                                        color: Color(0xffe3e3e3),
                                        borderRadius: BorderRadius.circular(10.0),

                                        border: Border.all(
                                          color: Color(0xffe3e3e3),


                                        ),
                                        // borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)?20:40))


                                      ),

                                      child: ListTile(

                                        leading: Image.asset(
                                          menuimages[index], width: 20,
                                          height: 20,
                                          fit: BoxFit.fill,),
                                        title: Text(
                                          menuitems[index],
                                          style: TextStyle(
                                              color: Color(0xff363636),
                                              fontSize: 15,
                                              fontFamily: 'Poppins'),
                                        ),
                                        // title: Text("List item $index")),

                                      )),

                                  onTap: () async {
                                    switch (index) {


                                      case 0:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => EditProfile()));

                                        break;
                                      case 1:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    UserAddress("0")));

                                        break;

                                      case 2:

                                     //   _login();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => GroupChatScreen("", "id")));


                                        break;

                                      case 3:

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => MyordersPage(title: "My Orders")));

                                        break;


                                      case 4:

                                        final datastorage = await SharedPreferences.getInstance();

                                        datastorage.setString("wishlist","yes");
    

                                        break;

                                      case 5:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    VoucherList()
                                              //ChangePassword(),
                                            ));

                                        break;

                                      // case 6:
                                      //
                                      //   final datastorage =
                                      //   await SharedPreferences
                                      //       .getInstance();
                                      //
                                      //   String? userid=datastorage.getString("userid");
                                      //
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (_) =>
                                      //               ResetPassword(userId: userid.toString())
                                      //         //ChangePassword(),
                                      //       ));
                                      //
                                      //   break;


                                      case 6:



                                        Widget optionOne = SimpleDialogOption(
                                          child: const Text('English'),
                                          onPressed: () async {
                                            final datastorage =
                                            await SharedPreferences
                                                .getInstance();

                                            datastorage.setString(
                                                Staticvalues.currentlanguage,
                                                Staticvalues.englishlanguagecode);

                                            // widget.callback("en");

                                            checkLanguage();

                                            Navigator.pop(context);
                                          },
                                        );
                                        Widget optionTwo = SimpleDialogOption(
                                          child: const Text('عربى'),
                                          onPressed: () async {
                                            final datastorage =
                                            await SharedPreferences
                                                .getInstance();
                                            datastorage.setString(
                                                Staticvalues.currentlanguage,
                                                Staticvalues.arabiclanguagecode);
                                            // widget.callback("Ar");
                                            checkLanguage();
                                            Navigator.pop(context);
                                          },
                                        );

                                        SimpleDialog dialog = SimpleDialog(
                                          title: const Text('Choose a language'),
                                          children: <Widget>[
                                            optionOne,
                                            optionTwo,
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return dialog;
                                          },
                                        );





                                        break;



                                      case 7:


                                        final result = await FlutterWebAuth.authenticate(url: "https://kenzfood.com/termsandconditions", callbackUrlScheme: "my-custom-app");

// Extract token from resulting url
                                        final token = Uri.parse(result).queryParameters['token'];

                                        break;


                                      case 8:

                                        final result = await FlutterWebAuth.authenticate(url: "http://kenzfood.com/privacypolicy", callbackUrlScheme: "my-custom-app");

// Extract token from resulting url
                                        final token = Uri.parse(result).queryParameters['token'];


                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) =>
                                        //             ResorceWeb("http://kenzfood.com/privacypolicy")
                                        //       //ChangePassword(),
                                        //     ));

                                        break;



                                      case 9:

                                        Widget yesButton = TextButton(
                                            child: Text(yes),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              // clearProductFromCart();
                                              setState(() {
                                                saveStringValue("token", "");
                                                apiToken = '';
                                                // getToken();
                                              });
                                            });

                                        Widget noButton = TextButton(
                                          child: Text(no),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        );

                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: Text(kenz),
                                          content: Text(logoutmsg),
                                          actions: [yesButton, noButton],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );


                                        break;

                                      case 10 :

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    DeactivateAccount()));

                                        break;


                                    }
                                  },
                                )


                            )

                            ;
                          }),
                    ),


                  ),


                ],
              ),
            )


        )
      );



    });
  }
  setData() {
    setState(() {
      _isloading = true;
    });
    final user = Provider.of<UserProvider>(context, listen: false)
        .getUserDetails()
        .then((use) {
      // fnamecontroller.text = user == null ? '' : user.firstname ?? '';
      // lnamecontroller.text = user == null ? '' : user.lastname ?? '';
      // emailcontroller.text = user == null ? '' : user.email ?? '';
      // phonecontroller.text = user == null ? '' : user.phone ?? '';

    usm=use;

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
      String apiToken = await getStringValue("token");

      var headers = {'x-access-token': apiToken};


      String url1=ServerConstants.baseurl+"update_user";

      // Map<String,String>mp={"username":name };

      print("url image path : "+  url1);

      print("Selected image path : "+  tempImage.path);


      // url1=ServerConstants.baseurl+ServerConstants.insertwholesaleuser;






      var url = Uri.parse(url1);
      var request = new http.MultipartRequest("PUT", url);
      // request.fields["firstname"]="";
      // request.fields["lastname"]="";
      // request.fields["email"]="";

      request.headers.addAll(headers);


      request.files.add(
          await http.MultipartFile.fromPath(
              "user_image",
              tempImage.path
          )
      );

      // request.files.add(
      //     await http.MultipartFile.fromPath(
      //         "document_url2",
      //         filepath2
      //     )
      // );
      // _progressDialog.dismissProgressDialog(context);

      final response = await request.send();

      print(response.statusCode);



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

  Future<void> checkLanguage() async {

    String currentlanguage=await LanguageDatas.checkLanguage();
    Map lde= await LanguageDatas.getLanguageData();
    setState(() {

      if (currentlanguage.compareTo("en") == 0) {
        yes=lde['yes_en'];
        no=lde['No_en'];
        logoutmsg=lde['logoutmsg_en'];
        kenz=lde['kenz_food_en'];
        profilemsg=lde['profilemsg_en'];

        menuitems=["Edit Profile","My Address","Chat","My Orders","My Wishlist","Vouchers", "Language"  ,  "Terms and Condition","Privacy Policy","Logout","Delete Account"];

      }
      else{
        yes=lde['Yes_ar'];
        no=lde['No_ar'];
        logoutmsg=lde['logoutmsg_ar'];
        kenz=lde['kenz_food_ar'];
        profilemsg=lde['profilemsg_ar'];
        menuitems=["تعديل الملف الشخصي","عنواني","محادثة","طلباتي","قائِمة أُمْنيّات","القسائم", "لغة"  ,  "الأحكام والشروط","سياسة الخصوصية","تسجيل خروج","حذف الحساب"];

      }


    });












  }
}
