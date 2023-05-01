import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../utils/ServerConstants.dart';




class NormalFastProductProvider extends ChangeNotifier{

  String post = "";
  bool loading = false;

  Future<String>  getFastDeliveryData(context) async {
    loading = true;
    post = await getFastData(context);
    loading = false;

    notifyListeners();

    return post;
  }

  Future<String>  getNormalDeliveryData(context) async {
    loading = true;
    post = await getNormalData(context);
    loading = false;

    notifyListeners();

    return post;
  }



  Future<String> getFastData(context) async {
    late  String result="";
    try {


      String url=ServerConstants.baseurl+ServerConstants.fastdelivery;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        // final item = json.decode(response.body);
        result = response.body;
      }

      else if(response.statusCode==401){
        //
        // Map results = await Navigator.of(context)
        //     .push(new MaterialPageRoute<dynamic>(
        //   builder: (BuildContext context) {
        //     return new LoginPage();
        //   },
        // ));
        // if (results != null &&
        //     results.containsKey('loggedin')) {
        //
        //   var loggedin =
        //   results['loggedin'];
        //
        //   int logdata =
        //   loggedin as int;
        //
        //   if(logdata==1)
        //   {
        //
        //     getSinglePostData(context);
        //
        //   }
        //
        //
        //
        //
        // }

      }

      else {



      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }


  Future<String> getNormalData(context) async {
    late  String result="";
    try {


      String url=ServerConstants.baseurl+ServerConstants.normaldelivery;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        // final item = json.decode(response.body);
        result = response.body;
      }

      else if(response.statusCode==401){
        //
        // Map results = await Navigator.of(context)
        //     .push(new MaterialPageRoute<dynamic>(
        //   builder: (BuildContext context) {
        //     return new LoginPage();
        //   },
        // ));
        // if (results != null &&
        //     results.containsKey('loggedin')) {
        //
        //   var loggedin =
        //   results['loggedin'];
        //
        //   int logdata =
        //   loggedin as int;
        //
        //   if(logdata==1)
        //   {
        //
        //     getSinglePostData(context);
        //
        //   }
        //
        //
        //
        //
        // }

      }

      else {



      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}