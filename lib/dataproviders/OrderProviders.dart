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

class OrderProvider extends ChangeNotifier{

  CartEntity post = CartEntity();
  String placeOrderResponse="",getOrderResponse="",cancelOrderResponse="",orderdetails="";
  bool loading = false;

  Future<String> placeOrder(context,String id,var body) async {
    loading = true;
    placeOrderResponse = await createOrder(context,id,body);
    loading = false;

    notifyListeners();
    return placeOrderResponse;
  }


  Future<String> getFullOrderList(context) async {
    loading = true;
    getOrderResponse = await getOrderList(context);
    loading = false;

    notifyListeners();
    return getOrderResponse;
  }



  Future<String> cancelFullOrder(context,String id) async {
    loading = true;
    cancelOrderResponse = await cancelOrder(context,id);
    loading = false;

    notifyListeners();
    return cancelOrderResponse;
  }

  Future<String> getFullOrderDetails(context,String id) async {
    loading = true;
    orderdetails = await getOrderDetails(context,id);
    loading = false;

    notifyListeners();
    return orderdetails;
  }



  Future<String> cancelOrder(context,String id) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.order+"/"+id;

      final response = await http.delete(
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

            cancelOrder(context,id);

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


  Future<String> getOrderDetails(context,String id) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.orderDetails+"/"+id;

      final response = await http.get(
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

            getOrderDetails(context,id);

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

  Future<String> createOrder(context,String id,var bodydata) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.order+"/"+id;

      final response = await http.post(
        Uri.parse(url),

        headers: {
          'Content-Type':'application/json',

          ServerConstants.tokenKey:apiToken


        },
         body: bodydata,

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

            createOrder(context,id,bodydata);

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

  Future<String> getOrderList(context) async {
    late  String result="";
    try {



      String apiToken = await getStringValue("token");

      String url=ServerConstants.baseurl+ServerConstants.order;

      final response = await http.get(
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

     getOrderList(context);

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