import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;




import '../models/product_image_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class ProductImageProvider extends ChangeNotifier{

  ProductImageEntity post = ProductImageEntity();
  bool loading = false;

  getPostData(context,String id) async {
    loading = true;
    post = await getSinglePostData(context,id);
    loading = false;

    notifyListeners();
  }



  Future<ProductImageEntity> getSinglePostData(context,String id) async {
    late  ProductImageEntity result;
    try {
      final response = await http.get(
        Uri.parse(ServerConstants.baseurl+ServerConstants.get_products_images+"?product_id="+id),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = ProductImageEntity.fromJson(item);
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