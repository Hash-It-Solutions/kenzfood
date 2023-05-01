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

class ProductListByCategoryProvider extends ChangeNotifier{

  ProductlistEntity post = ProductlistEntity();
  bool loading = false;

  getPostData(context,String id,String param) async {
    loading = true;
    post = await getSinglePostData(context,id,param);
    loading = false;

    notifyListeners();
  }





  Future<ProductlistEntity> getSinglePostData(context,String id,String param) async {
    late  ProductlistEntity result=new ProductlistEntity();
    try {
      String apiToken = await getStringValue("token");
      String url=ServerConstants.baseurl+ServerConstants.get_product+"?parm="+param+"&id="+id;

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