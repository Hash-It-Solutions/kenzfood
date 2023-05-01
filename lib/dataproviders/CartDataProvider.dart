import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;




import '../config/constant.dart';
import '../models/cart_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class CartDataProvider extends ChangeNotifier{

  CartEntity post = CartEntity();
  String addtoCartResponse="",deletedresponse="",increaseqtyResponse="",decreaseQty="",clearCartResponse="";
  bool loading = false;

  getPostData(context) async {
    loading = true;
    post = await getSinglePostData(context);
    loading = false;

    notifyListeners();
  }

  Future<String> getDeletedData(context,String id) async {
    loading = true;
    deletedresponse = await deleteData(context,id);
    loading = false;

    notifyListeners();

    return deletedresponse;
  }

  Future<String> clearCartData(context) async {
    loading = true;
    clearCartResponse = await clearData(context);
    loading = false;

    notifyListeners();

    return clearCartResponse;
  }

   Future<String>  addtoCart(context,String id,dynamic requestdata) async {
    loading = true;
    addtoCartResponse = await addToCart(context,id,requestdata);
    loading = false;

    notifyListeners();

    return addtoCartResponse;
  }


  Future<String> addToCart(context,String id,dynamic requestdata) async {
    late  String result="";
    try {

     String apiToken = await getStringValue("token");

     String url=ServerConstants.baseurl+ServerConstants.cart+"/"+id;

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

              addToCart(context, id, requestdata);

            }




        }

      }

      else {

// print(response);

      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }


  Future<CartEntity> getSinglePostData(context) async {
    late  CartEntity result=CartEntity();
    try {

      String apiToken = await getStringValue("token");

      final response = await http.get(
        Uri.parse(ServerConstants.baseurl+ServerConstants.cart),
        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = CartEntity.fromJson(item);
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

  Future<int> getCartCountData(context) async {
    late  CartEntity result=CartEntity();
    int count=0;
    try {

      String apiToken = await getStringValue("token");

      final response = await http.get(
        Uri.parse(ServerConstants.baseurl+ServerConstants.cart),
        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = CartEntity.fromJson(item);

        if(result!=null)
          {
            count=result.cartItems.length;
          }

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
      //       getSinglePostData(context);
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
    return count;
  }





  Future<String>  increaseQtyCart(context,String id) async {
    loading = true;
    increaseqtyResponse = await incrementQuantity(context,id);
    loading = false;

    notifyListeners();

    return increaseqtyResponse;
  }


  Future<String>  decreaseQtyCart(context,String id) async {
    loading = true;
    decreaseQty = await decrementQuantity(context,id);
    loading = false;

    notifyListeners();

    return decreaseQty;
  }
  Future<String> deleteData(context,String id) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.deletecart+"/"+id;

      final response = await http.delete(
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
      } else {



      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<String> decrementQuantity(context,String id) async {
    late  String result;
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.decreaseQty+"/"+id;

      final response = await http.put(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
        // body: requestdata,

      );
      if (response.statusCode == 200) {
        // final item = json.decode(response.body);
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

         decrementQuantity(context, id);

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


  Future<String> incrementQuantity(context,String id) async {
    late  String result;
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.increaseQty+"/"+id;

      final response = await http.put(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
        // body: requestdata,

      );
      if (response.statusCode == 200) {
       // final item = json.decode(response.body);
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

            incrementQuantity(context, id);

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


  Future<String> clearData(context) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.clearcart;

      final response = await http.delete(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },


      );
      if (response.statusCode == 200) {
        // final item = json.decode(response.body);
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

            clearData(context);

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