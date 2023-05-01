import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../utils/ResponsiveInfo.dart';
import '../utils/ServerConstants.dart';
import '../widgets/widgetHelper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:custom_progress_dialog/custom_progress_dialog.dart';

class UploadProof extends StatefulWidget {

  String name="",email="",mobile="";




   UploadProof(this.name,this.email,this.mobile) ;

  @override
  _UploadProofState createState() => _UploadProofState(this.name,this.email,this.mobile);
}

class _UploadProofState extends State<UploadProof> {


  String name="",email="",mobile="";
  _UploadProofState(this.name,this.email,this.mobile);
   // late File file1,file2;
   
   String filepath1="",filepath2="";


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


      body: SingleChildScrollView(

        child: Form(

          child: Center(

            child: Column(

              children: [



                Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?130:ResponsiveInfo.isSmallMobile(context)?100:160),

                  child:  Text("Upload Your Address Proof",textAlign : TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?23:ResponsiveInfo.isSmallMobile(context)?19:26,color: Color(0xff01713D),fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),


                ),

                Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?20:ResponsiveInfo.isSmallMobile(context)?25:35),

                  child:  Row(

                    children: [


                      Expanded(child:GestureDetector(


                      child:Card(

                        child: Padding(padding: EdgeInsets.all(8),


                          child:


                          Column(

                            children: [


                              Padding(padding: EdgeInsets.all(15),


                                child: (filepath1.isNotEmpty)?

                                Stack(

                                  children: [

                                    Align(

                                      alignment: FractionalOffset.center,

                                      child: Container(
                                          child: Image.file(new File(filepath1),scale: 5,),
                                          width: ResponsiveInfo.isMobile(context)?80:ResponsiveInfo.isSmallMobile(context)?65:100,
                                          height: ResponsiveInfo.isMobile(context)?80:ResponsiveInfo.isSmallMobile(context)?65:100

                                      ),

                                    ),


                                    (filepath1.isNotEmpty)?  Align(

                                      alignment: FractionalOffset.topRight,

                                      child: GestureDetector(


                                        child: Icon(Icons.remove_circle,color: Colors.red,size: 25,),

                                        onTap: (){

                                          setState(() {


                                            filepath1="";
                                          });


                                        },

                                      ),

                                    ):Container(),
                                  ],
                                )

                                :  Image.asset("images/file.png",width: ResponsiveInfo.isMobile(context)?80:ResponsiveInfo.isSmallMobile(context)?65:100,height: ResponsiveInfo.isMobile(context)?80:ResponsiveInfo.isSmallMobile(context)?65:100,fit: BoxFit.fill,)
                                ,

                              )


                              , Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?13:ResponsiveInfo.isSmallMobile(context)?10:15),

                                child:  Text("\n Address Proof 1",textAlign : TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:ResponsiveInfo.isSmallMobile(context)?12:16,color: Color(
                                    0xff252626),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),


                              )


                            ],


                          ),



                        ),


                      ) ,

                        onTap: (){


                          Widget yesButton = TextButton(
                              child: Text("Yes",
                                style: TextStyle(
                                    fontSize: ResponsiveInfo
                                        .isMobile(context)
                                        ? ResponsiveInfo
                                        .isSmallMobile(
                                        context) ? 14 : 16
                                        : 18),),
                              onPressed: () async {
                                Navigator.pop(context);

                                _pickImage(0);


                              });


                          Widget noButton = TextButton(
                            child: Text("No",
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
                            title: Text("Kenz Food",
                                style: TextStyle(
                                    fontSize: ResponsiveInfo
                                        .isMobile(context)
                                        ? ResponsiveInfo
                                        .isSmallMobile(
                                        context) ? 14 : 16
                                        : 18)),
                            content: Text(
                                "We will keep your Address proof photo secure, We do not going to share outside.Do you want to continue ?",
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
                  )



                     ,flex: 1,),


                      Expanded(child:

                      GestureDetector(


                        child:Card(

                          child: Padding(padding: EdgeInsets.all(8),


                            child:


                            Column(

                              children: [


                                Padding(padding: EdgeInsets.all(15),


                                  child:



                                  (filepath2.isNotEmpty)?


                                  Stack(

                                    children: [

                                      (filepath2.isNotEmpty)?  Align(

                                        alignment: FractionalOffset.topRight,

                                        child: GestureDetector(


                                          child: Icon(Icons.remove_circle,color: Colors.red,size: 25,),

                                          onTap: (){

                                            setState(() {


                                              filepath2="";
                                            });


                                          },

                                        ),

                                      ):Container(),





                                      Align(

                                        alignment: FractionalOffset.center,

                                        child: Container(
                                            child: Image.file(new File(filepath2),scale: 5,),
                                            width: ResponsiveInfo.isMobile(context)?80:ResponsiveInfo.isSmallMobile(context)?65:100,
                                            height: ResponsiveInfo.isMobile(context)?80:ResponsiveInfo.isSmallMobile(context)?65:100

                                        ),

                                      )
                                    ],
                                  )    :    Image.asset("images/file.png",width: ResponsiveInfo.isMobile(context)?80:ResponsiveInfo.isSmallMobile(context)?65:100,height: ResponsiveInfo.isMobile(context)?80:ResponsiveInfo.isSmallMobile(context)?65:100,fit: BoxFit.fill,)
                                  ,

                                )


                                , Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?13:ResponsiveInfo.isSmallMobile(context)?10:15),

                                  child:  Text("\n Address Proof 2",textAlign : TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:ResponsiveInfo.isSmallMobile(context)?12:16,color: Color(
                                      0xff252626),fontWeight: FontWeight.normal,fontFamily: 'Poppins'),),


                                )


                              ],


                            ),



                          ),


                        ) ,

                        onTap: (){


                          Widget yesButton = TextButton(
                              child: Text("Yes",
                                style: TextStyle(
                                    fontSize: ResponsiveInfo
                                        .isMobile(context)
                                        ? ResponsiveInfo
                                        .isSmallMobile(
                                        context) ? 14 : 16
                                        : 18),),
                              onPressed: () async {
                                Navigator.pop(context);

                                _pickImage(1);


                              });


                          Widget noButton = TextButton(
                            child: Text("No",
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
                            title: Text("Kenz Food",
                                style: TextStyle(
                                    fontSize: ResponsiveInfo
                                        .isMobile(context)
                                        ? ResponsiveInfo
                                        .isSmallMobile(
                                        context) ? 14 : 16
                                        : 18)),
                            content: Text(
                                "We will keep your Address proof photo secure, We do not going to share outside.Do you want to continue ?",
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
                      ),flex: 1,)
                      






                    ],


                  )

                ),
        Padding(padding: EdgeInsets.only(top: ResponsiveInfo.isMobile(context)?30:ResponsiveInfo.isSmallMobile(context)?20:45),

          child:
                _submit())







              ],




            ),



          ),


        ),


      ),



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


            if(filepath1.isNotEmpty&&filepath2.isNotEmpty)
              {
                ProgressDialog _progressDialog = ProgressDialog();
                _progressDialog.showProgressDialog(context);
                String url1=ServerConstants.baseurl+ServerConstants.insertwholesaleuser;

                Map<String,String>mp={"username":name };




                url1=ServerConstants.baseurl+ServerConstants.insertwholesaleuser;






                var url = Uri.parse(url1);
                var request = new http.MultipartRequest("POST", url);
                request.fields["username"]=name;
                request.fields["phone"]=mobile;
                request.fields["email"]=email;
                request.files.add(
                    await http.MultipartFile.fromPath(
                        "document_url1",
                        filepath1
                    )
                );

                request.files.add(
                    await http.MultipartFile.fromPath(
                        "document_url2",
                        filepath2
                    )
                );

                final response = await request.send();

                print(response.statusCode);

                if(!_progressDialog.isDismissed) {
                  _progressDialog.dismissProgressDialog(context);
                }

                if(response.statusCode==200)
                  {

                    Widget yesButton = TextButton(
                        child: Text("Ok",
                          style: TextStyle(
                              fontSize: ResponsiveInfo
                                  .isMobile(context)
                                  ? ResponsiveInfo
                                  .isSmallMobile(
                                  context) ? 14 : 16
                                  : 18),),
                        onPressed: () async {
                          Navigator.pop(context);




                        });

                    AlertDialog alert = AlertDialog(
                      title: Text("Kenz Food",
                          style: TextStyle(
                              fontSize: ResponsiveInfo
                                  .isMobile(context)
                                  ? ResponsiveInfo
                                  .isSmallMobile(
                                  context) ? 14 : 16
                                  : 18)),
                      content: Text(
                          "You have successfully submitted your documents.You can login to this application after admin's approval",
                          style: TextStyle(
                              fontSize: ResponsiveInfo
                                  .isMobile(context)
                                  ? ResponsiveInfo
                                  .isSmallMobile(
                                  context) ? 14 : 16
                                  : 18)),
                      actions: [yesButton],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (
                          BuildContext context) {
                        return alert;
                      },
                    );


                  }




              }
            else{

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Please upload two address proofs"),
              ));

            }






          }
          ,
          child: Text(
            'Submit',
            style:  TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: ResponsiveInfo.isMobile(context)?15:ResponsiveInfo.isSmallMobile(context)?13:18

            ),
          )),
    );
  }


  Future _pickImage(int code) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);

      setState(() {

        if(code==0)
          {
            filepath1 = tempImage.path;
          }
        else{

          filepath2 = tempImage.path;
        }


      });
    } on PlatformException catch (e) {
      WidgetHelper.showToast("failed to Pick Image $e");
    }
  }
}
