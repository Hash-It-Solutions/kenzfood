import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../dataproviders/AddressProvider.dart';
import '../models/address_entity.dart';
import '../utils/LanguageValues.dart';
import '../utils/ResponsiveInfo.dart';
import 'package:geocoding_platform_interface/src/models/placemark.dart' as Placemark;
import 'package:geolocator/geolocator.dart';


import 'package:geocoding/geocoding.dart';

class AddAddress extends StatefulWidget {

  AddressData addrdata;

   AddAddress(this.addrdata) : super();

  @override
  _UserAddressState createState() => _UserAddressState(addrdata);
}

class _UserAddressState extends State<AddAddress> {

  TextEditingController namecontroller=new TextEditingController();
  TextEditingController mobilenumbercontroller=new TextEditingController();
  TextEditingController telephonecontroller=new TextEditingController();
  TextEditingController postalcodecontroller=new TextEditingController();
  TextEditingController citycontroller=new TextEditingController();
  TextEditingController addresslinecontroller1=new TextEditingController();
  TextEditingController addresslinecontroller2=new TextEditingController();
  TextEditingController pincodecontroller2=new TextEditingController();

  late AddressData addrdata;
  String mylocation="Select Location", buttontext="Add";

  String lat="",longi="";

  late AddressDataProvider addressDataProvider;

  String pincode="Pin Code",name="Name", infoalert="",yes="",no="",kenz="", language="", myaddress="",mobile="",city="",postalcode="",mobilenumber="",telephonenumber="",addressline1="",addressline2="",selectlocation="",add="",addaddress="";



  _UserAddressState(this. addrdata);


  @override
  void initState() {
    // TODO: implement initState
    setupdataForEditing();
    checkLanguage();
    super.initState();


    addressDataProvider = Provider.of<AddressDataProvider>(context, listen: false);

  }


