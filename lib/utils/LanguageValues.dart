import 'dart:convert';


import 'package:flutter/services.dart' show rootBundle;



import 'package:shared_preferences/shared_preferences.dart';

import 'Staticvalues.dart';

class LanguageDatas{



  static Future<String> checkLanguage() async {

    String? data="en";

    final datastorage = await SharedPreferences.getInstance();

 data= datastorage.getString(Staticvalues.currentlanguage);

    if (data != null) {
      if (data.isNotEmpty) {

      }
      else {
        data="en";
      }
    }
    else{

      data="en";
    }

    return data;
}



static Future<dynamic>getLanguageData()async
{//LanguageDataEntity
 String d=await rootBundle.loadString("assets/language.json");

dynamic mp=jsonDecode(d.trim());
//LanguageDataEntity

 // LanguageDataEntity lde=LanguageDataEntity.fromJson(mp);

 return mp;





}


}