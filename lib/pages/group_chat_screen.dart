import 'dart:collection';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kenz_market_new/config/constant.dart';

import 'package:shared_preferences/shared_preferences.dart';


import '../models/ChatMessage.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import 'package:firebase_database/firebase_database.dart';


class GroupChatScreen extends StatefulWidget {

  String groupname;
  String id;

   GroupChatScreen(this.groupname,this.id) : super();

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState(groupname,id);
}

class _GroupChatScreenState extends State<GroupChatScreen> {

TextEditingController chatcontroller=new TextEditingController();
  String groupname;
String id;

  _GroupChatScreenState(this.groupname,this.id);

  List<String>chatdata=[];

final scrollDirection = Axis.vertical;
final databaseReference = FirebaseDatabase.instance.refFromURL("https://kenz-market-default-rtdb.firebaseio.com/");

String mychat="",msghint="",language="";
List<ChatMessage>chatmsgs=[];

String userid="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkLanguage();
    readMessges();


  }







int selectedmsgindex=-1;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: Color(0xfff1efef),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color:Color(0xff106e3c)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(mychat,style: TextStyle(fontSize:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 14:17:20:25,color: Color(0xff106e3c)),),
        centerTitle: false,
      ),
      // floatingActionButton: FloatingActionButton.small(
      //   onPressed: _scrollDown,
      //   child: Icon(Icons.arrow_downward),
      // ),
      body:
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xffece5dd),


            child:   Stack(
                children: <Widget>[

                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: double.infinity,
                      height: ResponsiveInfo.isMobile(context)
                          ? height - 150
                          : height - 200,
                      child: ListView.builder(
                        itemCount: chatmsgs.length,
                        shrinkWrap: true,
                        reverse: false,
                        scrollDirection: scrollDirection,

                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {


                          return
                               Stack(
                                children: [
                                  (chatmsgs[index]
                                      .user_id
                                      .toUpperCase()
                                      .toString()
                                      .compareTo(userid
                                      .toString()
                                      .toUpperCase()
                                      .toString()) ==
                                      0)
                                      ? Align(
                                      alignment: FractionalOffset.centerRight,
                                      child: Container(
                                          color: (selectedmsgindex == index)
                                              ? Colors.black12
                                              : Colors.transparent,
                                          child: GestureDetector(
                                              onLongPress: () {
                                                print("Long pressed");

                                                setState(() {
                                                  selectedmsgindex = index;
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(8),

                                                child:        IntrinsicWidth(

                                                    stepWidth: ResponsiveInfo.isMobile(context)? 35 : 50,


                                                    child:

                                                    Column(
                                                      children: <Widget>[
                                                         Container(
                                                          //  minWidth: width/11,
                                                          //   constraints: BoxConstraints( maxWidth: width/3),
                                                          padding:
                                                          EdgeInsets.only(
                                                              left: 16,
                                                              right: 16,
                                                              top: 10,
                                                              bottom: 10),
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Color(
                                                                0xffd9fdd3),
                                                            borderRadius: BorderRadius.circular(ResponsiveInfo
                                                                .isTab(
                                                                context)
                                                                ? ResponsiveInfo
                                                                .isMobile(
                                                                context)
                                                                ? 10
                                                                : 15
                                                                : 18),
                                                          ),
                                                          child: MediaQuery
                                                              .removePadding(
                                                            context: context,
                                                            child: Column(
                                                                children: [

                                                                  Container(
                                                                    // minWidth: width/11,
                                                                    // constraints: BoxConstraints( maxWidth: width/3),
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                        8,
                                                                        right:
                                                                        8,
                                                                        top: 5,
                                                                        bottom:
                                                                        5),

                                                                    child: Text(
                                                                      chatmsgs[
                                                                      index]
                                                                          .message,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                          10,
                                                                          fontFamily:
                                                                          'Poppins'),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                      padding:
                                                                      EdgeInsets.all(
                                                                          3),
                                                                      child:
                                                                      Stack(
                                                                        children: [
                                                                          Align(
                                                                              alignment: FractionalOffset.bottomRight,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.all(2),
                                                                                    child: Text(
                                                                                      chatmsgs[index].date,
                                                                                      style: TextStyle(color: Colors.black54, fontSize: 7, fontFamily: 'Poppins'),
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              ))
                                                                        ],
                                                                      ))
                                                                ]),
                                                            removeBottom: true,
                                                            removeLeft: true,
                                                            removeRight: true,
                                                            removeTop: true,
                                                          ),
                                                        )

                                                        // Padding(padding: EdgeInsets.all(4),
                                                        //
                                                        //   child: Text(groupmsgEntity[index].userid,style: TextStyle(color: Colors.black,fontSize: 10,fontFamily: 'Poppins'),),
                                                        //
                                                        //
                                                        //
                                                        //
                                                        // )
                                                      ],
                                                    ) ),
                                              ))))
                                      : Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Container(
                                          color: (selectedmsgindex == index)
                                              ? Colors.black12
                                              : Colors.transparent,
                                          child: GestureDetector(
                                              onLongPress: () {
                                                print("Long pressed");

                                                setState(() {
                                                  selectedmsgindex = index;
                                                });
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child:IntrinsicWidth(

                                                    stepWidth: ResponsiveInfo.isMobile(context)? 35 : 50,


                                                    child:



                                                    Column(
                                                      children: <Widget>[
                                                        Container(
                                                          //  minWidth: width/11,
                                                          //   constraints: BoxConstraints( maxWidth: width/3),
                                                          padding:
                                                          EdgeInsets.only(
                                                              left: 16,
                                                              right: 16,
                                                              top: 10,
                                                              bottom: 10),
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Color(
                                                                0xffd9fdd3),
                                                            borderRadius: BorderRadius.circular(ResponsiveInfo
                                                                .isTab(
                                                                context)
                                                                ? ResponsiveInfo
                                                                .isMobile(
                                                                context)
                                                                ? 10
                                                                : 15
                                                                : 18),
                                                          ),
                                                          child: MediaQuery
                                                              .removePadding(
                                                            context: context,
                                                            child: Column(
                                                              children: [

                                                                Text(
                                                                  chatmsgs[
                                                                  index]
                                                                      .message,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                      12,
                                                                      fontFamily:
                                                                      'Poppins'),
                                                                ),
                                                                Padding(
                                                                    padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                        5),
                                                                    child:
                                                                    Stack(
                                                                      children: [
                                                                        Align(
                                                                          alignment:
                                                                          FractionalOffset.bottomRight,
                                                                          child:
                                                                          Text(
                                                                            chatmsgs[index].date,
                                                                            style: TextStyle(
                                                                                color: Colors.black54,
                                                                                fontSize: 7,
                                                                                fontFamily: 'Poppins'),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ))
                                                              ],
                                                            ),
                                                            removeBottom: true,
                                                            removeLeft: true,
                                                            removeRight: true,
                                                            removeTop: true,
                                                          ),
                                                        )

                                                        // Padding(padding: EdgeInsets.all(4),
                                                        //
                                                        //   child: Text(groupmsgEntity[index].userid,style: TextStyle(color: Colors.black,fontSize: 10,fontFamily: 'Poppins'),),
                                                        //
                                                        //
                                                        //
                                                        //
                                                        // )
                                                      ],
                                                    ),)
                                              ))))
                                ],
                              );
                        },
                      ),
                    ),
                  ),



                  Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(

                        height:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)? 120:140:175,
                        width: double.infinity,
                        child: Column(


                          children: [




                            Padding(padding: EdgeInsets.only(top: 0),


                              child:     Container(

                                height:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)? 55:65:90,
                                width: double.infinity,
                                color: Colors.white,
                                child:

                                Row(
                                  children: <Widget>[
                                    // GestureDetector(
                                    //
                                    //
                                    //   onTap: () async {
                                    //
                                    //     final ImagePicker _picker = ImagePicker();
                                    //     // Pick an image
                                    //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                    //
                                    //
                                    //
                                    //
                                    //   },
                                    //
                                    //
                                    //
                                    //
                                    //   child: Container(
                                    //     height:ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)? 30:40:50,
                                    //     width: ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)? 30:40:50,
                                    //     margin: EdgeInsets.all(5),
                                    //     // decoration: BoxDecoration(
                                    //     //   color: Colors.lightBlue,
                                    //     //   borderRadius: BorderRadius.circular(ResponsiveInfo.isTab(context)?ResponsiveInfo.isMobile(context)? 30:40:50),
                                    //     // ),
                                    //     child: Icon(Icons.add_a_photo, color: Colors.black12, size: 20, ),
                                    //   ),
                                    // ),
                                    SizedBox(width: 15,),
                                    Expanded(
                                      child: TextField(
                                        controller: chatcontroller,
                                        maxLength: null,
                                        maxLines: 10000,
                                        decoration: InputDecoration(
                                            hintText: msghint,
                                            hintStyle: TextStyle(color: Colors.black54),
                                            border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Padding(padding: EdgeInsets.all(8),

                                      child: FloatingActionButton(

                                        onPressed: () async {



                                          if(chatcontroller.text.isNotEmpty)
                                            {


                                            String userid= await getStringValue("userid") ;
                                            String user_tye= await getStringValue("user_tye") ;

                                            DateTime dt=DateTime.now();
                                            String date=dt.day.toString()+"-"+dt.month.toString()+"-"+dt.year.toString()+" "+dt.hour.toString()+":"+dt.minute.toString()+" "+dt.second.toString();



                                              databaseReference.child(userid+"-Admin"+date).set({
                                                'message': chatcontroller.text.toString(),
                                                'image': '',
                                                'user_id':userid,
                                                "usertype":"user",
                                                "time":date
                                              });
                                            chatcontroller.text="";

                                            readMessges();


                                            }
                                          else{


                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Enter message"),
                                                ));
                                          }









                                        },
                                        child: Icon(Icons.send,color: Colors.white,size: 18,),
                                        backgroundColor: Colors.green,
                                        elevation: 2,
                                      ),
                                    )

                                  ],

                                ),



                              ),

                            )


                          ],


                        ),
                      )







                  ),

                ]) ,
          )










    );
  }




  readMessges()
  async {
    List<ChatMessage>messagesdata=[];
    messagesdata.clear();
    chatmsgs.clear();
    userid=await getStringValue("userid");

    String u=userid+"-Admin";

      databaseReference.once().then((value) {



      // String a=  value.snapshot.value.toString();
      //
      // var js=jsonDecode(a);



        print((value.snapshot.value as Map<Object,Object>).length);

        Map<Object,Object>mp=value.snapshot.value as Map<Object,Object>;



        mp.forEach((key, values) {


          Map<Object,Object>mp1=values as Map<Object,Object>;

          String userid="",messagedata="",image="",usertype="",date="";

          if(key.toString().contains(u)) {
            mp1.forEach((key, values) {
              print(values);


              if (key.toString().compareTo("user_id") == 0) {
                userid = values.toString();
              }
              if (key.toString().compareTo("message") == 0) {
                messagedata = values.toString();
              }

              if (key.toString().compareTo("image") == 0) {
                image = values.toString();
              }

              if (key.toString().compareTo("usertype") == 0) {
                usertype = values.toString();
              }


              if (key.toString().compareTo("time") == 0) {
                date = values.toString();
              }
            });

            ChatMessage message = new ChatMessage();
            message.date = date;
            message.usertype = usertype;
            message.image = image;
            message.user_id = userid;
            message.message = messagedata;

            setState(() {

              messagesdata.add(message);
              chatmsgs.add(message);
            });
          }
        });



      });

  }



checkLanguage()async
{

  Map lde= await LanguageDatas.getLanguageData();

  String currentlanguage=await LanguageDatas.checkLanguage();

  if(mounted) {
    setState(() {
      if (currentlanguage.compareTo("en") == 0) {
        language = currentlanguage;
        mychat = lde['mychat_en'];
        msghint=lde['writemsg_en'];

      }
      else {
        language = currentlanguage;
        mychat = lde['mychat_ar'];
        msghint=lde['writemsg_ar'];

      }
    });
  }



}



}
