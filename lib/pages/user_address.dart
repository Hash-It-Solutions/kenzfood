import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../dataproviders/AddressProvider.dart';
import '../models/address_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import 'add_address.dart';

class UserAddress extends StatefulWidget {

  String code="0";


   UserAddress(this.code) ;

  @override
  _UserAddressState createState() => _UserAddressState(code);
}

class _UserAddressState extends State<UserAddress> {



  bool _switchValue = false;

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  double _lowerValue = 50;
  double _upperValue = 180;

  bool _value = false;
  int val = 0;
  bool isselected=false;

  List<AddressData> data=[];

  //List<Data>addresslis=[];

  TextEditingController txtdeliveryoptionscontroller=new TextEditingController();

  String cartid="0";
  String code="0";
  late AddressDataProvider addressDataProvider;
  String  yes="";
  String no="";
  String kenz="";
  String addnew="";

  String deleteaddressmsg="";


  String Select="", edit="",delete="", nodatafound="", language="", myaddress="",mobile="",city="",postalcode="",mobilenumber="",telephonenumber="",addressline1="",addressline2="",selectlocation="",add="",addaddress="";

  _UserAddressState(this. code);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLanguage();
    addressDataProvider = Provider.of<AddressDataProvider>(context, listen: false);
    // addressDataProvider = Provider.of<AddressDataProvider>(context);



