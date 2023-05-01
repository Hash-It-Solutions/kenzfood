import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../utils/ServerConstants.dart';




class NotificationDataProvider extends ChangeNotifier{

  String post = "";
  bool loading = false;

  Future<String>  getPostData(context) async {
    loading = true;
    post = await getData(context);
    loading = false;

    notifyListeners();

    return post;
  }



  Future<String> getData(context) async {
    late  String result="";
    try {


      String url=ServerConstants.baseurl+ServerConstants.getNotifications;

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