import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;




import '../models/banner_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class BannerDataProvider extends ChangeNotifier{

  BannerEntity post = BannerEntity();
  bool loading = false;

  getPostData(context) async {
    loading = true;
    post = await getSinglePostData(context);
    loading = false;

    notifyListeners();
  }



  Future<BannerEntity> getSinglePostData(context) async {
    late  BannerEntity result;
    try {


      String url=ServerConstants.baseurl+ServerConstants.get_banners;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = BannerEntity.fromJson(item);
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


  Future<BannerEntity> getSecondaryData(context) async {
    late  BannerEntity result;
    try {


      String url=ServerConstants.baseurl+ServerConstants.getSmallBanners;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = BannerEntity.fromJson(item);
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