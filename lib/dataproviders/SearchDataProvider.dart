import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;




import '../models/productlist_entity.dart';
import '../utils/ServerConstants.dart';


class SearchProductListProvider extends ChangeNotifier{

  ProductlistEntity post = ProductlistEntity();
  bool loading = false;

  getPostData(context,String param) async {
    loading = true;
    post = await getSinglePostData(context,param);
    loading = false;

    notifyListeners();
  }

  // http://kenz-food-api.herokuapp.com/get_product?parm=category_id&id=1



  Future<ProductlistEntity> getSinglePostData(context,String param) async {
    late  ProductlistEntity result=new ProductlistEntity();
    try {

      String url=ServerConstants.baseurl+ServerConstants.getSearchData+param;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = ProductlistEntity.fromJson(item);
      }
      else if(response.statusCode==401){

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
        //    // getSinglePostData(context,id,param);
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