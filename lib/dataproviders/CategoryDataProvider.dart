import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;



import '../models/category_list_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class CategoryDataProvider extends ChangeNotifier{

  CategoryListEntity post = CategoryListEntity();
  bool loading = false;

  getPostData(context) async {
    loading = true;
    post = await getSinglePostData(context);
    loading = false;

    notifyListeners();
  }



  Future<CategoryListEntity> getSinglePostData(context) async {
  late  CategoryListEntity result;
    try {
      final response = await http.get(
        Uri.parse(ServerConstants.baseurl+ServerConstants.getCategory),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = CategoryListEntity.fromJson(item);
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