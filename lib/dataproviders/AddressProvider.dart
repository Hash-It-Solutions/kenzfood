import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;



import '../config/constant.dart';

import '../models/address_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class AddressDataProvider extends ChangeNotifier{

  String addressresponse="",deleteaddressResponse="",updatedresponse="";
  bool loading = false;

  AddressEntity addressEntity=new AddressEntity();



  Future<String>  updateAddress(context,String id,dynamic request) async {
    loading = true;
    updatedresponse = await updateuserAddress(context,id,request);
    loading = false;

    notifyListeners();

    return updatedresponse;
  }




  Future<String>  addAddress(context,dynamic requestdata) async {
    loading = true;
    addressresponse = await addToAddress(context,requestdata);
    loading = false;

    notifyListeners();

    return addressresponse;
  }


  Future<AddressEntity>  getAddressList(context) async {
    loading = true;
    addressEntity = await getAddress(context);
    loading = false;

    notifyListeners();

    return addressEntity;
  }


  Future<String>  deleteAddress(context,String id) async {
    loading = true;
    deleteaddressResponse = await deleteuserAddress(context,id);
    loading = false;

    notifyListeners();

    return deleteaddressResponse;
  }


  Future<String> deleteuserAddress(context,String id) async {
    late  String result="";
    try {

      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.addAddress+"/"+id;

      final response = await http.delete(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },


      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = response.body;
      }
      else if(response.statusCode==401){

        Map results = await Navigator.of(context)
            .push(new MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return new NewLoginpage();
          },
        ));
        if (results != null &&
            results.containsKey('loggedin')) {

          var loggedin =
          results['loggedin'];

          int logdata =
          loggedin as int;

          if(logdata==1)
          {

            deleteuserAddress(context,id);

          }




        }

      }






      else {

        print(response);

      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }


  Future<String> updateuserAddress(context,String id,dynamic requestmodel) async {
    late  String result="";
    try {

      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.addAddress+"/"+id;

      final response = await http.put(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
        body: requestmodel


      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = response.body;
      }
      else if(response.statusCode==401){

        Map results = await Navigator.of(context)
            .push(new MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return new NewLoginpage();
          },
        ));
        if (results != null &&
            results.containsKey('loggedin')) {

          var loggedin =
          results['loggedin'];

          int logdata =
          loggedin as int;

          if(logdata==1)
          {

            updateAddress(context, id, requestmodel);

          }




        }

      }


      else {

        print(response);

      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }


  Future<AddressEntity> getAddress(context) async {
    late  AddressEntity result;
    try {

      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.addAddress;

      final response = await http.get(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },


      );
      if (response.statusCode == 200) {

        print(url);
        print(response.body);

        final item = json.decode(response.body);
        result=AddressEntity.fromJson(item);


      }
      else if(response.statusCode==401){

        Map results = await Navigator.of(context)
            .push(new MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return new NewLoginpage();
          },
        ));
        if (results != null &&
            results.containsKey('loggedin')) {

          var loggedin =
          results['loggedin'];

          int logdata =
          loggedin as int;

          if(logdata==1)
          {

     getAddress(context);

          }




        }

      }




      else {

        print(response);

      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }



  Future<String> addToAddress(context,dynamic requestdata) async {
    late  String result="";
    try {

      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.addAddress;

      final response = await http.post(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
        body: requestdata,

      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = response.body;
      }
      else if(response.statusCode==401){

        Map results = await Navigator.of(context)
            .push(new MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return new NewLoginpage();
          },
        ));
        if (results != null &&
            results.containsKey('loggedin')) {

          var loggedin =
          results['loggedin'];

          int logdata =
          loggedin as int;

          if(logdata==1)
          {

       addToAddress(context, requestdata);

          }




        }

      }



      else {

        print(response);

      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

}