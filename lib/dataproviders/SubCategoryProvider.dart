import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;




import '../models/sub_category_list_entity.dart';
import '../pages/login.dart';
import '../pages/loginpage.dart';
import '../utils/ServerConstants.dart';

class SubCategoryDataProvider extends ChangeNotifier{

  SubCategoryListEntity post = SubCategoryListEntity();
  bool loading = false;

  getData(context,String categoryid) async {
    loading = true;
    post = await getSinglePostData(context,categoryid);
    loading = false;

    notifyListeners();
  }



  Future<SubCategoryListEntity> getSinglePostData(context,String categoryid) async {
    late  SubCategoryListEntity result;
    try {
      final response = await http.get(
        Uri.parse(ServerConstants.baseurl+ServerConstants.getsubcategory+"?category_id="+categoryid),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = SubCategoryListEntity.fromJson(item);
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

            getSinglePostData(context,categoryid);

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