  @override
  Widget build(BuildContext context) {
       return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Color(0xffe5e8e6),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xff01713D)),
            onPressed: () =>  Navigator.pop(context, {"added": 1}) ,
          ),
          title: Text(
            addaddress,
            style: TextStyle(
                fontSize: ResponsiveInfo.isMobile(context)
                    ? ResponsiveInfo.isSmallMobile(context)
                    ? 12
                    : 16
                    : 20,
                color: Color(0xff01713D)),
          ),
          centerTitle: false,
        ),
        body:Column(

            children: [

              Flexible(child:  Stack(
                  children: [

                    SingleChildScrollView(

                      child: Column(

                        children: [

                          Padding(
                            padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(10)    : EdgeInsets.all(15) :EdgeInsets.all(30) ,

                            child:Card(

                              child: Container(

                                  // decoration: BoxDecoration(
                                  //     border: Border.all(color: Colors.black45,width: ResponsiveInfo.isMobile(context)? 0.5:1.0)
                                  // ),

                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[

                                      GestureDetector(


                                        child: Padding(padding: ResponsiveInfo.isMobile(context)?EdgeInsets.all(8):EdgeInsets.all(18),

                                            child:

                                            ResponsiveInfo.isMobile(context)? Icon(Icons.location_on_outlined,size: 25,color: Colors.green,):Icon(Icons.location_on_outlined,size: 30,color: Colors.green,)
                                        ),

                                        onTap: (){





                                          fetchLocation();

                                        },
                                      )


                                      ,
                                      Expanded(child: new Theme(data: new ThemeData(
                                          hintColor: Colors.black45
                                      ), child: TextButton(onPressed: () {

                                        fetchLocation();


                                      },
                                        child: Text(mylocation,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)?13:16:19,color: Colors.blue)),)))
                                    ],
                                  )

                              ),

                              elevation: 5,
                            )




                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            ,
                          ),

    Padding(
    padding: ResponsiveInfo.isMobile(context)? ResponsiveInfo.isSmallMobile(context)? EdgeInsets.all(10)    : EdgeInsets.all(15) :EdgeInsets.all(30) ,

    child:    Card(
                            elevation: 5,
                            child: Column(

                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10,bottom: 0),
                                  // padding: EdgeInsets.all(15),
                                  child: new Theme(data: new ThemeData(
                                    hintColor: Colors.black54,

                                  ), child: TextField(


                                    keyboardType: TextInputType.name,


                                    controller: namecontroller,
                                    decoration: InputDecoration(

                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      hintText: name,




                                    ),

                                    onChanged: (text) {


                                    },



                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10,bottom: 0),
                                  // padding: EdgeInsets.all(15),
                                  child: new Theme(data: new ThemeData(
                                    hintColor: Colors.black54,

                                  ), child: TextField(


                                    keyboardType: TextInputType.phone,


                                    controller: mobilenumbercontroller,
                                    decoration: InputDecoration(

                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      hintText: mobilenumber,




                                    ),

                                    onChanged: (text) {


                                    },



                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10,bottom: 0),
                                  // padding: EdgeInsets.all(15),
                                  child: new Theme(data: new ThemeData(
                                    hintColor: Colors.black54,

                                  ), child: TextField(


                                    controller: telephonecontroller,

                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      hintText:telephonenumber,



                                    ),

                                    onChanged: (text) {


                                    },


                                  )),
                                ),




                                Padding(
                                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10,bottom: 0),
                                  // padding: EdgeInsets.all(15),
                                  child: new Theme(data: new ThemeData(
                                    hintColor: Colors.black54,

                                  ), child: TextField(

                                    keyboardType: TextInputType.phone,

                                    controller: postalcodecontroller,
                                    decoration: InputDecoration(
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      hintText: postalcode,



                                    ),

                                    onChanged: (text) {


                                    },


                                  )),
                                )


                                ,


                                Padding(
                                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10,bottom: 0),
                                  // padding: EdgeInsets.all(15),
                                  child: new Theme(data: new ThemeData(
                                    hintColor: Colors.black54,

                                  ), child: TextField(



                                    controller: citycontroller,
                                    decoration: InputDecoration(
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      hintText: city,



                                    ),

                                    onChanged: (text) {


                                    },


                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10,bottom: 0),
                                  // padding: EdgeInsets.all(15),
                                  child: new Theme(data: new ThemeData(
                                    hintColor: Colors.black54,

                                  ), child: TextField(



                                    controller: addresslinecontroller1,
                                    decoration: InputDecoration(
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      hintText: addressline1,



                                    ),

                                    onChanged: (text) {


                                    },


                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top:10,bottom: 15),
                                  // padding: EdgeInsets.all(15),
                                  child: new Theme(data: new ThemeData(
                                    hintColor: Colors.black54,

                                  ), child: TextField(



                                    controller: addresslinecontroller2,
                                    decoration: InputDecoration(
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black54, width: 0.5),
                                      // ),
                                      hintText: addressline2,



                                    ),

                                    onChanged: (text) {


                                    },


                                  )),
                                ),



                              ],
                            ),
                          )),












                        ],


                      ),



                    )




                  ]

              ),flex: 4,),

              Flexible(child: Container(

                width: ResponsiveInfo.isMobile(context)?ResponsiveInfo.isSmallMobile(context)? 120.0:150:200,

                child:   Padding(padding:ResponsiveInfo.isMobile(context)? EdgeInsets.fromLTRB(0, 10, 0, 10):EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child:  Container(

                      width:ResponsiveInfo.isMobile(context)? 150.0:180,
                      height:ResponsiveInfo.isMobile(context)? 50.0:100,
                      decoration: BoxDecoration(
                          color: Color(0xff01713D),
                          border: Border.all(
                            color: Color(0xff01713D),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)?20:40))


                      ),
                      child: TextButton(onPressed: () {


                        addAddress();
                       // checkPincode(pincodecontroller.text.toString().trim());






                        //checkData();




                      },
                        child: Text(add,style: TextStyle(color: Colors.white,fontSize:ResponsiveInfo.isMobile(context)? 17:26),),





                      ),




                    )) ,





              ),flex: 1,)





            ])





    );;
  }

  checkLanguage()async
  {

    Map lde= await LanguageDatas.getLanguageData();

    String currentlanguage=await LanguageDatas.checkLanguage();
  //   "myaddress_en": "My Address",
  // "myaddress_ar": "عنواني",
  //
  // "mobile_en": "Mobile",
  // "mobile_ar": "متحرك",
  //
  // "city_en": "City",
  // "city_ar": "مدينة",
  //
  // "postalcode_en": "Postal Code",
  // "postalcode_ar": "الرمز البريدي",
  //
  // "telephonenumber_en": "Telephone Number",
  // "telephonenumber_ar": "رقم هاتف" ,
  //
  // "addresline_1_en":"Address Line 1",
  // "addresline_1_ar": "العنوان الأول" ,
  //
  // "addresline_2_en":"Address Line 2",
  //   "addresline_2_ar": "سطر العنوان 2",
  //
  //   "selectlocation_en": "Select Location",
  // "selectlocation_ar": "اختر موقعا",
  //
  // "addadress_en": "Add Address",
  // "addadress_ar": "اضف عنوان" ,
  //
  //   "add_en": "Add",
  //   "add_ar": "يضيف"


    setState(() {
      language=currentlanguage;
      if (currentlanguage.compareTo("en") == 0) {

        language=currentlanguage;

        add=lde['add_en'];
        addaddress=lde['addadress_en'];
        mobilenumber=lde['mobile_en'];
        if(lat.isEmpty&&longi.isEmpty) {
          mylocation = lde['selectlocation_en'];
        }
        telephonenumber=lde['telephonenumber_en'];
        postalcode=lde['postalcode_en'];

        city=lde['city_en'];
        myaddress=lde['myaddress_en'];
        addressline1=lde['addresline_1_en'];
        addressline2=lde['addresline_2_en'];
        yes = lde['yes_en'];
        no = lde['No_en'];
        kenz = lde['kenz_food_en'];
        infoalert=lde['infoalert_en'];



      }
      else {

        language=currentlanguage;
        add=lde['add_ar'];
        addaddress=lde['addadress_ar'];
        mobilenumber=lde['mobile_ar'];

        if(lat.isEmpty&&longi.isEmpty) {
          mylocation = lde['selectlocation_ar'];
        }
        telephonenumber=lde['telephonenumber_ar'];
        postalcode=lde['postalcode_ar'];

        city=lde['city_ar'];
        myaddress=lde['myaddress_ar'];

        addressline1=lde['addresline_1_ar'];
        addressline2=lde['addresline_2_ar'];

        yes = lde['Yes_ar'];
        no = lde['No_ar'];
        kenz = lde['kenz_food_ar'];

        infoalert=lde['infoalert_ar'];


      }
    });







  }



  addAddress() async
  {

    if(namecontroller.text.isNotEmpty) {
      if (mobilenumbercontroller.text.isNotEmpty) {
        if (telephonecontroller.text.isNotEmpty) {
          if (postalcodecontroller.text.isNotEmpty) {
            if (citycontroller.text.isNotEmpty) {
              if (addresslinecontroller1.text.isNotEmpty) {
                if (addresslinecontroller2.text.isNotEmpty) {
                  if (lat.isNotEmpty && longi.isNotEmpty) {


                      Map mp = new Map();
                      mp['id'] = "0";
                      mp['name'] = namecontroller.text;
                      mp['address_line1'] = addresslinecontroller1.text;
                      mp['address_line2'] = addresslinecontroller2.text;
                      mp['city'] = citycontroller.text;
                      mp['postal_code'] = postalcodecontroller.text;
                      mp['country'] = "Qatar";
                      mp['telephone'] = telephonecontroller.text;
                      mp['mobile'] = mobilenumbercontroller.text;
                      mp['latitude'] = lat;
                      mp['longitude'] = longi;
                      // mp['postal_code']=pincodecontroller2.text;

                      Widget yesButton = TextButton(
                          child: Text(yes, style: TextStyle(
                              fontSize: ResponsiveInfo.isMobile(context)
                                  ? ResponsiveInfo.isSmallMobile(context)
                                  ? 14
                                  : 16
                                  : 18),),
                          onPressed: () async {
                            Navigator.pop(context);

                            if (addrdata.addressLine2.isNotEmpty) {
                              String response = await addressDataProvider
                                  .updateAddress(
                                  context, addrdata.id.toString(), json.encode(
                                  mp));
                              if (response.isNotEmpty) {
                                Map body = json.decode(response);

                                if (body != null) {
                                  if (body.containsKey("message")) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              body["message"]),
                                        ));
                                    print(body["message"]);


                                    mobilenumbercontroller.text = "";
                                    telephonecontroller.text = "";
                                    postalcodecontroller.text = "";
                                    citycontroller.text = "";
                                    addresslinecontroller1.text = "";
                                    addresslinecontroller2.text = "";

                                    Navigator.pop(context, {"added": 1});
                                  }
                                }
                              }
                            }
                            else {
                              String response = await addressDataProvider
                                  .addAddress(
                                  context, json.encode(mp));
                              if (response.isNotEmpty) {
                                Map body = json.decode(response);

                                if (body != null) {
                                  if (body.containsKey("message")) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              body["message"]),
                                        ));
                                    print(body["message"]);


                                    mobilenumbercontroller.text = "";
                                    telephonecontroller.text = "";
                                    postalcodecontroller.text = "";
                                    citycontroller.text = "";
                                    addresslinecontroller1.text = "";
                                    addresslinecontroller2.text = "";

                                    Navigator.pop(context, {"added": 1});
                                  }
                                }
                              }
                            }
                          });


                      Widget noButton = TextButton(
                        child: Text(no, style: TextStyle(
                            fontSize: ResponsiveInfo.isMobile(context)
                                ? ResponsiveInfo.isSmallMobile(context)
                                ? 14
                                : 16
                                : 18)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text(kenz, style: TextStyle(
                            fontSize: ResponsiveInfo.isMobile(context)
                                ? ResponsiveInfo.isSmallMobile(context)
                                ? 14
                                : 16
                                : 18)),
                        content: Text(infoalert, style: TextStyle(
                            fontSize: ResponsiveInfo.isMobile(context)
                                ? ResponsiveInfo.isSmallMobile(context)
                                ? 14
                                : 16
                                : 18)),
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
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Select location for fast delivery"),
                    ));
                  }
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Enter Address Line 2"),
                  ));
                }
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Address Line 1"),
                ));
              }
            }
            else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Enter city"),
              ));
            }
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Enter postal code"),
            ));
          }
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Enter telephone number"),
          ));
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Enter mobile number"),
        ));
      }
    }
    else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter name"),
      ));
    }


  }


  setupdataForEditing() async
  {

    if(addrdata!=null&&addrdata.addressLine1.isNotEmpty)
      {

        namecontroller.text=addrdata.name;
         mobilenumbercontroller.text=addrdata.mobile;
         telephonecontroller.text=addrdata.telephone;
         postalcodecontroller.text=addrdata.postalCode;
         citycontroller.text=addrdata.city;
         addresslinecontroller1.text=addrdata.addressLine1;
         addresslinecontroller2.text=addrdata.addressLine2;

         lat=addrdata.latitude;
         longi=addrdata.longitude;

         List<Placemark.Placemark> placemarks = await placemarkFromCoordinates(
             double.parse(lat), double.parse(longi)) as List<
             Placemark.Placemark>;


         if (placemarks.length > 0) {
           Placemark.Placemark placeMark = placemarks[0];

           String name = placeMark.name!;
           String subLocality = placeMark.subLocality!;
           String locality = placeMark.locality!;
           String administrativeArea = placeMark.administrativeArea!;
           String postalCode = placeMark.postalCode!;
           String country = placeMark.country!;

           String data = "";
           if (name != null || name.isNotEmpty) {
             data = data + name + ",";
           }
           if (subLocality != null || subLocality.isNotEmpty) {
             data = data + subLocality + ",";
           }
           if (locality != null || locality.isNotEmpty) {
             data = data + locality + ",";
           }
           if (administrativeArea != null || administrativeArea.isNotEmpty) {
             data = data + administrativeArea + ",";
           }

           if (postalCode != null || postalCode.isNotEmpty) {
             data = data + postalCode + ",";
           }

           if (country != null || country.isNotEmpty) {
             data = data + country + "";
           }

           setState(() {
             mylocation = data;
             buttontext="update";
           });

           // print(name+"\n"+subLocality+"\n"+locality+"\n"+administrativeArea+"\n"+postalCode+"\n"+country);
         }

      }


  }




  fetchLocation() async
  {

    bool  serviceEnabled = await  Geolocator.isLocationServiceEnabled();





    if (!serviceEnabled) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Location disabled"),
      ));

    }
    else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Fetching Location ....."),
      ));

      LocationPermission  permission = await Geolocator.requestPermission();

      if(permission==LocationPermission.whileInUse) {
        var loc = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print(loc);

        lat = loc.latitude.toString();
        longi = loc.longitude.toString();

        List<Placemark.Placemark> placemarks = await placemarkFromCoordinates(
            double.parse(lat), double.parse(longi)) as List<
            Placemark.Placemark>;


        if (placemarks.length > 0) {
          Placemark.Placemark placeMark = placemarks[0];

          String name = placeMark.name!;
          String subLocality = placeMark.subLocality!;
          String locality = placeMark.locality!;
          String administrativeArea = placeMark.administrativeArea!;
          String postalCode = placeMark.postalCode!;
          String country = placeMark.country!;

          String data = "";
          if (name != null || name.isNotEmpty) {
            data = data + name + ",";
          }
          if (subLocality != null || subLocality.isNotEmpty) {
            data = data + subLocality + ",";
          }
          if (locality != null || locality.isNotEmpty) {
            data = data + locality + ",";
          }
          if (administrativeArea != null || administrativeArea.isNotEmpty) {
            data = data + administrativeArea + ",";
          }

          if (postalCode != null || postalCode.isNotEmpty) {
            data = data + postalCode + ",";
          }

          if (country != null || country.isNotEmpty) {
            data = data + country + "";
          }

          setState(() {
            mylocation = data;
          });

          // print(name+"\n"+subLocality+"\n"+locality+"\n"+administrativeArea+"\n"+postalCode+"\n"+country);
        }
      }


    }
  }
}