    addressDataProvider.getAddressList(context);
    //getAddress();
  }


  @override
  Widget build(BuildContext context) {

    addressDataProvider = Provider.of<AddressDataProvider>(context);

    AddressEntity ade= addressDataProvider.addressEntity;


    if(ade!=null) {
      if (ade.data.length > 0) {

        data.clear();


          data.addAll(ade.data);



      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffe3e7e5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff01713D)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            myaddress,
            style: TextStyle(
                fontSize: ResponsiveInfo.isMobile(context)
                    ? ResponsiveInfo.isSmallMobile(context)
                    ? 12
                    : 16
                    : 20,
                color: Color(0xff01713D)),
          ),
          centerTitle: false,

          actions: [

            Padding(
              padding: EdgeInsets.all(10),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  Map results = await Navigator.of(context)
                      .push(new MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return new AddAddress(new AddressData()
                      );
                    },
                  ));
                  if (results != null &&
                      results.containsKey('added')) {
                    setState(() {
                      var acc_selected =
                      results['added'];

                      int acs =
                      acc_selected as int;

                      if(acs!=0) {
                        getAddress();
                      }




                    });
                  }
                },
                label:  Text(addnew,style: TextStyle(fontFamily: 'Poppins',fontSize: 12),),
                icon: const Icon(Icons.add),
                backgroundColor: Color(0xff01713D),
              ),)

          ],
        ),
        body:Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xffe3e7e5),
            child:Column(

                children: [

                  Flexible(child:  Stack(
                      children: [


                        (data.length>0)?  Align(
                            alignment: Alignment.topLeft,
                            child: ListView.builder(

                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(   padding: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(8):EdgeInsets.all(12):EdgeInsets.all(17),

                                      child:

                                      Container(
                                        // color: Colors.amber[colorCodes[index]],
                                        child: Center(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(color: Colors.white70, width: 0),
                                                borderRadius: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?BorderRadius.circular(8):BorderRadius.circular(12):BorderRadius.circular(15),
                                              ),
                                              elevation: 5,
                                              child: Container(
                                                color: Colors.white,
                                                width: double.infinity,
                                                child:
                                                ListTile(
                                                  title: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(data[index].name,  style: TextStyle(
                                                            fontSize: ResponsiveInfo.isMobile(context)
                                                                ? ResponsiveInfo.isSmallMobile(context)
                                                                ? 13
                                                                : 14
                                                                : 16,
                                                            color: Colors.black)),
                                                        Text(data[index].addressLine1+"\n"+data[index].addressLine2+"\n"+mobilenumber+" : "+data[index].mobile+"\n"+city+"  : "+data[index].city+"\n"+postalcode+" : "+data[index].postalCode+"\n",  style: TextStyle(
                                                            fontSize: ResponsiveInfo.isMobile(context)
                                                                ? ResponsiveInfo.isSmallMobile(context)
                                                                ? 11
                                                                : 13
                                                                : 15,
                                                            color: Colors.black),maxLines: 5,)

                                                        ,


                                                        ( data[index].selected)? Padding(
                                                            padding: EdgeInsets.all(2),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: TextButton(
                                                                    onPressed: () async {

                                                                      Map results = await Navigator.of(context)
                                                                          .push(new MaterialPageRoute<dynamic>(
                                                                        builder: (BuildContext context) {
                                                                          return new AddAddress(
                                                                              data[index]
                                                                           );
                                                                        },
                                                                      ));
                                                                      if (results != null &&
                                                                          results.containsKey('added')) {
                                                                        setState(() {
                                                                          var acc_selected =
                                                                          results['added'];

                                                                          int acs =
                                                                          acc_selected as int;

                                                                          if(acs!=0) {
                                                                            getAddress();
                                                                          }




                                                                        });
                                                                      }








                                                                    },
                                                                    child: Text(
                                                                      edit,
                                                                      style: TextStyle(
                                                                          color: Colors.lightGreen),
                                                                    ),
                                                                  ),
                                                                  flex: 2,
                                                                ),

                                                                Expanded(
                                                                  child: TextButton(
                                                                    onPressed: () {

                                                                      Widget yesButton = TextButton(
                                                                          child: Text(yes),
                                                                          onPressed: () async {

                                                                            Navigator.pop(context);

                                                                            deleteAddress(data[index].id.toString(),index);


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
                                                                        content: Text(deleteaddressmsg),
                                                                        actions: [yesButton, noButton],
                                                                      );

                                                                      // show the dialog
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return alert;
                                                                        },
                                                                      );



                                                                    },
                                                                    child: Text(
                                                                      delete,
                                                                      style: TextStyle(
                                                                          color: Colors.redAccent),
                                                                    ),
                                                                  ),
                                                                  flex: 2,
                                                                ),
                                                              ],
                                                            )):Container()




                                                      ]),
                                                  leading:  Checkbox(
                                                    value: data[index].selected,
                                                    onChanged: (bool? value) {
                                                      setState(() {

                                                        if(value!)
                                                          {
                                                            for(int i=0;i<data.length;i++)
                                                            {

                                                              data[i].selected=false;
                                                            }

                                                            data[index].selected=true;
                                                          }
                                                        else{
                                                          // for(int i=0;i<data.length;i++)
                                                          // {
                                                          //
                                                          //   data[i].selected=false;
                                                          // }

                                                          data[index].selected=false;
                                                        }


                                                        //
                                                        //
                                                        //
                                                        // addresslis[index].selected = value!;
                                                      });
                                                    },
                                                  ),
                                                ),


                                              ),
                                            )),
                                      ));
                                })) :

            Align(
              alignment: FractionalOffset.topCenter,

              child:

              Text("\n\n\n\n\n\n\n\n\n\n\n\n\n  "+nodatafound,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.green)),
            ),








                        // Align(
                        //     alignment: Alignment.topRight,
                        //     child: Padding(
                        //         padding: EdgeInsets.all(10),
                        //         child: FloatingActionButton.extended(
                        //           onPressed: () {
                        //             // Add your onPressed code here!
                        //           },
                        //           label: const Text('Add new',style: TextStyle(fontFamily: 'Poppins',fontSize: 12),),
                        //           icon: const Icon(Icons.check),
                        //           backgroundColor: Color(0xff01713D),
                        //         ),)),

                      ]

                  ),flex: 4,),

                  (code.compareTo("1")==0&&data.length>0)?  Flexible(child: Container(


                  child:     Padding(
                    padding: EdgeInsets.all(10),
                    child: FloatingActionButton.extended(
                      onPressed: () async {

                        int selected=0;

                        for(int i=0;i<data.length;i++)
                        {

                          if(data[i].selected)
                          {
                            selected=data[i].id;
                            break;

                          }

                        }


                        if(selected>0)
                        {

                          Navigator.pop(context, {"added": selected});
                        }
                        else{

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Select Address",style: TextStyle(fontFamily: 'Poppins',fontSize: ResponsiveInfo.isMobile(context)?12:14),),
                          ));
                        }



                      },
                      label:  Text(Select,style: TextStyle(fontFamily: 'Poppins',fontSize: 12),),

                      backgroundColor: Color(0xff01713D),
                    ),),




                  ),flex: 1,):Container()





                ])

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

        add=lde['add_en'];
        addaddress=lde['addadress_en'];
        mobilenumber=lde['mobile_en'];

        telephonenumber=lde['telephonenumber_en'];
        postalcode=lde['postalcode_en'];

        city=lde['city_en'];
        myaddress=lde['myaddress_en'];
        addressline1=lde['addresline_1_en'];
        addressline2=lde['addresline_2_en'];
        nodatafound=lde['nodatafound_en'];
        edit=lde['edit_en'];
        delete=lde['delete_en'];

        yes=lde['Yes_en'];
        no=lde['No_en'];
        kenz=lde['kenz_food_en'];
        deleteaddressmsg=lde['delete_address_en'];
        addnew=lde['addnew_en'];
        Select=lde['select_en'];

      }
      else {

        language=currentlanguage;
        Select=lde['select_ar'];
        addnew=lde['addnew_ar'];
        add=lde['add_ar'];
        delete=lde['delete_ar'];
        edit=lde['edit_ar'];
        addaddress=lde['addadress_ar'];
        mobilenumber=lde['mobile_ar'];
        yes=lde['Yes_ar'];
        no=lde['No_ar'];
        kenz=lde['kenz_food_ar'];

        telephonenumber=lde['telephonenumber_ar'];
        postalcode=lde['postalcode_ar'];

        city=lde['city_ar'];
        myaddress=lde['myaddress_ar'];

        addressline1=lde['addresline_1_ar'];
        addressline2=lde['addresline_2_ar'];
        nodatafound=lde['nodatafound_ar'];
        deleteaddressmsg=lde['delete_address_ar'];

      }
    });







  }



  getAddress()
  {

   // addressDataProvider = Provider.of<AddressDataProvider>(context,listen: false);
    addressDataProvider.getAddressList(context);
    addressDataProvider = Provider.of<AddressDataProvider>(context,listen: false);
    AddressEntity ade= addressDataProvider.addressEntity;


    if(ade!=null) {
      if (ade.data.length > 0) {
         setState(() {
           data.clear();

        data.addAll(ade.data);
         });


      }
    }





  }

  deleteAddress(String id,int index) async
  {
    addressDataProvider=Provider.of<AddressDataProvider>(context, listen: false);


    String response=await addressDataProvider.deleteAddress(context,id);

    if(response.isNotEmpty)
    {




      Map body = json.decode(response);

      if(body!=null) {

        if(body.containsKey("message")) {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                body["message"]),
          ));
          print(body["message"]);

          //  getAllItemsFromCart();

          setState(() {

            addressDataProvider.addressEntity.data.removeAt(index);

          });


          // getAllItemsFromCart();


        }
      }




    }


  }
}
