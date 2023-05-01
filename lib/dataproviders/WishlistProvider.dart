import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;




import '../config/constant.dart';

import '../models/wishlist_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class WishlistDataProvider extends ChangeNotifier{

  WishlistEntity post = WishlistEntity();
  bool loading = false;

  String wishlistresponse="",checkwishlistresponse="",removewishlist="",clearresponse="";

  getData(context) async {
    loading = true;
    post = await getSinglePostData(context);
    loading = false;

    notifyListeners();
  }


  Future<String>addWishlist(context,String id) async{

    wishlistresponse= await addToWishList(context, id);
    notifyListeners();
    return wishlistresponse;


  }

  Future<String>check(context,String id) async{

    checkwishlistresponse= await checkWishList(context, id);
    notifyListeners();
    return checkwishlistresponse;


  }


  Future<String>remove(context,String id) async{

    removewishlist= await removeWishList(context, id);
    notifyListeners();
    return removewishlist;


  }


  Future<String>clearWishlist(context) async{

    clearresponse= await clearAll(context);
    notifyListeners();
    return clearresponse;


  }


  Future<String> clearAll(context) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.clearWishlist;

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

        clearAll(context);

          }




        }

      }


      else {



      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }



  Future<String> removeWishList(context,String id) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.wishlist+"/"+id;

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

            removeWishList(context,id);

          }




        }

      }

      else {



      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }


  Future<String> addToWishList(context,String id) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.wishlist+"/"+id;

      final response = await http.post(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
        // body: requestdata,

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

            addToWishList(context,id);

          }




        }

      }


      else {



      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<String> checkWishList(context,String id) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.checkWishlist+"/"+id;

      final response = await http.get(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
        // body: requestdata,

      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = response.body;
      }
      // else if(response.statusCode==401){
      //
      //   Map results = await Navigator.of(context)
      //       .push(new MaterialPageRoute<dynamic>(
      //     builder: (BuildContext context) {
      //       return new LoginPage();
      //     },
      //   ));
      //   if (results != null &&
      //       results.containsKey('loggedin')) {
      //
      //     var loggedin =
      //     results['loggedin'];
      //
      //     int logdata =
      //     loggedin as int;
      //
      //     if(logdata==1)
      //     {
      //
      //       checkWishList(context,id);
      //
      //     }
      //
      //
      //
      //
      //   }
      //
      // }

      else {



      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }


  Future<WishlistEntity> getSinglePostData(context) async {
    late  WishlistEntity result=new WishlistEntity();
    try {


      String url=ServerConstants.baseurl+ServerConstants.wishlist;

      String apiToken = await getStringValue("token");
      final response = await http.get(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
        // body: requestdata,

      );


      if (response.statusCode == 200) {
        final item = json.decode(response.body);

        print(url);
        print(response.body);

        result = WishlistEntity.fromJson(item);
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

            getSinglePostData(context);

          }




        }

      }


      else {



      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}