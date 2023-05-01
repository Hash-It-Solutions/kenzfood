import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;




import '../config/constant.dart';
import '../models/productlist_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class ProductListProvider extends ChangeNotifier{

  ProductlistEntity post = ProductlistEntity();
  bool loading = false;

  getPostData(context,String id,String param) async {
    loading = true;
    post = await getSinglePostData(context,id,param);
    loading = false;

    notifyListeners();
  }

 // http://kenz-food-api.herokuapp.com/get_product?parm=category_id&id=1



  Future<ProductlistEntity> getSinglePostData(context,String id,String param) async {

    String apiToken = await getStringValue("token");
    late  ProductlistEntity result=new ProductlistEntity();
    try {
      String url="";
      if(param.compareTo(ServerConstants.allparam)==0)
        {

          url=ServerConstants.baseurl+ServerConstants.get_product;
        }
      else{
        url=ServerConstants.baseurl+ServerConstants.get_product+"?parm="+param+"&id="+id;

      }



      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          ServerConstants.tokenKey:apiToken
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = ProductlistEntity.fromJson(item);

        post=result;
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

            getSinglePostData(context,id,param);

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


  Future<ProductlistEntity> getSinglePostDataByCategory(context,String id,String param) async {

    String apiToken = await getStringValue("token");
    late  ProductlistEntity result=new ProductlistEntity();
    try {
      String url="";
      // if(param.compareTo(ServerConstants.allparam)==0)
      // {
      //
      //   url=ServerConstants.baseurl+ServerConstants.get_product;
      // }
      // else{z
        url=ServerConstants.baseurl+ServerConstants.get_product+"?category_id="+id;

     // }



      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          ServerConstants.tokenKey:apiToken
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = ProductlistEntity.fromJson(item);
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

            getSinglePostData(context,id,param);

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