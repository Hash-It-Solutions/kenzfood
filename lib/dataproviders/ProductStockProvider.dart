import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;



import '../models/productstock_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class ProductStockProvider extends ChangeNotifier{

  ProductstockEntity post = ProductstockEntity();
  bool loading = false;

  getPostData(context,String id) async {
    loading = true;
    post = await getSinglePostData(context,id);
    loading = false;

    notifyListeners();
  }

  // http://kenz-food-api.herokuapp.com/get_product?parm=category_id&id=1



  Future<ProductstockEntity> getSinglePostData(context,String id) async {
    late  ProductstockEntity result=new ProductstockEntity();
    try {

      String url=ServerConstants.baseurl+ServerConstants.get_product_stocks+"?product_id="+id;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = ProductstockEntity.fromJson(item);
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

            getSinglePostData(context,id);

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