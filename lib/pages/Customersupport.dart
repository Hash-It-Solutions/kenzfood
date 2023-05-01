import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import '../utils/Staticvalues.dart';


class CustomerSupport extends StatefulWidget {
  @override
  _CustomerSupport createState() => _CustomerSupport();


}


class _CustomerSupport extends State<CustomerSupport> {

  bool isclicked=false;


  String language="",customersupport="",contactus="",whatsapp="",chat="";

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
  }




  @override
  Widget build(BuildContext context) {


    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(

        resizeToAvoidBottomInset: true,

        appBar:  AppBar(
          backgroundColor: Color(0xff05ac54),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(customersupport,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25),),
          centerTitle: false,
        ),

        body: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [


            Padding(padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5) : EdgeInsets.all(11) : EdgeInsets.all(18),

            child: GestureDetector(


              child:  Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 0),
                    borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                  ),
                  child: GestureDetector(

                    onTap: (){

                      setState(() {


                        if(!isclicked)
                        {
                          isclicked = true;
                        }
                        else {
                          isclicked = false;
                        }
                      });


                    },

                    child:  Container(
                        height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?50:65:85,
                        width: double.infinity,

                        child:

                        Row(
                            children: [
                              Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context) ? EdgeInsets.all(10):EdgeInsets.all(16):EdgeInsets.all(22),



                                child:   Image.asset("images/telephone.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 25:33:50 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 25:33:50 ,fit: BoxFit.fill
                                  ),







                                ),



                              Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 10):EdgeInsets.only(left: 16):EdgeInsets.only(left: 22),



                                child:

                                    SizedBox(


                                      child:   Text(contactus,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.black54),maxLines: 2,),


                                    )












                              )

                            ],
                          ),




                    ) ,
                  )




              ),

              onTap: (){

                setState(() {


                  if(!isclicked)
                  {
                    isclicked = true;
                  }
                  else {
                    isclicked = false;
                  }
                });
              },
            )




            ),

            (isclicked)?  Padding(padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(10) : EdgeInsets.all(18) : EdgeInsets.all(25),


      child: Column(

        children: [

          GestureDetector(

            child:   Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 0),
                  borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                ),
                child: Container(
                  width: double.infinity,
                  height:  ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?60:70:85,
                  child: TextButton(

                    onPressed: ()async {


                      String url = "tel:"+Staticvalues.contactno.toString();
                      if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      } else {
                      throw 'Could not launch $url';
                      }

                    },
                    child: Text(Staticvalues.contactno,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.black),maxLines: 2,),

                  ),


                )




            ),
            onTap: ()async{

              String url = "tel:"+Staticvalues.contactno.toString();
              if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
              } else {
              throw 'Could not launch $url';
              }
            },
          )




        ],


      ),
    ) : Container(),



            Padding(padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5) : EdgeInsets.all(11) : EdgeInsets.all(18),

                child: GestureDetector(


                  child:  Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 0),
                        borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                      ),
                      child: GestureDetector(

                        onTap: ()async{


                          String url="https://api.whatsapp.com/send?phone="+Staticvalues.whatsappno.toString();

                          var encoded = Uri.encodeFull(url);

                          if (await canLaunchUrl(Uri.parse(encoded))) {
                          await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
                          } else {
                          throw 'Could not launch $url';
                          }




                        },

                        child:  Container(
                          height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?50:65:85,
                          width: double.infinity,

                          child:

                          Row(
                            children: [
                              Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context) ? EdgeInsets.all(10):EdgeInsets.all(16):EdgeInsets.all(22),



                                child:   Image.asset("images/whatsapp.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 25:33:50 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 25:33:50 ,fit: BoxFit.fill
                                ),







                              ),



                              Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 10):EdgeInsets.only(left: 16):EdgeInsets.only(left: 22),



                                  child:

                                  SizedBox(


                                    child:   Text(whatsapp,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.black54),maxLines: 2,),


                                  )












                              )

                            ],
                          ),




                        ) ,
                      )




                  ),

                  onTap: ()async{

                    String url="https://api.whatsapp.com/send?phone="+Staticvalues.whatsappno.toString();

                    var encoded = Uri.encodeFull(url);

                    if (await canLaunchUrl(Uri.parse(encoded))) {
                    await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
                    } else {
                    throw 'Could not launch $url';
                    }
                  },
                )




            ),


            Padding(padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(5) : EdgeInsets.all(11) : EdgeInsets.all(18),

                child: GestureDetector(


                  child:  Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 0),
                        borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                      ),
                      child: GestureDetector(

                        onTap: (){




                        },

                        child:  Container(
                          height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?50:65:85,
                          width: double.infinity,

                          child:

                          Row(
                            children: [
                              Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context) ? EdgeInsets.all(10):EdgeInsets.all(16):EdgeInsets.all(22),



                                child:   Image.asset("images/chat.png",width:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 25:33:50 ,height: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 25:33:50 ,fit: BoxFit.fill
                                ),







                              ),



                              Padding(padding:ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.only(left: 10):EdgeInsets.only(left: 16):EdgeInsets.only(left: 22),



                                  child:

                                  SizedBox(


                                    child:   Text(chat,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?12:14:17,color: Colors.black54),maxLines: 2,),


                                  )












                              )

                            ],
                          ),




                        ) ,
                      )




                  ),

                  onTap: (){


                  },
                )




            ),








          ],
        )








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
        contactus=lde['contactus_en'];
        whatsapp=lde['whatsapp_en'];
        chat=lde['chat_en'];
        customersupport=lde['customersupport_en'];


      }
      else {

        language=currentlanguage;
        contactus=lde['contactus_ar'];
        whatsapp=lde['whatsapp_ar'];
        chat=lde['chat_ar'];
        customersupport=lde['customersupport_ar'];


      }
    });







  }


}
